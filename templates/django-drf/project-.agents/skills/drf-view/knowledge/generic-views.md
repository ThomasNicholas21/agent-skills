# Knowledge: GenericAPIView e Concrete Views

## 1. `GenericAPIView`
Herda de `APIView` e adiciona atributos e métodos para views baseadas em modelos:
- `queryset`: Base de dados da view (sobrescreva `get_queryset()` para filtros dinâmicos/scoping).
- `serializer_class`: Serializer principal (sobrescreva `get_serializer_class()` para alternar por ação/método).
- `lookup_field` / `lookup_url_kwarg`: Campo de busca do objeto (padrão `"pk"`).
- `get_object()`: Obtém a instância do objeto respeitando `lookup_field` e valida permissões de objeto (`check_object_permissions`).

## 2. Concrete Generic Views
Views prontas para endpoints REST padrão:
- `ListAPIView` / `CreateAPIView` / `ListCreateAPIView`
- `RetrieveAPIView` / `UpdateAPIView` / `DestroyAPIView`
- `RetrieveUpdateAPIView` / `RetrieveDestroyAPIView` / `RetrieveUpdateDestroyAPIView`

## 3. Hooks de Persistência nos Mixins
- `perform_create(serializer)`: Injeta dados extras antes de salvar (ex: `serializer.save(user=self.request.user)`).
- `perform_update(serializer)`: Customizações na atualização.
- `perform_destroy(instance)`: Customizações na deleção (ex: soft delete `instance.soft_delete()`).
