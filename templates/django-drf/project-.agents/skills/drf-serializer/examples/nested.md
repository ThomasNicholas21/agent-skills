# Example: Escrita Aninhada Manual com transaction.atomic() e Proteção de ID
Este exemplo demonstra a implementação manual de `create()` e `update()` em um `ModelSerializer` com coleção aninhada 1:N (`OrderItem`), garantindo que:
- O fluxo de escrita depende do contexto (criação vs. atualização).
- Na **criação**, o `id` dos itens aninhados não é necessário nem considerado.
- Na **atualização**, o `id` opcional mapeia itens existentes daquela instância pai para atualização; IDs inexistentes ou de outro recurso são descartados e tratados como novos registros.
- É mantida a proteção estrita: não é permitido criar ou alterar objetos forçando um `id` informado pelo cliente.

```python
from django.db import transaction
from rest_framework import serializers
from apps.orders.models import Order, OrderItem


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
        # 1. Extrair os dados aninhados do payload
        items_data = validated_data.pop("items")

        # 2. Executar gravação manual e transacional
        with transaction.atomic():
            order = Order.objects.create(**validated_data)
            # Ignora qualquer ID enviado no payload de criação e gera novos registros
            order_items = [
                OrderItem(
                    order=order, **{k: v for k, v in item_data.items() if k != "id"}
                )
                for item_data in items_data
            ]
            OrderItem.objects.bulk_create(order_items)

        return order

    def update(self, instance, validated_data):
        items_data = validated_data.pop("items", None)

        with transaction.atomic():
            # 1. Atualizar campos diretos da instância pai
            for attr, value in validated_data.items():
                setattr(instance, attr, value)
            instance.save()

            # 2. Atualizar coleção aninhada de itens se fornecida no payload
            if items_data is not None:
                # Mapeia apenas os itens pertencentes a ESTE pai
                existing_items = {item.id: item for item in instance.items.all()}
                kept_item_ids = set()
                items_to_create = []

                for item_data in items_data:
                    item_id = item_data.pop("id", None)

                    # Se o ID existe na coleção deste pai: atualiza o registro
                    if item_id and item_id in existing_items:
                        item_obj = existing_items[item_id]
                        for attr, value in item_data.items():
                            setattr(item_obj, attr, value)
                        item_obj.save()
                        kept_item_ids.add(item_id)
                    else:
                        # Se o ID não existia nesta coleção, descarta o ID enviado e agenda criação com novo ID
                        items_to_create.append(OrderItem(order=instance, **item_data))

                # Remove itens antigos que foram omitidos no payload (sincronização)
                instance.items.exclude(id__in=kept_item_ids).delete()

                # Cria novos itens com IDs gerados automaticamente pelo banco
                if items_to_create:
                    OrderItem.objects.bulk_create(items_to_create)

        return instance
```