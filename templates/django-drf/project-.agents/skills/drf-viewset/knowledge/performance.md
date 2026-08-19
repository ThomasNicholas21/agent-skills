# Knowledge: Paginação, Cache e Throttling em DRF
## 1. Paginação Mandatória
Toda ViewSet de listagem DEVE utilizar paginação explícita para evitar estouro de memória no servidor e travamento no cliente.
```python
from rest_framework.pagination import PageNumberPagination


class StandardResultsSetPagination(PageNumberPagination):
    page_size = 25
    page_size_query_param = "page_size"
    max_page_size = 100
```

## 2. Throttling (Taxa de Limite)
Aplique throttling para prevenir chamadas abusivas em endpoints sensíveis:
```python
from rest_framework.throttling import UserRateThrottle, AnonRateThrottle


class OrderViewSet(viewsets.ModelViewSet):
    throttle_classes = [AnonRateThrottle, UserRateThrottle]
```