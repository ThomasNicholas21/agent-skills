# Example: GenericAPIView com Mixins Específicos

Este exemplo demonstra a composição manual de `GenericAPIView` com Mixins (`ListModelMixin`, `CreateModelMixin`) quando apenas combinações específicas de ações de recurso são necessárias.

```python
from rest_framework.generics import GenericAPIView
from rest_framework.mixins import ListModelMixin, CreateModelMixin
from rest_framework import permissions
from apps.products.models import Product
from apps.products.serializers import ProductSerializer


class ProductListCreateAPIView(ListModelMixin, CreateModelMixin, GenericAPIView):
    queryset = Product.objects.filter(is_active=True)
    serializer_class = ProductSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)
```
