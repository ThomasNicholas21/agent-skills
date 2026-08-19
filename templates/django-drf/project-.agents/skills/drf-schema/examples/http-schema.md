# Example: Documentação OpenAPI com drf-spectacular em HTTP

```python
# apps/orders/schemas.py
from rest_framework import serializers

class OrderSummarySchema(serializers.Serializer):
    """Schema dedicado exclusivamente à documentação OpenAPI."""
    total_orders = serializers.IntegerField()
    total_revenue = serializers.DecimalField(max_digits=12, decimal_places=2)


# apps/orders/views.py
from drf_spectacular.utils import extend_schema, extend_schema_view
from rest_framework import viewsets
from apps.orders.models import Order
from apps.orders.serializers import OrderSerializer
from apps.orders.schemas import OrderSummarySchema

@extend_schema_view(
    list=extend_schema(
        tags=["Orders"],
        summary="Listar pedidos",
        description="Retorna lista paginada de pedidos do usuário autenticado.",
    ),
    create=extend_schema(
        tags=["Orders"],
        summary="Criar pedido",
        description="Cria novo pedido com itens aninhados.",
        responses={201: OrderSerializer},
    ),
)
class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
```
