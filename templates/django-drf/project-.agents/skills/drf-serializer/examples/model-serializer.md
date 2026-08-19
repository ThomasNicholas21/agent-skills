# Example: ModelSerializer com Tipos Específicos de Campo
```python
from rest_framework import serializers
from apps.orders.models import Order


class OrderSerializer(serializers.ModelSerializer):
    """
    ModelSerializer para representação de pedidos com campos declarados explicitamente.
    """

    id = serializers.UUIDField(read_only=True)
    total_amount = serializers.DecimalField(max_digits=10, decimal_places=2)
    user_email = serializers.EmailField(source="user.email", read_only=True)

    class Meta:
        model = Order
        fields = ["id", "code", "status", "total_amount", "user_email", "created_at"]
        read_only_fields = ["id", "created_at"]
```