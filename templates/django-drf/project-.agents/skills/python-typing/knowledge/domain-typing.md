# Knowledge: Tipagem de Domínio (TypedDict, NewType, Literal, Final)

## 1. `TypedDict` (Schemas de Dicionário)
Use para tipar dicionários estruturados com chaves fixas:
```python
from typing import TypedDict, NotRequired, ReadOnly
from decimal import Decimal


class PaymentPayload(TypedDict):
    id: ReadOnly[str]
    amount: Decimal
    description: NotRequired[str]
```

## 2. `NewType` (Identificadores Semânticos)
Evita confusão entre IDs do mesmo tipo primitivo (`int` ou `str`):
```python
from typing import NewType

UserId = NewType("UserId", int)
OrderId = NewType("OrderId", int)


def get_order(user_id: UserId, order_id: OrderId) -> None: ...
```

## 3. `Literal` (Enumerações Estáticas)
Restringe valores a um conjunto fechado de constantes:
```python
from typing import Literal

type Status = Literal["PENDING", "PAID", "FAILED"]
```

## 4. `Final` e `ClassVar`
```python
from typing import Final, ClassVar

MAX_RETRIES: Final[int] = 3


class Settings:
    default_timeout: ClassVar[int] = 30
```