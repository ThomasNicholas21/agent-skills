# Knowledge: Arquitetura de ViewSets no DRF (Ações vs Métodos HTTP)
## 1. Hierarquia de Abstração de ViewSets
O Django REST Framework fornece uma hierarquia de composição clara para ViewSets:
```text
APIView
  └── ViewSet
        └── GenericViewSet
              ├── Mixins (ListModelMixin, CreateModelMixin, RetrieveModelMixin, UpdateModelMixin, DestroyModelMixin)
              ├── ModelViewSet
              └── ReadOnlyModelViewSet
```

## 2. Diferença Fundamental: Handlers HTTP vs Ações (Actions)
Diferente de um `APIView` (que utiliza métodos de verbo HTTP como `get()`, `post()`, `put()`), um `ViewSet` **não define manipuladores HTTP diretamente**.
Um `ViewSet` opera através de **Ações de Recurso**:
- `list()`
- `create()`
- `retrieve()`
- `update()`
- `partial_update()`
- `destroy()`
O mapeamento entre o verbo HTTP da requisição e a ação correspondente é realizado posteriormente pelo `Router` do DRF.
> **Regra para Agente**: Em uma classe `ViewSet`, NUNCA defina métodos `get()`, `post()`, `put()`, `patch()` ou `delete()`. Utilize sempre os métodos de ação (`list`, `create`, `retrieve`, `update`, `partial_update`, `destroy`) ou decoradores `@action`.

## 3. Tabela de Mapeamento de Ações Padrão
| Ação do ViewSet | Responsabilidade | Verbo HTTP Típico | Rota do Router |
| :--- | :--- | :--- | :--- |
| `list()` | Listar coleção de recursos | GET | `/resources/` |
| `create()` | Criar novo recurso | POST | `/resources/` |
| `retrieve()` | Obter recurso específico | GET | `/resources/{pk}/` |
| `update()` | Substituir/atualizar completamente | PUT | `/resources/{pk}/` |
| `partial_update()` | Atualizar parcialmente | PATCH | `/resources/{pk}/` |
| `destroy()` | Remover recurso | DELETE | `/resources/{pk}/` |