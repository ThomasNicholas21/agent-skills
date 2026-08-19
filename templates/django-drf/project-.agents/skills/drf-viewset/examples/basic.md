# Example: ModelViewSet Limpo (CRUD Completo)
```python
from rest_framework import viewsets, permissions
from apps.products.models import Product
from apps.products.serializers import ProductSerializer


class ProductViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gerenciamento completo do recurso Product.
    Fornece automaticamente: list, create, retrieve, update, partial_update, destroy.
    """

    queryset = Product.objects.filter(is_active=True)
    serializer_class = ProductSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
```