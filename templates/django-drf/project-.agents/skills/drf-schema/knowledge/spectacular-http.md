# Knowledge: Documentação HTTP OpenAPI com DRF Spectacular

---

## 1. Responsabilidade do `schemas.py`
- Contém Serializers/Schemas criados **estritamente para documentação OpenAPI** ou para representar payloads de resposta que o `serializers.py` de modelo não consegue expor (ex: árvores com `children`, relatórios agregados).

---

## 2. Padrão `@extend_schema_view` em ViewSets

Use no topo da classe ViewSet para mapear cada ação:

```python
from drf_spectacular.utils import extend_schema, extend_schema_view
from .schemas import CategoryTreeResponseSchema, ErrorResponseSchema

@extend_schema_view(
    list=extend_schema(
        tags=["Categories"],
        summary="Listar categorias hierárquicas",
        description="Retorna a lista de categorias em formato de árvore com os seus filhos (children).",
        responses={
            200: CategoryTreeResponseSchema(many=True),
            401: ErrorResponseSchema,
            403: ErrorResponseSchema,
        }
    ),
    create=extend_schema(
        tags=["Categories"],
        summary="Criar nova categoria",
        description="Cria uma nova categoria base.",
        responses={201: CategoryTreeResponseSchema, 400: ErrorResponseSchema}
    )
)
class CategoryViewSet(viewsets.ModelViewSet):
    ...
```

---

## 3. O parâmetro `request`
- Não é necessário especificar `request` no `@extend_schema` se a ViewSet já define `serializer_class`, pois o `drf-spectacular` descobre automaticamente.
- Especifique `request=CustomInputSerializer` apenas quando a requisição aceitar um formato diferente do serializer padrão.
