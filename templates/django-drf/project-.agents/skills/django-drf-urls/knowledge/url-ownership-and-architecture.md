# Knowledge: Arquitetura de URLs e Regra de Posse de Rotas (Resource Ownership)

---

## 1. Conceito de Regra de Posse de Rotas (Resource Ownership)

> **Regra de Ouro**: A aplicação que possui o recurso filho DEVE ser a dona da configuração de URL desse recurso filho. O URLconf raiz (`core/api/urls.py`) atua exclusivamente como ponto de composição (*Composition Root*).

```text
Core URLconf (Composition Root)
   │
   ├── path("clients/", include("features.clients.api.urls"))
   └── path("clients/", include("features.calculations.api.nested_urls"))
```

---

## 2. Prevenção de Acoplamento e Dependência Circular

### O Problema do Acoplamento Direto
Importar ViewSets do app filho dentro do app pai apenas para registrar a rota no router do pai (ex: `from features.calculations.api.views import CalculationViewSet` dentro de `features/clients/api/urls.py`) cria um acoplamento indesejado entre domínios.

### A Solução Modular (Prefixo Compartilhado)
O Django permite que múltiplos apps compartilhem o mesmo prefixo de URL no URLconf raiz. Cada app expõe seu próprio `urls.py` ou `nested_urls.py`:

- App `clients`: gerencia `/clients/` e `/clients/{pk}/`.
- App `calculations`: gerencia `/clients/{client_pk}/calculations/` e `/clients/{client_pk}/calculations/{pk}/`.

Desta forma, o app `clients` não precisa importar nem conhecer a existência do app `calculations`.

---

## 3. Diretrizes de Organização por Domínio

```text
features/
├── clients/
│   └── api/
│       └── urls.py           ──> Registra ClientViewSet em /clients/
└── calculations/
    └── api/
        ├── urls.py           ──> Registra CalculationViewSet em /
        └── nested_urls.py    ──> Mapeia <uuid:client_pk>/calculations/ chamando urls.py
```
