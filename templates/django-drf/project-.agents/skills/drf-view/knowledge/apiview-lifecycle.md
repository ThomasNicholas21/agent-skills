# Knowledge: Ciclo de Vida do Dispatch e Métodos Internos do APIView

---

## 1. Fluxo Completo do `dispatch()` no `APIView`

Quando uma requisição atinge um `APIView`, o fluxo de execução segue estritamente esta ordem:

```text
dispatch()
   │
   ├── initialize_request()       ──> Transforma HttpRequest em DRF Request
   │
   ├── initial()                  ──> Executa pré-requisitos na ordem:
   │    ├── perform_authentication()
   │    ├── check_permissions()
   │    ├── check_throttles()
   │    └── perform_content_negotiation()
   │
   ├── HTTP Handler               ──> Executa o método correspondente:
   │    ├── get() / post() / put() / patch() / delete()
   │
   ├── handle_exception()         ──> Intercepta APIException / Http404 / PermissionDenied
   │
   └── finalize_response()        ──> Aplica a renderização final negociada
```

---

## 2. Categorização de Métodos Internos do `APIView`

### A. Métodos de Instanciação de Políticas (`Policy Factories`)
- `get_renderers()`
- `get_parsers()`
- `get_authenticators()`
- `get_throttles()`
- `get_permissions()`
- `get_content_negotiator()`
- `get_exception_handler()`

> **Regra de Ouro**: **NÃO sobrescreva** esses métodos de instanciação sem necessidade extrema. Em 99% dos casos, basta definir os atributos de classe (`permission_classes`, `parser_classes`, etc.).

### B. Métodos de Execução de Políticas (`Policy Execution`)
- `check_permissions(request)`: Executa as permissões declaradas. Se negada, lança `PermissionDenied`.
- `check_throttles(request)`: Verifica se o limite de taxa foi excedido. Lança `Throttled`.
- `perform_content_negotiation(request, force=False)`: Seleciona o melhor renderer/parser.

### C. Tratamento de Exceções (`handle_exception`)
- O `handle_exception(exc)` intercepta exceções do tipo `APIException`, `Http404` e `PermissionDenied` e as converte automaticamente em respostas HTTP padronizadas com o código de status apropriado.

---

## 3. Regra de Modificação para Agentes

NUNCA sobrescreva `dispatch()`, `initial()`, `initialize_request()` ou `finalize_response()`. Limite a escrita nos manipuladores HTTP (`get()`, `post()`, etc.) ou nos hooks específicos fornecidos pelas `GenericAPIView`.
