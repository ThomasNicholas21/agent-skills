# Example: GenericAPIView com Customização de Queryset e Serializer

Este exemplo demonstra o uso de `GenericAPIView` quando se necessita do controle de métodos HTTP (`post`) junto com o suporte nativo do DRF a `get_queryset()` e `get_serializer()`.

```python
from rest_framework.generics import GenericAPIView
from rest_framework.response import Response
from rest_framework import status, permissions
from apps.orders.models import Order
from apps.orders.serializers import CheckoutSerializer


class CheckoutProcessAPIView(GenericAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = CheckoutSerializer

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user).select_related("user")

    def post(self, request, *args, **kwargs):
        # Utiliza get_serializer() para instanciar o serializador correto com contexto
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        # Processa e salva o pedido
        order = serializer.save(user=request.user)

        return Response(serializer.data, status=status.HTTP_201_CREATED)
```
