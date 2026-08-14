# Knowledge: GenericAPIView - Atributos e Métodos Fundamentais

`GenericAPIView` herda de `APIView` e adiciona comportamentos padrão para endpoints baseados em modelos Django.

```text
APIView
  └── GenericAPIView
```

---

## 1. Atributos Principais do `GenericAPIView`

- `queryset`: Define a fonte padrão dos objetos (ex: `User.objects.all()`).
- `serializer_class`: Define a classe de serializador padrão da View.
- `lookup_field`: Campo do modelo usado para localizar um objeto individual (padrão: `'pk'`).
- `lookup_url_kwarg`: Nome do parâmetro da URL usado para o lookup (padrão: mesmo valor de `lookup_field`).
- `pagination_class`: Classe responsável pela paginação dos dados.
- `filter_backends`: Lista de classes de filtragem e busca (ex: `[DjangoFilterBackend, SearchFilter]`).

---

## 2. Métodos Fundamentais do `GenericAPIView`

### A. `get_queryset(self)`
- Retorna a consulta de banco de dados utilizada pela View.
- **Ponto de Otimização**: Ideal para scoping por usuário logado (`request.user`) e prevenção de N+1 via `select_related()` e `prefetch_related()`.
- **Regra Estrita**: Nunca acesse `self.queryset` diretamente nos métodos. Chame sempre `self.get_queryset()`.

### B. `get_object(self)`
- Localiza e retorna a instância de um objeto individual para visões detalhadas.
- **Fluxo Interno**:
  `get_queryset()` → Filtra por `lookup_field` → Recupera objeto → Executa `check_object_permissions(request, obj)` → Retorna objeto.
- **Regra Estrita**: NUNCA faça `Model.objects.get(pk=self.kwargs['pk'])` manualmente quando a View disponibilizar `self.get_object()`, pois isso ignora a verificação automática de permissões em nível de objeto.

### C. `filter_queryset(self, queryset)`
- Aplica os `filter_backends` declarados sobre o queryset recebido.

### D. `get_serializer_class(self)`
- Retorna a classe do serializador a ser utilizada.
- Permite alternar serializers com base na operação (ex: `ReadSerializer` vs `WriteSerializer`) ou nas permissões do usuário.

### E. `get_serializer(self, *args, **kwargs)`
- Instancia a classe retornada por `get_serializer_class()`, injetando automaticamente o contexto de `get_serializer_context()`.

### F. `get_serializer_context(self)`
- Retorna o dicionário de contexto para o serializador. Por padrão inclui: `{'request': request, 'format': format, 'view': view}`.

### G. Paginação (`paginate_queryset` & `get_paginated_response`)
- `paginate_queryset(queryset)`: Avalia o queryset e retorna uma página ou `None`.
- `get_paginated_response(data)`: Encapsula os dados serializados na resposta paginada do DRF.
