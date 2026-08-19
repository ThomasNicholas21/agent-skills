# Knowledge: Nested Serializers Manuais (Escrita Aninhada sem Libs)

Um **Nested Serializer** utiliza um Serializer como campo dentro de outro.

```python
class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ["bio", "phone"]

class UserSerializer(serializers.ModelSerializer):
    profile = ProfileSerializer()
```

## 1. Regra de Ouro: Sem Bibliotecas Terceiras
É **estritamente proibido** usar bibliotecas mágicas (ex: `drf-writable-nested`). Toda escrita aninhada deve ser implementada manualmente nos métodos `create()` e `update()` do Serializer dentro de `with transaction.atomic():`.

## 2. Comportamento por Fluxo (POST vs PUT/PATCH)
- **Criação (`POST`)**: O payload representa novos dados. Sub-itens não devem exigir nem aceitar `id` forçado. O banco gera os IDs.
- **Atualização (`PUT`/`PATCH`)**: O `id` opcional nos sub-itens permite identificar quais registros atualizar, quais criar e quais remover.

## 3. Proteção contra Forjamento de ID
Ao receber um `id` no item aninhado durante `update()`:
- Verifique se o `id` pertence à coleção do pai (`instance.items.filter(id=item_id)`).
- **Se não pertencer ao pai** (ID forjado ou de outro tenant):
  - **Não altere** o registro correspondente.
  - **Descarte** o ID recebido.
  - **Crie** um novo registro com novo ID gerado pelo sistema.

## 4. Padrão Transacional Canônico
```python
from django.db import transaction
from rest_framework import serializers

class OrderItemWriteSerializer(serializers.ModelSerializer):
    id = serializers.UUIDField(required=False)

    class Meta:
        model = OrderItem
        fields = ["id", "product_name", "unit_price", "quantity"]

class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemWriteSerializer(many=True)

    class Meta:
        model = Order
        fields = ["id", "code", "items"]

    @transaction.atomic
    def create(self, validated_data):
        items_data = validated_data.pop("items", [])
        order = Order.objects.create(**validated_data)
        for item_data in items_data:
            item_data.pop("id", None)
            OrderItem.objects.create(order=order, **item_data)
        return order

    @transaction.atomic
    def update(self, instance, validated_data):
        items_data = validated_data.pop("items", None)
        instance = super().update(instance, validated_data)
        if items_data is not None:
            existing_items = {item.id: item for item in instance.items.all()}
            retained_ids = set()
            for item_data in items_data:
                item_id = item_data.pop("id", None)
                if item_id and item_id in existing_items:
                    item_obj = existing_items[item_id]
                    for attr, value in item_data.items():
                        setattr(item_obj, attr, value)
                    item_obj.save()
                    retained_ids.add(item_obj.id)
                else:
                    new_item = OrderItem.objects.create(order=instance, **item_data)
                    retained_ids.add(new_item.id)
            # Remove itens omitidos
            instance.items.exclude(id__in=retained_ids).delete()
        return instance
```
