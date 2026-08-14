---
name: drf-viewset
description: >-
  Especialista em construção de ViewSets RESTful (ModelViewSet, ReadOnlyModelViewSet, GenericViewSet)
  utilizando os métodos nativos do ciclo de vida, ações (list, create, etc.) e decoradores @action.
---

# DRF ViewSet Skill

Esta habilidade orienta a construção de ViewSets de alta performance no Django REST Framework para gerenciamento de recursos RESTful.

---

## Quando Ativar Esta Skill

Ative esta skill quando for:
- Criar novos endpoints CRUD baseados em modelos (`ModelViewSet` ou `ReadOnlyModelViewSet`).
- Criar ViewSets com composição fina de ações usando `GenericViewSet` e Mixins (`mixins.ListModelMixin`, `mixins.CreateModelMixin`).
- Adicionar operações customizadas em recursos usando decoradores `@action(detail=True)` ou `@action(detail=False)`.
- Delegar a lógica de busca, scoping e filtros para métodos nativos (`get_queryset`, `get_object`, `get_serializer_class`).
- Injetar persistência contextual ou disparar tarefas em `perform_create`, `perform_update` e `perform_destroy`.

---

## Índice de Conhecimento Profundo (`knowledge/`)

1. [`knowledge/viewset-architecture.md`](./knowledge/viewset-architecture.md): Hierarquia de abstração, ações (`list`, `create`, `retrieve`, `update`, `destroy`) vs handlers HTTP.
2. [`knowledge/lifecycle.md`](./knowledge/lifecycle.md): Ciclo de vida, `self.action`, `self.detail` e disponibilidade de atributos.
3. [`knowledge/generic-viewset-and-mixins.md`](./knowledge/generic-viewset-and-mixins.md): `GenericViewSet`, composição com Mixins, `ModelViewSet` vs `ReadOnlyModelViewSet`.
4. [`knowledge/custom-actions.md`](./knowledge/custom-actions.md): Operações customizadas via `@action(detail=True/False)` e sobrescrita de configurações.
5. [`knowledge/queryset.md`](./knowledge/queryset.md): Scoping de permissões e otimização ORM (`select_related`, `prefetch_related`).
6. [`knowledge/serializers.md`](./knowledge/serializers.md): Troca dinâmica de serializer via `get_serializer_class()` usando `self.action`.
7. [`knowledge/performance.md`](./knowledge/performance.md): Paginação, throttling e caching.
8. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão para escolha de ViewSet e regras estritas.

---

## Exemplos de Código (`examples/`)

- [`examples/basic.md`](./examples/basic.md): `ModelViewSet` limpo para CRUD completo.
- [`examples/readonly.md`](./examples/readonly.md): `ReadOnlyModelViewSet` estrito para endpoints de leitura.
- [`examples/custom-mixins.md`](./examples/custom-mixins.md): `GenericViewSet` com composição fina de Mixins.
- [`examples/actions.md`](./examples/actions.md): ViewSet com operações customizadas via `@action(detail=True)` e `@action(detail=False)`.
- [`examples/optimized.md`](./examples/optimized.md): ViewSet otimizado usando `self.action` em `get_serializer_class()`, `get_permissions()` e `get_queryset()`.

---

## Checklist de Implementação de ViewSet

1. **Sem Métodos HTTP Manuais**: Evitou criar métodos `get()`, `post()`, `put()`, `patch()` ou `delete()` na ViewSet?
2. **Escolha da Classe Base**: Usou `ModelViewSet` para CRUD completo, `ReadOnlyModelViewSet` para leitura, ou `GenericViewSet` + Mixins para composição parcial?
3. **Ciclo de Vida Nativo**: A lógica foi distribuída em `get_queryset`, `get_serializer_class`, `get_permissions` e `perform_create`?
4. **Uso de `self.action`**: Utilizou `self.action` em `get_serializer_class()` e `get_permissions()` em vez de duplicar ViewSets?
5. **Uso de `@action`**: Criou operações específicas usando `@action(detail=True/False)` em vez de criar novas views separadas?
