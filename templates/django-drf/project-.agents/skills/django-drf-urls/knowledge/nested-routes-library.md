# Knowledge: Rotas Aninhadas com a Biblioteca `drf-nested-routers`

Para projetos que possuem múltiplos níveis de aninhamento ou exigem a geração automática de rotas encadeadas via Routers, a biblioteca `drf-nested-routers` pode ser utilizada como alternativa.

---

## 1. Instalação
```bash
pip install drf-nested-routers
```
> Nota: Não é necessário adicionar a `INSTALLED_APPS` no `settings.py`, pois a biblioteca fornece apenas utilitários de roteamento.

---

## 2. Uso do `NestedSimpleRouter` e Parâmetro `lookup`

```python
from rest_framework import routers
from rest_framework_nested import routers as nested_routers
from features.clients.api.views import ClientViewSet
from features.calculations.api.views import CalculationViewSet

# 1. Router Pai
router = routers.SimpleRouter()
router.register("clients", ClientViewSet, basename="client")

# 2. Router Aninhado (Filho)
client_router = nested_routers.NestedSimpleRouter(
    router,
    r"clients",
    lookup="client"
)
client_router.register(
    r"calculations",
    CalculationViewSet,
    basename="client-calculations"
)

urlpatterns = [
    *router.urls,
    *client_router.urls,
]
```

---

## 3. A Importância do Parâmetro `lookup`

O parâmetro `lookup="client"` no `NestedSimpleRouter` define o nome do parâmetro capturado na URL:
- `lookup="client"` ──> gera o parâmetro `<client_pk>` na URL.
- O ViewSet filho acessa o parâmetro via `self.kwargs["client_pk"]`.

| Recurso Pai | Valor de `lookup` | Parâmetro Capturado em `kwargs` |
| :--- | :--- | :--- |
| `clients` | `lookup="client"` | `self.kwargs["client_pk"]` |
| `orders` | `lookup="order"` | `self.kwargs["order_pk"]` |
| `projects` | `lookup="project"` | `self.kwargs["project_pk"]` |
