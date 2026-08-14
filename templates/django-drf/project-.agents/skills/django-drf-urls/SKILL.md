---
name: django-drf-url
description: >-
  Especialista em organização modular de URLs Django/DRF, escolha de Routers (SimpleRouter/DefaultRouter),
  rotas aninhadas (manual vs drf-nested-routers) e isolamento de ViewSets por parent_pk.
---

# DRF & Django URL Skill

Esta habilidade orienta a organização modular de URLs, o registro de ViewSets em Routers e o roteamento de rotas aninhadas em aplicações Django e Django REST Framework.

---

## Quando Ativar Esta Skill

Ative esta skill quando a tarefa envolver:
- Organizar a estrutura de arquivos `urls.py` do projeto e de aplicações modulares.
- Registrar ViewSets em `SimpleRouter` ou `DefaultRouter` definindo `basename`.
- Projetar rotas aninhadas (ex: `/clients/{client_pk}/calculations/{pk}/`).
- Implementar o isolamento de QuerySets e a criação contextual em ViewSets aninhadas usando `self.kwargs["parent_pk"]`.
- Decidir entre rotas aninhadas manuais (`path()` + `include()`) ou usar a biblioteca `drf-nested-routers`.

---

## Índice de Conhecimento Profundo (`knowledge/`)

1. [`knowledge/url-ownership-and-architecture.md`](./knowledge/url-ownership-and-architecture.md): Regra de posse de rotas (Resource Ownership) e modularidade sem dependências circulares.
2. [`knowledge/drf-routers.md`](./knowledge/drf-routers.md): `SimpleRouter` vs `DefaultRouter`, definição de `basename` e `include(router.urls)`.
3. [`knowledge/nested-routes-manual.md`](./knowledge/nested-routes-manual.md): Rotas aninhadas nativas sem bibliotecas via `nested_urls.py` + `path()`.
4. [`knowledge/nested-routes-library.md`](./knowledge/nested-routes-library.md): Rotas aninhadas com `drf-nested-routers` e parâmetro `lookup`.
5. [`knowledge/viewset-parent-scoping.md`](./knowledge/viewset-parent-scoping.md): Proteção de QuerySet (`get_queryset`) e salvamento (`perform_create`) via `self.kwargs["parent_pk"]`.
6. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão para escolha de roteamento e regras estritas.

---

## Exemplos de Código (`examples/`)

- [`examples/modular-urls.md`](./examples/modular-urls.md): Composição de URLs no URLconf principal sem acoplamento entre apps.
- [`examples/manual-nested-routes.md`](./examples/manual-nested-routes.md): Implementação manual completa de rotas aninhadas com `nested_urls.py` e ViewSet isolado.
- [`examples/drf-nested-router-example.md`](./examples/drf-nested-router-example.md): Implementação alternativa com `drf-nested-routers`.

---

## Checklist de Implementação de URLs

1. **Resource Ownership**: O app que possui o recurso filho é dono da definição da URL aninhada?
2. **Sem Acoplamento de Importação**: O app pai evita importar Views ou ViewSets do app filho apenas para criar rotas?
3. **Routers**: Utilizou `SimpleRouter` como padrão, definindo `basename` caso a ViewSet não possua o atributo `queryset` estático?
4. **Isolamento de QuerySet**: O `get_queryset()` da ViewSet aninhada filtra obrigatoriamente pelo `parent_pk` obtido de `self.kwargs`?
5. **Criação Contextual**: O `perform_create()` utiliza o `parent_pk` proveniente da URL em vez de confiar no `request.data`?
