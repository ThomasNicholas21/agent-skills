# Knowledge: Operações Customizadas com @action em ViewSets

Para operações que pertencem ao recurso mas estão fora do CRUD padrão, use o decorador `@action`.

## 1. `@action(detail=True)` (Ação em Nível de Objeto)
Opera sobre um recurso específico (`/orders/{pk}/cancel/`):
```python
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status


class OrderViewSet(viewsets.ModelViewSet):
    @action(detail=True, methods=["post"], url_path="cancel")
    def cancel(self, request, pk=None):
        order = self.get_object()
        order.cancel()
        return Response({"status": "cancelled"}, status=status.HTTP_200_OK)
```

## 2. `@action(detail=False)` (Ação em Nível de Coleção)
Opera sobre o conjunto de recursos (`/orders/recent/`):
```python
class OrderViewSet(viewsets.ModelViewSet):
    @action(detail=False, methods=["get"], url_path="recent")
    def recent(self, request):
        recent_orders = self.get_queryset()[:5]
        serializer = self.get_serializer(recent_orders, many=True)
        return Response(serializer.data)
```

## 3. Sobrescrita de Configurações na Action
É possível sobrescrever `serializer_class`, `permission_classes` e `authentication_classes` por `@action`:
```python
@action(detail=True, methods=["post"], serializer_class=CancelOrderSerializer)
def cancel(self, request, pk=None): ...
```