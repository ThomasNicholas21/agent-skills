---
trigger:
  glob: "**/{exceptions.py,exceptions/**/*.py}"
---

# Regras de Desenvolvimento: DRF Custom Exceptions & Global Handler

Ao criar ou editar exceções customizadas (`exceptions.py`) em projetos Django REST Framework, você DEVE seguir estritamente o padrão de hierarquia de exceções de domínio e tratamento global de erros abaixo:

---

## 1. Hierarquia de Exceções de Domínio

- **`DomainException`**: Classe base abstrata para todas as exceções de regra de negócio do projeto.
- Exceções especializadas herdam de `DomainException` e especificam a mensagem padrão e o código de erro numérico ou textual (`code`):
  - `BusinessValidationError`: Erros de pré-requisitos de negócio.
  - `ResourceNotFoundError`: Objeto ou entidade de domínio não encontrada.
  - `ResourceConflictError`: Conflito de estado ou duplicidade de recurso.
  - `InsufficientPermissionError`: Acesso negado a um recurso de domínio.

---

## 2. Handler Global de Exceções (`custom_exception_handler`)

- Configure o handler customizado em `core/exceptions.py` e registre no `settings.py` em `REST_FRAMEWORK['EXCEPTION_HANDLER']`.
- O handler captura exceções de domínio e as converte em respostas HTTP JSON com status codes padronizados (400, 403, 404, 409, 422).

---

## 3. Exemplos de Implementação (Otimizados para Agentes)

### A. Exceções de Domínio (`core/exceptions.py` ou `<app>/exceptions.py`)

```python
from rest_framework import status


class DomainException(Exception):
    status_code = status.HTTP_400_BAD_REQUEST
    default_message = "Ocorreu um erro de domínio."
    default_code = "domain_error"

    def __init__(self, message=None, code=None, status_code=None):
        self.message = message or self.default_message
        self.code = code or self.default_code
        if status_code:
            self.status_code = status_code


class BusinessValidationError(DomainException):
    status_code = status.HTTP_422_UNPROCESSABLE_ENTITY
    default_message = "Regra de negócio violada."
    default_code = "business_validation_error"


class ResourceNotFoundError(DomainException):
    status_code = status.HTTP_404_NOT_FOUND
    default_message = "Recurso não encontrado."
    default_code = "resource_not_found"


class ResourceConflictError(DomainException):
    status_code = status.HTTP_409_CONFLICT
    default_message = "Conflito de recurso ou estado."
    default_code = "resource_conflict"
```

### B. Custom Exception Handler Global (`core/exceptions.py`)

```python
from rest_framework.response import Response
from rest_framework.views import exception_handler
from .exceptions import DomainException


def custom_exception_handler(exc, context):
    response = exception_handler(exc, context)

    if isinstance(exc, DomainException):
        custom_data = {
            "error": {
                "code": exc.code,
                "message": exc.message,
            }
        }
        return Response(custom_data, status=exc.status_code)

    if response is not None:
        custom_data = {
            "error": {
                "code": "api_error",
                "message": "Erro no processamento da requisição.",
                "details": response.data,
            }
        }
        return Response(custom_data, status=response.status_code)

    return response
```

### C. Registro no `settings.py`

```python
REST_FRAMEWORK = {
    "EXCEPTION_HANDLER": "core.exceptions.custom_exception_handler",
}
```
