# Knowledge: GenericViewSet e Mixins no DRF

## 1. `GenericViewSet`
Herda de `GenericAPIView` e adiciona o roteamento por ações (`list`, `create`, etc.), mas sem nenhuma ação CRUD habilitada por padrão.

## 2. Composição com Mixins
Permite habilitar apenas operações autorizadas para o recurso:
```python
from rest_framework import viewsets, mixins


class OrderAuditViewSet(
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    """Permite apenas listagem e busca por ID (sem criar, atualizar ou deletar)."""

    queryset = OrderAudit.objects.all()
    serializer_class = OrderAuditSerializer
```

## 3. `ModelViewSet` vs `ReadOnlyModelViewSet`
- `ReadOnlyModelViewSet` = `ListModelMixin` + `RetrieveModelMixin` + `GenericViewSet`.
- `ModelViewSet` = CRUD completo (`List`, `Create`, `Retrieve`, `Update`, `Destroy`).
- Use `ReadOnlyModelViewSet` ou `GenericViewSet` + Mixins para expor apenas o necessário.