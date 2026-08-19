# Example: Serializer de Atualização Parcial (Patch)
```python
from rest_framework import serializers
from apps.orders.models import Order


class OrderUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ["status", "is_active"]

    def validate_status(self, value):
        if (
            self.instance
            and self.instance.status == "COMPLETED"
            and value != "COMPLETED"
        ):
            raise serializers.ValidationError(
                "Não é possível alterar o status de um pedido já concluído."
            )
        return value
```