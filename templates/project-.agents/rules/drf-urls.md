---
trigger:
  glob: "**/{urls.py,urls/**/*.py}"
---

# Regras de Desenvolvimento: DRF URLs & Nested URLs

Ao criar ou editar qualquer arquivo de rotas (`urls.py` ou `nested_urls.py`), agentes e LLMs DEVEM seguir estritamente o padrão de roteamento hierárquico em 3 níveis e a estrutura de **Nested URLs** do projeto.

---

## 1. Roteamento Hierárquico em 3 Níveis

O roteamento de URLs do projeto DEVE seguir esta cascata determinística:

1. **Nível 1 - URL PAI (`core/urls.py`)**: Redireciona a raiz do tráfego de API sob o prefixo `"api/"` para o agregador central.
2. **Nível 2 - Agregador Central de API (`core/api/urls.py`)**: Inclui os arquivos de rotas dos aplicativos sob seus respectivos caminhos.
3. **Nível 3 - Roteador do App (`apps/<app>/api/urls.py`)**: Registra os `ViewSets` em um `DefaultRouter` ou `SimpleRouter` localizado **obrigatoriamente** na subpasta `api/` do aplicativo.

---

## 2. Padrão de Rotas Aninhadas (`Nested URLs` via `drf-nested-routers`)

Para rotear recursos que possuem dependência hierárquica (ex: `/api/orders/{order_pk}/items/{pk}/`), utilize a biblioteca `drf-nested-routers` (`rest_framework_nested.routers`).

### Regras de Nested Routers:
- Instancie o `NestedSimpleRouter` (ou `NestedDefaultRouter`) passando o router pai e definindo o parâmetro `lookup` (ex: `lookup="order"` gerará a chave `order_pk` nos parâmetros da URL).
- No ViewSet filho (`OrderItemViewSet`), o método `get_queryset()` DEVE obrigatoriamente filtrar pelo ID do pai contido em `self.kwargs["order_pk"]`.

---

## 3. Convenções de Nomenclatura & Parâmetros

- **Prefixos de URL**: Sempre em minúsculas, no plural e usando hífens para palavras compostas (ex: `orders/`, `order-items/`).
- **`basename` Obrigatório**: Todo `router.register()` DEVE especificar o argumento `basename` explicitamente para evitar ambiguidades no carregamento de nomes de rotas pelo DRF.

---

## 4. Exemplos Completos de Implementação (Otimizados para Agentes)

### A. Nível 1: `core/urls.py` (URL PAI)

```python
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/", include("core.api.urls")),
]
```

### B. Nível 2: `core/api/urls.py` (Agregador Central da API)

```python
from django.urls import include, path

urlpatterns = [
    path("orders/", include("apps.orders.api.urls")),
    path("users/", include("apps.users.api.urls")),
]
```

### C. Nível 3: `apps/orders/api/urls.py` (Router do App + Nested Router)

```python
from rest_framework_nested import routers
from apps.orders.api.viewsets import OrderItemViewSet, OrderViewSet

# 1. Router Pai (Pedidos)
router = routers.SimpleRouter()
router.register(r"", OrderViewSet, basename="orders")

# 2. Router Filho Aninhado (Itens do Pedido: /orders/{order_pk}/items/)
orders_router = routers.NestedSimpleRouter(router, r"", lookup="order")
orders_router.register(r"items", OrderItemViewSet, basename="order-items")

urlpatterns = router.urls + orders_router.urls
```

### D. ViewSet Filho Tratando a Chave Pai (`apps/orders/api/viewsets.py`)

```python
from rest_framework import mixins, viewsets
from rest_framework.permissions import IsAuthenticated
from apps.orders.api.serializers import OrderItemReadSerializer
from apps.orders.models import OrderItem


class OrderItemViewSet(
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    permission_classes = [IsAuthenticated]
    serializer_class = OrderItemReadSerializer

    def get_queryset(self):
        # OBRIGATÓRIO: Filtrar usando a kwarg do pai gerada pelo Nested Router (order_pk)
        return OrderItem.objects.filter(
            order_id=self.kwargs["order_pk"],
            order__user=self.request.user,
        ).select_related("product")
```
