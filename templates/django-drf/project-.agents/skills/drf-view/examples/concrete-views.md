# Example: Concrete Generic Views (ListCreateAPIView & RetrieveUpdateDestroyAPIView)

Este exemplo demonstra o uso de Concrete Generic Views para cenários CRUD padrão baseados em modelos Django, customizando apenas os hooks nativos (`get_queryset()` e `perform_create()`).

```python
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework import permissions
from apps.orders.models import Order
from apps.orders.serializers import OrderSerializer


class OrderListCreateAPIView(ListCreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = OrderSerializer

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user).select_related("user")

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class OrderDetailAPIView(RetrieveUpdateDestroyAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = OrderSerializer

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user).prefetch_related("items")
```
