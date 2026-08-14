# Example: Escrita Aninhada Manual com transaction.atomic() (Sem Libs Mágicas)

Este exemplo demonstra o padrão seguro para atualização e criação aninhada manual:

```python
from django.db import transaction
from rest_framework import serializers
from apps.orders.models import Order, OrderItem


class OrderItemWriteSerializer(serializers.ModelSerializer):
    id = serializers.UUIDField(required=False)
    unit_price = serializers.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        model = OrderItem
        fields = ["id", "product_name", "unit_price", "quantity"]


class OrderNestedCreateSerializer(serializers.ModelSerializer):
    items = OrderItemWriteSerializer(many=True)

    class Meta:
        model = Order
        fields = ["id", "code", "items"]

    def create(self, validated_data):
        # 1. Extrair os dados aninhados do payload
        items_data = validated_data.pop("items")

        # 2. Gravação manual em bloco atômico (descarta qualquer ID enviado no payload de criação)
        with transaction.atomic():
            order = Order.objects.create(**validated_data)
            order_items = [
                OrderItem(
                    order=order,
                    **{k: v for k, v in item_data.items() if k != "id"}
                )
                for item_data in items_data
            ]
            OrderItem.objects.bulk_create(order_items)

        return order

    def update(self, instance, validated_data):
        items_data = validated_data.pop("items", None)

        with transaction.atomic():
            # 1. Atualizar campos diretos do modelo pai
            for attr, value in validated_data.items():
                setattr(instance, attr, value)
            instance.save()

            # 2. Atualizar coleção aninhada com proteção de ID
            if items_data is not None:
                existing_items = {item.id: item for item in instance.items.all()}
                kept_item_ids = set()
                items_to_create = []

                for item_data in items_data:
                    item_id = item_data.pop("id", None)

                    # Se o ID foi enviado E realmente pertence a este pai: atualiza
                    if item_id and item_id in existing_items:
                        item_obj = existing_items[item_id]
                        for attr, value in item_data.items():
                            setattr(item_obj, attr, value)
                        item_obj.save()
                        kept_item_ids.add(item_id)
                    else:
                        # Se o ID não pertence ao pai ou não foi enviado: descarta ID e agenda novo item
                        items_to_create.append(OrderItem(order=instance, **item_data))

                # Remove da coleção os itens antigos omitidos
                instance.items.exclude(id__in=kept_item_ids).delete()

                # Cria os novos itens com IDs gerados automaticamente pelo banco
                if items_to_create:
                    OrderItem.objects.bulk_create(items_to_create)

        return instance
```
