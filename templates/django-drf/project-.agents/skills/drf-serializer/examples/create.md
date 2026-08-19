# Example: Serializer Focado em Criação e Validação
```python
from rest_framework import serializers
from apps.orders.models import Order


class OrderCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ["code", "total_amount"]

    def validate_code(self, value):
        if not value.isalnum():
            raise serializers.ValidationError(
                "O código do pedido deve conter apenas caracteres alfanuméricos."
            )
        return value.upper()

    def validate_total_amount(self, value):
        if value <= 0:
            raise serializers.ValidationError(
                "O valor total do pedido deve ser maior que zero."
            )
        return value
```