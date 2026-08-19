# Knowledge: Protocols (Duck Typing Estático) e Generics

## 1. `Protocol` (Tipagem Estrutural)
Permite contratos comportamentais sem herança explícita (*static duck typing*):
```python
from typing import Protocol
from decimal import Decimal


class PaymentGateway(Protocol):
    def charge(self, amount: Decimal) -> bool: ...


# Qualquer classe com charge(amount: Decimal) -> bool satisfaz PaymentGateway
class StripeGateway:
    def charge(self, amount: Decimal) -> bool:
        return True
```

## 2. Generics Modernas com Sintaxe `[T]` (Python 3.12+)
```python
class Repository[T]:
    def __init__(self) -> None:
        self._items: list[T] = []

    def add(self, item: T) -> None:
        self._items.append(item)

    def get_first(self) -> T | None:
        return self._items[0] if self._items else None
```

## 3. Funções Genéricas
```python
def first_or_default[T](items: Sequence[T], default: T) -> T:
    return items[0] if items else default
```