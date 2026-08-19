---
name: drf-view
description: >-
  Especialista em seleção, arquitetura e construção de Views no DRF (APIView, GenericAPIView, Mixins e Concrete Generic Views).
---

# DRF View Skill (`APIView` & `GenericAPIView`)
Orienta a seleção e implementação de Views no Django REST Framework respeitando a hierarquia de composição do framework.

## Quando Ativar
- Escolher a abstração ideal de View (`APIView`, `GenericAPIView`, `ListCreateAPIView`, etc.).
- Criar endpoints estilo RPC ou comandos de ação única usando `APIView`.
- Implementar `GenericAPIView` customizando `get_queryset()`, `get_object()` ou `get_serializer_class()`.
- Utilizar Concrete Generic Views (`ListCreateAPIView`, `RetrieveUpdateDestroyAPIView`) ou compor com Mixins.

## Conhecimento (`knowledge/`)
1. [`knowledge/apiview.md`](./knowledge/apiview.md): Conceitos fundamentais e manipuladores HTTP no `APIView`.
2. [`knowledge/apiview-lifecycle.md`](./knowledge/apiview-lifecycle.md): Fluxo do `dispatch()`, políticas e tratamento de exceções.
3. [`knowledge/generic-views.md`](./knowledge/generic-views.md): `GenericAPIView`, atributos e métodos principais (`get_queryset`, `get_object`).
4. [`knowledge/mixins-and-concrete-views.md`](./knowledge/mixins-and-concrete-views.md): Mixins vs Handlers HTTP e Concrete Generic Views.
5. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão para escolha de View.

## Exemplos (`examples/`)
- [`examples/rpc-endpoint.md`](./examples/rpc-endpoint.md): Endpoint RPC limpo com `APIView`.
- [`examples/generic-apiview.md`](./examples/generic-apiview.md): `GenericAPIView` com `get_queryset()` e `get_serializer()`.
- [`examples/concrete-views.md`](./examples/concrete-views.md): `ListCreateAPIView` e `RetrieveUpdateDestroyAPIView`.
- [`examples/custom-mixins.md`](./examples/custom-mixins.md): `GenericAPIView` com `ListModelMixin` e `CreateModelMixin`.

## Checklist
1. **Abstração**: Usou a maior abstração possível que resolve o problema?
2. **Hooks Nativos**: Sobrescreveu apenas os hooks necessários (`get_queryset`, `get_object`, `perform_create`)?
3. **Uso de `get_object()`**: Evitou chamar `Model.objects.get()` manualmente quando `get_object()` estava disponível?
4. **Foco HTTP**: Manteve a View focada na orquestração HTTP sem regras de domínio acopladas?
