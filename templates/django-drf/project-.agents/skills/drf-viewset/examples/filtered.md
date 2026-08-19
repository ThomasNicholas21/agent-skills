# Example: ViewSet com django-filter e Busca
```python
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, filters, permissions
from apps.orders.models import Order
from apps.orders.serializers import OrderSerializer


class OrderFilterViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = OrderSerializer
    filter_backends = [
        DjangoFilterBackend,
        filters.SearchFilter,
        filters.OrderingFilter,
    ]
    filterset_fields = ["status", "is_active"]
    search_fields = ["code", "user__email"]
    ordering_fields = ["created_at", "total_amount"]

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user).select_related("user")
```