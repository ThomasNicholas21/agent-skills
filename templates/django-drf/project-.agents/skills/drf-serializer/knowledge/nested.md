# Knowledge: Escrita Aninhada Transacional e Proteção de ID em Serializers

Ao manipular relacionamentos 1:N ou N:N dentro dos métodos `create()` ou `update()` do Serializer:

---

## 1. Análise do Fluxo do Negócio
A implementação da escrita aninhada **depende estritamente do fluxo**:
- **Criação (`POST`)**: Não exige nem aceita a imposição de `id` para os itens aninhados. O banco de dados gera os IDs automaticamente.
- **Atualização (`PUT`/`PATCH`)**: O `id` opcional nos itens aninhados permite identificar quais objetos da coleção pertencente ao pai devem ser atualizados, quais novos itens devem ser criados e quais omitidos devem ser deletados.

---

## 2. Proteção Estrita contra Forjamento de ID
- Se um `id` for enviado no item aninhado durante o `update()`, o backend deve verificar se ele existe na coleção pertencente ao pai (`instance.items.filter(id=item_id)`).
- **Caso o `id` informado não exista no pai** (ID forjado ou pertencente a outro objeto/tenant):
  - **NÃO altera** o objeto referente ao ID informado.
  - **DESCARTA** o ID enviado (não força a gravação do ID no banco).
  - **CRIA** o registro como um novo item com um novo ID gerado pelo sistema.
- **Regra**: Não é permitido alterar ou criar um objeto com um ID informado pelo cliente.

---

## 3. Uso Mandatório de `transaction.atomic()`
Toda gravação aninhada deve ser encapsulada em `with transaction.atomic():` para garantir rollback completo caso ocorra qualquer falha.

---

## 4. Padrão Recomendado

```python
from django.db import transaction
from rest_framework import serializers

class OrderItemWriteSerializer(serializers.ModelSerializer):
    id = serializers.UUIDField(required=False)

    class Meta:
        model = OrderItem
        fields = ["id", "product_name", "unit_price", "quantity"]

class OrderNestedSerializer(serializers.ModelSerializer):
    items = OrderItemWriteSerializer(many=True)

    class Meta:
        model = Order
        fields = ["id", "code", "items"]

    def create(self, validated_data):
        items_data = validated_data.pop("items")
        with transaction.atomic():
            order = Order.objects.create(**validated_data)
            # Na criação, descarte qualquer ID enviado e crie novos itens
            order_items = [
                OrderItem(order=order, **{k: v for k, v in item.items() if k != "id"})
                for item in items_data
            ]
            OrderItem.objects.bulk_create(order_items)
        return order

    def update(self, instance, validated_data):
        items_data = validated_data.pop("items", None)
        with transaction.atomic():
            for attr, value in validated_data.items():
                setattr(instance, attr, value)
            instance.save()

            if items_data is not None:
                existing_items = {item.id: item for item in instance.items.all()}
                kept_ids = set()
                new_items = []

                for item_data in items_data:
                    item_id = item_data.pop("id", None)
                    if item_id and item_id in existing_items:
                        item_obj = existing_items[item_id]
                        for attr, value in item_data.items():
                            setattr(item_obj, attr, value)
                        item_obj.save()
                        kept_ids.add(item_id)
                    else:
                        # ID não pertence a este pai: descarta o ID e agenda criação
                        new_items.append(OrderItem(order=instance, **item_data))

                instance.items.exclude(id__in=kept_ids).delete()
                if new_items:
                    OrderItem.objects.bulk_create(new_items)
        return instance
```
