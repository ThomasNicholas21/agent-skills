# Knowledge: Uso de Routers no DRF (SimpleRouter vs DefaultRouter)

---

## 1. O que é um DRF Router

O `Router` automatiza o mapeamento entre os métodos HTTP da requisição e as ações do `ViewSet` (`list`, `create`, `retrieve`, `update`, `partial_update`, `destroy` e `@action`).

---

## 2. `SimpleRouter` vs `DefaultRouter`

| Router | Funcionalidades | Recomendação do Agente |
| :--- | :--- | :--- |
| `SimpleRouter` | Gera estritamente as rotas REST padrão dos ViewSets registrados. | **Escolha Padrão**: Use por padrão quando não necessitar da API Root de navegação. |
| `DefaultRouter` | Inclui a rota raiz (`/`) formatada em HTML e suporte a sufixos de formato (`.json`). | Use apenas quando a página de navegação raiz do DRF for um requisito explícito. |

---

## 3. O Parâmetro `basename` no `router.register()`

```python
router.register("clients", ClientViewSet, basename="client")
```

- O `basename` é o prefixo usado pelo DRF para nomear as rotas geradas (ex: `client-list`, `client-detail`).
- **Inferência Automática**: O DRF infere o `basename` automaticamente caso o `ViewSet` possua o atributo estático `queryset` declarado.
- **Obrigatório**: Quando a ViewSet utiliza apenas `get_queryset()` dinâmico e não possui o atributo `queryset` de classe, o parâmetro `basename` DEVE ser informado obrigatoriamente.

---

## 4. Inclusão no URLconf (`include(router.urls)`)

O `router.urls` é uma lista de objetos `URLPattern` do Django e pode ser incluído diretamente através da função `include()`:

```python
from django.urls import include, path
from rest_framework.routers import SimpleRouter
from .views import ClientViewSet

router = SimpleRouter()
router.register("", ClientViewSet, basename="client")

urlpatterns = [
    path("", include(router.urls)),
]
```
