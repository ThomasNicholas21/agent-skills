---
trigger:
  glob: "**/*"
---

# Regras de Arquitetura e Estruturação de Projetos Django

Ao criar, editar ou organizar arquivos e diretórios em projetos Django / DRF, você DEVE seguir estritamente as regras de arquitetura e roteamento estruturado abaixo.

---

## 1. Estrutura Global de Diretórios

O projeto DEVE ser organizado separando a pasta central do projeto (`core/`) dos aplicativos de funcionalidade (`features/`):

```text
meu_projeto/
├── manage.py
├── core/                       # Pasta central do projeto (Settings & Root Routing)
│   ├── settings.py
│   ├── urls.py                 # URL PAI (Inclui a API central sob o prefixo "api/")
│   ├── wsgi.py
│   └── api/                    # Diretório central de roteamento de API
│       ├── __init__.py
│       └── urls.py             # Agrega as URLs de API de todos os apps
└── features/                   # Diretório contendo os apps do projeto
    └── orders/                 # Exemplo de App do Projeto
        ├── models.py           # Modelos de Banco de Dados
        ├── admin.py            # Customizações do Django Admin
        ├── services.py         # Regras de Negócio e Service Layer
        └── api/                # PASTA EXCLUSIVA DA CAMADA DE API DO APP
            ├── __init__.py
            ├── urls.py         # Roteamento interno do app (Routers / ViewSets)
            ├── viewsets.py     # ViewSets (Somente orquestração HTTP)
            ├── serializers.py  # Serializers de Leitura e Escrita
            └── filters.py      # Filtros DRF / django-filter
```

---

## 2. Isolamento da Camada de API nos Apps

- **PASTA `api/` OBRIGATÓRIA**: Todo aplicativo Django que expõe endpoints HTTP deve conter um subdiretório `api/`.
- É **PROIBIDO** colocar `views.py`, `viewsets.py`, `serializers.py` ou `urls.py` na raiz do app.
- **Divisão de Responsabilidades no App**:
  - `models.py`: Estrutura de tabelas, `QuerySet` e `Manager`.
  - `admin.py`: Configurações de `ModelAdmin` com prevenção de N+1.
  - `services.py`: Regras de negócio puras, transações atômicas e integrações.
  - `api/viewsets.py`: Trata HTTP, autenticação, permissões e chama o `services.py`.
  - `api/serializers.py`: Contém `ReadSerializer` e `WriteSerializer` separados.
  - `api/filters.py`: Classes de filtros customizadas (`FilterSet`).
  - `api/urls.py`: Configura os roteadores do DRF (`SimpleRouter`).

---

## 3. Roteamento Hierárquico em Cascata

O roteamento de URLs deve seguir um fluxo estrito em 3 níveis:

1. **`core/urls.py` (URL PAI)**: Redireciona todas as chamadas `api/` para `core.api.urls`.
2. **`core/api/urls.py` (Agregador de API)**: Inclui os arquivos `api.urls` de cada app com seus respectivos prefixos.
3. **`apps/<app>/api/urls.py` (Roteador do App)**: Registra os `ViewSets` em um `SimpleRouter` e expõe `urlpatterns`.

---

## 4. Abordagem de Package: Quando um Arquivo Cresce Demais

Quando um arquivo único (`models.py`, `services.py`, `serializers.py`, etc.) ultrapassa **~300 linhas** ou acumula **responsabilidades de domínios distintos**, ele DEVE ser convertido em um **Python package** (diretório com `__init__.py`).

A conversão é feita **somente quando necessário**. Arquivos pequenos e coesos NÃO devem ser divididos preventivamente (YAGNI).

### Estrutura antes (arquivo único):

```text
orders/
├── models.py          # 500+ linhas, 4 models misturados
├── services.py
└── api/
    └── serializers.py # 400+ linhas, 6 serializers
```

### Estrutura depois (package):

```text
orders/
├── models/
│   ├── __init__.py    # Re-exporta todos os models para manter imports externos inalterados
│   ├── order.py       # Order, OrderQuerySet, OrderManager
│   └── order_item.py  # OrderItem, OrderItemQuerySet, OrderItemManager
├── services/
│   ├── __init__.py
│   ├── order_service.py
│   └── payment_service.py
└── api/
    ├── serializers/
    │   ├── __init__.py
    │   ├── order_serializers.py
    │   └── order_item_serializers.py
    └── viewsets/
        ├── __init__.py
        ├── order_viewset.py
        └── order_item_viewset.py
```

### Regras para a Conversão:

- O `__init__.py` DEVE re-exportar todos os símbolos públicos para que **imports externos não quebrem**.
- Cada arquivo dentro do package DEVE conter **uma única responsabilidade** (um model, um service, um serializer ou grupo coeso).
- A estrutura de package NÃO altera a hierarquia de diretórios do app, apenas substitui o arquivo pelo diretório de mesmo nome.

### Exemplo de `__init__.py` com re-export:

```python
# orders/models/__init__.py
from .order import Order, OrderQuerySet, OrderManager
from .order_item import OrderItem, OrderItemQuerySet, OrderItemManager

__all__ = [
    "Order",
    "OrderQuerySet",
    "OrderManager",
    "OrderItem",
    "OrderItemQuerySet",
    "OrderItemManager",
]
```
