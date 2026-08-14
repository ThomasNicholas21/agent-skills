# Example: ViewSet Otimizado com self.action

Este exemplo demonstra como utilizar `self.action` para alterar dinamicamente a classe de serializador (`get_serializer_class()`), as permissões (`get_permissions()`) e a consulta ORM (`get_queryset()`).

```python
from rest_framework import viewsets, permissions
from apps.orders.models import Order
from apps.orders.serializers import (
    OrderListSerializer,
    OrderDetailSerializer,
    OrderCreateSerializer,
)


class OptimizedOrderViewSet(viewsets.ModelViewSet):
    def get_queryset(self):
        queryset = Order.objects.filter(user=self.request.user)
        if self.action == "list":
            return queryset.select_related("user").only(
                "id", "code", "status", "total_amount", "created_at", "user__email"
            )
        if self.action == "retrieve":
            return queryset.select_related("user").prefetch_related("items__product")
        return queryset

    def get_serializer_class(self):
        if self.action == "list":
            return OrderListSerializer
        if self.action in ["create", "update", "partial_update"]:
            return OrderCreateSerializer
        return OrderDetailSerializer

    def get_permissions(self):
        if self.action in ["destroy"]:
            return [permissions.IsAdminUser()]
        return [permissions.IsAuthenticated()]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
```
