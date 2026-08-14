# Example: schemas.py e @extend_schema_view em APIs HTTP

### Arquivo `apps/categories/api/schemas.py`:

```python
from rest_framework import serializers


class CategoryChildSchema(serializers.Serializer):
    id = serializers.UUIDField()
    name = serializers.CharField()
    slug = serializers.CharField()


class CategoryTreeResponseSchema(serializers.Serializer):
    id = serializers.UUIDField()
    name = serializers.CharField()
    slug = serializers.CharField()
    children = CategoryChildSchema(many=True)


class ErrorResponseSchema(serializers.Serializer):
    detail = serializers.CharField()
    code = serializers.CharField()
```

### Arquivo `apps/categories/views.py`:

```python
from rest_framework import viewsets, permissions
from drf_spectacular.utils import extend_schema, extend_schema_view
from .models import Category
from .serializers import CategorySerializer
from .schemas import CategoryTreeResponseSchema, ErrorResponseSchema


@extend_schema_view(
    list=extend_schema(
        tags=["Categories"],
        summary="Listar categorias hierárquicas em arvore",
        description="Retorna todas as categorias raiz com seus respectivos filhos em formato hierárquico.",
        responses={
            200: CategoryTreeResponseSchema(many=True),
            400: ErrorResponseSchema,
            403: ErrorResponseSchema,
        },
    ),
    retrieve=extend_schema(
        tags=["Categories"],
        summary="Obter detalhes de uma categoria",
        description="Retorna os detalhes de uma categoria específica pelo seu UUID.",
        responses={
            200: CategoryTreeResponseSchema,
            404: ErrorResponseSchema,
        },
    ),
)
class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.filter(parent__isnull=True).prefetch_related("children")
    serializer_class = CategorySerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
```
