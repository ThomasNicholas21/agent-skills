# Example: ReadOnlyModelViewSet (Somente Leitura)

```python
from rest_framework import viewsets, permissions
from apps.products.models import Category
from apps.products.serializers import CategorySerializer


class CategoryViewSet(viewsets.ReadOnlyModelViewSet):
    """
    ViewSet somente leitura.
    Fornece apenas as acoes: list e retrieve (GET collection / GET detail).
    """
    queryset = Category.objects.filter(is_active=True)
    serializer_class = CategorySerializer
    permission_classes = [permissions.AllowAny]
```
