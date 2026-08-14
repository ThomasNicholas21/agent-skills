# Knowledge: Rotas Aninhadas Nativas sem Bibliotecas (`path` + `include`)

O Django REST Framework não possui um router aninhado oficial integrado. O padrão arquitetural recomendado para projetos modulares é utilizar a combinação nativa de `path()` e `include()` do Django.

---

## 1. Conceito de Rota Aninhada

Uma rota aninhada comunica um relacionamento semântico de pertencimento entre um recurso pai e um recurso filho:

```text
/clients/{client_pk}/calculations/
/clients/{client_pk}/calculations/{pk}/
```

- **Nested URL**: Organização da rota HTTP (`/clients/{client_pk}/calculations/`).
- **Nested Serializer**: Representação dos dados no JSON (`{"client": {...}, "calculations": [...]}`).
- Ambas são escolhas independentes. Uma rota aninhada NÃO exige um Nested Serializer.

---

## 2. Estrutura Padrão com `nested_urls.py`

O app do recurso filho (ex: `calculations`) define seu próprio arquivo `nested_urls.py`:

```python
# features/calculations/api/nested_urls.py
from django.urls import include, path

urlpatterns = [
    path(
        "<uuid:client_pk>/calculations/",
        include("features.calculations.api.urls"),
    ),
]
```

E no `urls.py` do app filho:

```python
# features/calculations/api/urls.py
from rest_framework.routers import SimpleRouter
from .views import CalculationViewSet

router = SimpleRouter()
router.register("", CalculationViewSet, basename="client-calculation")

urlpatterns = router.urls
```

E no URLconf principal (`core/api/urls.py`):

```python
# core/api/urls.py
from django.urls import include, path

urlpatterns = [
    path("clients/", include("features.clients.api.urls")),
    path("clients/", include("features.calculations.api.nested_urls")),
]
```

---

## 3. Vantagens da Abordagem Nativa
- **Zero Dependências Terceiras**: Não requer pacotes adicionais.
- **Baixo Acoplamento**: O app `clients` não precisa importar nem conhecer a existência do app `calculations`.
- **Controle Total**: Transparência e controle explícito sobre conversores de URL (`uuid`, `int`, `slug`).
