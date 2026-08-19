# Knowledge: Ciclo de Vida do ViewSet, self.action e Atributos de Instância
## 1. Atributo `self.action`
Durante o dispatch da requisição em um `ViewSet`, o DRF identifica qual ação está sendo executada e a disponibiliza no atributo `self.action`.
Valores comuns de `self.action`:
- `'list'`, `'create'`, `'retrieve'`, `'update'`, `'partial_update'`, `'destroy'`
- Nome do método decorado com `@action` (ex: `'set_password'`, `'recent_users'`)

## 2. Onde `self.action` está Disponível (Disponibilidade no Ciclo de Vida)

`self.action` é definido **após** a inicialização da requisição, durante o dispatch do router.

| Método do ViewSet | `self.action` Disponível? | Uso Recomendado |
| :--- | :--- | :--- |
| `get_serializer_class()` | **SIM** | Alternar serializers por ação (ex: `ReadSerializer` vs `WriteSerializer`). |
| `get_permissions()` | **SIM** | Alternar permissões por ação (ex: `AllowAny` em `list`, `IsAdminUser` em `destroy`). |
| `get_queryset()` | **SIM** | Ajustar filtros ou `select_related`/`prefetch_related` conforme a ação. |
| `get_parsers()` | **NÃO** | Atributo indisponível. Não depender de `self.action`. |
| `get_authenticators()` | **NÃO** | Atributo indisponível. Não depender de `self.action`. |
| `get_content_negotiator()` | **NÃO** | Atributo indisponível. Não depender de `self.action`. |

## 3. Atributos de Instância Adicionais
- `self.detail`: Booleano que indica se a ação atual opera sobre um objeto individual (`detail=True`) ou sobre uma coleção (`detail=False`).
- `self.basename`: String utilizada pelo `Router` para gerar o prefixo do nome das URLs (ex: `'user'`).
- `self.suffix`: Metadata descritivo sobre a ViewSet.
- `self.name`: Nome de exibição da ViewSet para introspecção da API.