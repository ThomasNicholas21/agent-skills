# Knowledge: Mixins e Concrete Generic Views no DRF

---

## 1. Distinção Crucial: HTTP Handlers vs Mixin Actions

Não confunda métodos manipuladores de protocolo HTTP com ações fornecidas por Mixins:

```text
HTTP Protocol Level
   │
   ├── post()           ──> Recebe a requisição HTTP POST
   │     │
   │     ▼
   └── create()         ──> Ação executada pelo CreateModelMixin
         │
         ├── get_serializer()
         ├── is_valid()
         ├── perform_create()  ──> Hook de persistência no banco
         └── Response(201)
```

- **HTTP Handlers** (`get`, `post`, `put`, `patch`, `delete`): Mapeiam a requisição de rede no `APIView`.
- **Mixin Actions** (`list`, `create`, `retrieve`, `update`, `partial_update`, `destroy`): Implementam o algoritmo operacional reutilizável.

---

## 2. Visão Geral dos Mixins (`rest_framework.mixins`)

| Mixin | Ação | Hooks de Persistência | Comportamento Padrão |
| :--- | :--- | :--- | :--- |
| `ListModelMixin` | `list()` | — | `get_queryset()` → `filter` → `paginate` → `serialize` → `Response(200)` |
| `CreateModelMixin` | `create()` | `perform_create(serializer)` | `request.data` → `validate` → `save` → `Response(201)` |
| `RetrieveModelMixin` | `retrieve()` | — | `get_object()` → `serialize` → `Response(200)` |
| `UpdateModelMixin` | `update()`, `partial_update()` | `perform_update(serializer)` | `get_object()` → `validate` → `save` → `Response(200)` |
| `DestroyModelMixin` | `destroy()` | `perform_destroy(instance)` | `get_object()` → `delete` → `Response(204)` |

---

## 3. Concrete Generic Views (`rest_framework.generics`)

As Concrete Generic Views combinam `GenericAPIView` com um ou mais Mixins, conectando os métodos HTTP aos handlers dos Mixins:

### A. Variações Simples
- **`CreateAPIView`**: `GenericAPIView` + `CreateModelMixin` (HTTP POST)
- **`ListAPIView`**: `GenericAPIView` + `ListModelMixin` (HTTP GET)
- **`RetrieveAPIView`**: `GenericAPIView` + `RetrieveModelMixin` (HTTP GET)
- **`UpdateAPIView`**: `GenericAPIView` + `UpdateModelMixin` (HTTP PUT/PATCH)
- **`DestroyAPIView`**: `GenericAPIView` + `DestroyModelMixin` (HTTP DELETE)

### B. Variações Compostas
- **`ListCreateAPIView`**: HTTP GET + HTTP POST
- **`RetrieveUpdateAPIView`**: HTTP GET + HTTP PUT/PATCH
- **`RetrieveDestroyAPIView`**: HTTP GET + HTTP DELETE
- **`RetrieveUpdateDestroyAPIView`**: HTTP GET + HTTP PUT/PATCH + HTTP DELETE
