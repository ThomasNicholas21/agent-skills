# Knowledge: Protocols (Static Duck Typing) e Generics Modernas

---

## 1. `Protocol` (Contratos Comportamentais sem Herança)

`Protocol` implementa *structural subtyping* (tipagem estrutural / *static duck typing*). Uma classe satisfaz um protocolo simplesmente por implementar seus métodos e atributos, sem precisar herdar explicitamente da classe Protocol:

```python
from typing import Protocol
from decimal import Decimal
from apps.payments.models import PaymentResult

class PaymentGateway(Protocol):
    def charge(self, amount: Decimal) -> PaymentResult:
        ...

# Qualquer classe que implemente charge(amount: Decimal) -> PaymentResult satisfaz PaymentGateway
class StripeGateway:
    def charge(self, amount: Decimal) -> PaymentResult:
        return PaymentResult(success=True)

def process_order(gateway: PaymentGateway, amount: Decimal) -> PaymentResult:
    return gateway.charge(amount)
```

---

## 2. Generics Modernas (Sintaxe Python 3.12+)

A partir do Python 3.12, é possível definir classes, funções e aliases genéricos diretamente com colchetes `[T]`:

### Classes Genéricas
```python
class Repository[T]:
    def get_by_id(self, item_id: int) -> T | None:
        ...
    def save(self, entity: T) -> T:
        ...

type UserRepository = Repository[User]
```

### Funções Genéricas
```python
from collections.abc import Sequence

def first[T](items: Sequence[T]) -> T | None:
    return items[0] if items else None
```

---

## 3. Decorators Preservando Assinaturas (`ParamSpec`)

Para decorators e middlewares, utilize `ParamSpec` para preservar os argumentos e retorno da função original:

```python
from collections.abc import Callable
from typing import ParamSpec, TypeVar

P = ParamSpec("P")
R = TypeVar("R")

def audit_log(func: Callable[P, R]) -> Callable[P, R]:
    def wrapper(*args: P.args, **kwargs: P.kwargs) -> R:
        print(f"Calling {func.__name__}")
        return func(*args, **kwargs)
    return wrapper
```
