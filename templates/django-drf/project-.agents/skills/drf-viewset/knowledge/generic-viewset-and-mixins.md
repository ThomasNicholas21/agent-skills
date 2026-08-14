# Knowledge: GenericViewSet, Mixins, ModelViewSet e ReadOnlyModelViewSet

---

## 1. `GenericViewSet`

`GenericViewSet` herda de `GenericAPIView` e adiciona a infraestrutura de ViewSet (suporte a routers e ações), **mas não possui nenhuma ação CRUD padrão habilitada por padrão**.

```python
from rest_framework import viewsets, mixins

class UserViewSet(viewsets.GenericViewSet):
    # Não possui list(), create(), retrieve(), update() ou destroy() automaticamente
    pass
```

---

## 2. Composição Fina com Mixins

Ao herdar de `GenericViewSet`, você adiciona explicitamente apenas as ações permitidas usando Mixins:

- `GenericViewSet` + `mixins.ListModelMixin` → Habilita apenas `list()` (GET /collection/)
- `GenericViewSet` + `mixins.CreateModelMixin` → Habilita apenas `create()` (POST /collection/)
- `GenericViewSet` + `mixins.RetrieveModelMixin` → Habilita apenas `retrieve()` (GET /detail/)
- `GenericViewSet` + `mixins.UpdateModelMixin` → Habilita apenas `update()` (PUT) e `partial_update()` (PATCH)
- `GenericViewSet` + `mixins.DestroyModelMixin` → Habilita apenas `destroy()` (DELETE)

---

## 3. `ModelViewSet`

`ModelViewSet` é uma conveniência que combina `GenericViewSet` com **todos os 5 Mixins CRUD**:

```text
ModelViewSet = GenericViewSet + ListModelMixin + CreateModelMixin + RetrieveModelMixin + UpdateModelMixin + DestroyModelMixin
```

- **Quando Usar**: Quando o recurso necessita de suporte CRUD completo e convencional sem restrições de ações.

---

## 4. `ReadOnlyModelViewSet`

`ReadOnlyModelViewSet` combina `GenericViewSet` apenas com operações de leitura:

```text
ReadOnlyModelViewSet = GenericViewSet + ListModelMixin + RetrieveModelMixin
```

- **Quando Usar**: Quando o recurso deve ser consultado publicamente ou via API, mas NUNCA modificado por endpoints de escrita.
- **Regra para Agente**: NUNCA utilize `ModelViewSet` para depois bloquear manualmente `create`, `update` e `destroy`. Se o recurso for apenas leitura, herde diretamente de `ReadOnlyModelViewSet`.
