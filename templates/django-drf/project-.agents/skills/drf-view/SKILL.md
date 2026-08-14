---
name: drf-view
description: >-
  Especialista em seleção, arquitetura e construção de Views no DRF (APIView, GenericAPIView, Mixins e Concrete Generic Views).
---

# DRF View Skill (`APIView` & `GenericAPIView`)

Esta habilidade orienta a seleção e a implementação de Views no Django REST Framework respeitando a hierarquia de abstração e composição de componentes do framework.

---

## Quando Ativar Esta Skill

Ative esta skill quando for:
- Escolher a abstração ideal de View (`APIView`, `GenericAPIView`, `ListCreateAPIView`, etc.).
- Criar endpoints estilo RPC ou comandos de ação única usando `APIView`.
- Implementar `GenericAPIView` com customizações em `get_queryset()`, `get_object()` ou `get_serializer_class()`.
- Utilizar Concrete Generic Views (`ListCreateAPIView`, `RetrieveUpdateDestroyAPIView`) ou compor com Mixins.

---

## Índice de Conhecimento Profundo (`knowledge/`)

1. [`knowledge/apiview.md`](./knowledge/apiview.md): Conceitos fundamentais, atributos de política e manipuladores HTTP no `APIView`.
2. [`knowledge/apiview-lifecycle.md`](./knowledge/apiview-lifecycle.md): Fluxo do `dispatch()`, métodos internos de política e tratamento de exceções.
3. [`knowledge/generic-views.md`](./knowledge/generic-views.md): `GenericAPIView`, atributos principais e métodos fundamentais (`get_queryset`, `get_object`, etc.).
4. [`knowledge/mixins-and-concrete-views.md`](./knowledge/mixins-and-concrete-views.md): Mixins vs Handlers HTTP, hooks de persistência e Concrete Generic Views.
5. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão para seleção da abstração correta de View.

---

## Exemplos de Código (`examples/`)

- [`examples/rpc-endpoint.md`](./examples/rpc-endpoint.md): Endpoint RPC limpo com `APIView`.
- [`examples/generic-apiview.md`](./examples/generic-apiview.md): `GenericAPIView` com `get_queryset()` e `get_serializer()`.
- [`examples/concrete-views.md`](./examples/concrete-views.md): `ListCreateAPIView` e `RetrieveUpdateDestroyAPIView`.
- [`examples/custom-mixins.md`](./examples/custom-mixins.md): `GenericAPIView` combinando `ListModelMixin` e `CreateModelMixin`.

---

## Checklist de Implementação de Views DRF

1. **Escolha da Abstração**: Seguiu a regra de usar a maior abstração possível que resolve o problema?
2. **Métodos Sobrescritos**: Sobrescreveu apenas os hooks corretos (`get_queryset`, `get_object`, `perform_create`) sem reimplementar lógica nativa do DRF?
3. **Uso de `get_object()`**: Evitou chamar `Model.objects.get()` manualmente quando `get_object()` estava disponível?
4. **Sem Redundâncias**: Evitou usar serializadores de saída redundantes e manteve a View focada na orquestração HTTP?
