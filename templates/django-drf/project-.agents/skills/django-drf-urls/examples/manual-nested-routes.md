# Example: Implementação Manual Completa de Rotas Aninhadas Nativas
Este exemplo demonstra a implementação de uma rota aninhada (`/clients/{client_pk}/calculations/`) sem bibliotecas terceiras.

### 1. Arquivo de Rotas Aninhadas do App Filho (`features/calculations/api/nested_urls.py`)
```python
from django.urls import include, path

urlpatterns = [
    path(
        "<uuid:client_pk>/calculations/",
        include("features.calculations.api.urls"),
    ),
]
```

### 2. Arquivo de Rotas Internas do App Filho (`features/calculations/api/urls.py`)
```python
from rest_framework.routers import SimpleRouter
from .views import CalculationViewSet

router = SimpleRouter()
router.register("", CalculationViewSet, basename="client-calculation")

urlpatterns = router.urls
```

### 3. ViewSet Aninhada com Escopo Protegido (`features/calculations/api/views.py`)
```python
from rest_framework import viewsets, permissions
from apps.calculations.models import Calculation
from apps.calculations.serializers import CalculationSerializer


class CalculationViewSet(viewsets.ModelViewSet):
    serializer_class = CalculationSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        # 1. Filtra estritamente os calculos pertencentes ao cliente da URL
        return Calculation.objects.filter(client_id=self.kwargs["client_pk"])

    def perform_create(self, serializer):
        # 2. Injeta a chave estrangeira obtida da URL no salvamento
        serializer.save(client_id=self.kwargs["client_pk"])
```