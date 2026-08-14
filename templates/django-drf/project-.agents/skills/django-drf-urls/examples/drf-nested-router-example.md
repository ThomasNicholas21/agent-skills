# Example: Rotas Aninhadas com a Biblioteca drf-nested-routers

Este exemplo demonstra o uso opcional da biblioteca `drf-nested-routers` para rotas aninhadas baseadas em routers.

```python
from rest_framework import routers
from rest_framework_nested import routers as nested_routers
from features.clients.api.views import ClientViewSet
from features.calculations.api.views import CalculationViewSet

# 1. Router principal (Pai)
router = routers.SimpleRouter()
router.register("clients", ClientViewSet, basename="client")

# 2. Router aninhado (Filho)
client_router = nested_routers.NestedSimpleRouter(
    router,
    r"clients",
    lookup="client"  # Gera o parametro self.kwargs["client_pk"] na ViewSet
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
