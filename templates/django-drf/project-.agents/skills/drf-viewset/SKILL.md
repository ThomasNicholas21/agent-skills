---
name: drf-viewset
description: >-
  Especialista em construção de ViewSets RESTful (ModelViewSet, ReadOnlyModelViewSet, GenericViewSet)
  utilizando o ciclo de vida nativo, ações e decoradores @action.
---

# DRF ViewSet Skill
Orienta a construção de ViewSets de alta performance no Django REST Framework para gerenciamento de recursos RESTful.

## Quando Ativar
- Criar novos endpoints CRUD baseados em modelos (`ModelViewSet` ou `ReadOnlyModelViewSet`).
- Criar ViewSets com composição fina usando `GenericViewSet` e Mixins.
- Adicionar operações customizadas usando `@action(detail=True)` ou `@action(detail=False)`.
- Delegar busca, scoping e filtros para métodos nativos (`get_queryset`, `get_object`, `get_serializer_class`).
- Injetar persistência contextual em `perform_create`, `perform_update` e `perform_destroy`.

## Conhecimento (`knowledge/`)
1. [`knowledge/viewset-architecture.md`](./knowledge/viewset-architecture.md): Hierarquia de abstração e ações (`list`, `create`, etc.) vs handlers HTTP.
2. [`knowledge/lifecycle.md`](./knowledge/lifecycle.md): Ciclo de vida e uso de `self.action`.
3. [`knowledge/generic-viewset-and-mixins.md`](./knowledge/generic-viewset-and-mixins.md): `GenericViewSet`, Mixins e `ModelViewSet`.
4. [`knowledge/custom-actions.md`](./knowledge/custom-actions.md): Operações com `@action(detail=True/False)`.
5. [`knowledge/queryset.md`](./knowledge/queryset.md): Scoping de permissões e otimização ORM (`select_related`, `prefetch_related`).
6. [`knowledge/serializers.md`](./knowledge/serializers.md): Troca dinâmica de serializer por `self.action`.
7. [`knowledge/performance.md`](./knowledge/performance.md): Paginação, throttling e caching.
8. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão e proibições.

## Exemplos (`examples/`)
- [`examples/basic.md`](./examples/basic.md): `ModelViewSet` para CRUD completo.
- [`examples/readonly.md`](./examples/readonly.md): `ReadOnlyModelViewSet` para leitura.
- [`examples/custom-mixins.md`](./examples/custom-mixins.md): `GenericViewSet` com composição de Mixins.
- [`examples/actions.md`](./examples/actions.md): Operações customizadas com `@action`.
- [`examples/optimized.md`](./examples/optimized.md): ViewSet otimizado com `self.action` dinâmico.

## Checklist
1. **Sem Handlers HTTP**: Evitou criar `get()`, `post()`, etc., na ViewSet?
2. **Classe Base**: Escolheu a classe ideal (`ModelViewSet`, `ReadOnlyModelViewSet`, `GenericViewSet` + Mixins)?
3. **Ciclo de Vida**: Distribuiu lógica em `get_queryset`, `get_serializer_class`, `get_permissions` e `perform_create`?
4. **Uso de `self.action`**: Utilizou `self.action` para alternar serializers/permissões sem duplicar ViewSets?
5. **Uso de `@action`**: Criou operações específicas com `@action` em vez de views separadas?
