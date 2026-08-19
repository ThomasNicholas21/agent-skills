---
name: django-drf-url
description: >-
  Especialista em organização modular de URLs Django/DRF, escolha de Routers (SimpleRouter/DefaultRouter),
  rotas aninhadas (manual vs drf-nested-routers) e isolamento de ViewSets por parent_pk.
---

# DRF & Django URL Skill
Orienta a organização modular de URLs, registro de ViewSets em Routers e roteamento aninhado no Django e DRF.

## Quando Ativar
- Organizar a estrutura de arquivos `urls.py` de projetos e apps modulares.
- Registrar ViewSets em `SimpleRouter` definindo `basename`.
- Projetar rotas aninhadas (ex: `/clients/{client_pk}/calculations/{pk}/`).
- Implementar isolamento de QuerySets e criação contextual usando `self.kwargs["parent_pk"]`.
- Escolher entre rotas aninhadas manuais (`path()` + `include()`) ou `drf-nested-routers`.

## Conhecimento (`knowledge/`)
1. [`knowledge/url-ownership-and-architecture.md`](./knowledge/url-ownership-and-architecture.md): Posse de rotas (Resource Ownership) sem dependências circulares.
2. [`knowledge/drf-routers.md`](./knowledge/drf-routers.md): `SimpleRouter` vs `DefaultRouter` e definição de `basename`.
3. [`knowledge/nested-routes-manual.md`](./knowledge/nested-routes-manual.md): Rotas aninhadas nativas via `nested_urls.py` + `path()`.
4. [`knowledge/nested-routes-library.md`](./knowledge/nested-routes-library.md): Rotas aninhadas com `drf-nested-routers`.
5. [`knowledge/viewset-parent-scoping.md`](./knowledge/viewset-parent-scoping.md): Scoping de QuerySet e salvamento via `self.kwargs["parent_pk"]`.
6. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão e proibições.

## Exemplos (`examples/`)
- [`examples/modular-urls.md`](./examples/modular-urls.md): Composição de URLs sem acoplamento entre apps.
- [`examples/manual-nested-routes.md`](./examples/manual-nested-routes.md): Rotas aninhadas manuais com `nested_urls.py`.
- [`examples/drf-nested-router-example.md`](./examples/drf-nested-router-example.md): Exemplo com `drf-nested-routers`.

## Checklist
1. **Resource Ownership**: O app do recurso filho define a URL aninhada?
2. **Sem Acoplamento**: O app pai evita importar Views do app filho para montar rotas?
3. **Routers**: Usou `SimpleRouter` e definiu `basename` quando não há `queryset` estático?
4. **Isolamento de QuerySet**: O `get_queryset()` filtra obrigatoriamente por `self.kwargs["parent_pk"]`?
5. **Criação Contextual**: O `perform_create()` utiliza o `parent_pk` da URL em vez de confiar no body?