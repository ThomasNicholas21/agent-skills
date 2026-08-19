# Knowledge: Rotas Aninhadas Nativas (Sem Bibliotecas)

Permite construir rotas aninhadas com `path()` e `include()` padrão do Django sem dependências externas.

## 1. Estrutura do App Filho (`nested_urls.py`)
```python
# apps/calculations/nested_urls.py
from django.urls import path, include
from rest_framework.routers import SimpleRouter
from apps.calculations.views import CalculationViewSet

router = SimpleRouter()
router.register(r"", CalculationViewSet, basename="client-calculations")

urlpatterns = [
    path("", include(router.urls)),
]
```

## 2. Inclusão no App Pai ou Principal
```python
# config/urls.py ou apps/clients/urls.py
from django.urls import path, include

urlpatterns = [
    # Rotas normais do client
    path("api/clients/", include("apps.clients.urls")),
    # Rota aninhada montada pelo app filho
    path("api/clients/<uuid:client_pk>/calculations/", include("apps.calculations.nested_urls")),
]
```

## 3. Scoping no ViewSet Filho
```python
class CalculationViewSet(viewsets.ModelViewSet):
    serializer_class = CalculationSerializer

    def get_queryset(self):
        return Calculation.objects.filter(client_id=self.kwargs["client_pk"])

    def perform_create(self, serializer):
        serializer.save(client_id=self.kwargs["client_pk"])
```