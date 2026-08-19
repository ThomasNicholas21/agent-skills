# Knowledge: Ciclo de Vida do APIView no DRF

## 1. Fluxo de Execução do `dispatch()`
```text
dispatch()
  ├── initialize_request()  → Converte HttpRequest em rest_framework.request.Request
  ├── initial()
  │     ├── format_kwarg    → Determina format suffix
  │     ├── perform_authentication() → Autentica user via authentication_classes
  │     ├── check_permissions()      → Valida permission_classes
  │     └── check_throttles()        → Aplica throttle_classes
  ├── HTTP Method Handler   → Executa get(), post(), put(), patch(), delete()
  └── handle_exception()    → Converte exceções em Response HTTP (400, 401, 403, 404, 500)
```

## 2. Tratamento de Exceções
- Exceções do DRF (`APIException`, `ValidationError`, `PermissionDenied`, `NotFound`) são interceptadas por `handle_exception()` e convertidas em respostas JSON padronizadas.
