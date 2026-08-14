# Knowledge: Tipos Avançados de Domínio (TypedDict, NewType, Literal, Final, ClassVar)

---

## 1. `TypedDict` (Estruturas Dicionário com Schema)

Utilize `TypedDict` para tipar dicionários estruturados contendo chaves fixas e tipos conhecidos:

```python
from typing import TypedDict, NotRequired, ReadOnly
from decimal import Decimal

class PaymentPayload(TypedDict):
    id: ReadOnly[str]                # Python 3.13+: Imutável na análise estática
    amount: Decimal
    currency: str
    coupon_code: NotRequired[str]    # Campo opcional no dicionário
```

---

## 2. `NewType` (Diferenciação Semântica de Tipos)

Utilize `NewType` para criar tipos semanticamente distintos que compartilham a mesma representação primitiva em runtime (ex: `int`), prevenindo a passagem acidental de um `OrderId` para uma função que espera `UserId`:

```python
from typing import NewType

UserId = NewType("UserId", int)
OrderId = NewType("OrderId", int)

def get_user_orders(user_id: UserId) -> list[Order]:
    ...

# O type checker acusará erro se um OrderId for passado onde se espera UserId:
# get_user_orders(OrderId(42))  # ERRO no type checker
get_user_orders(UserId(42))     # OK
```

---

## 3. `Literal` (Conjuntos Fechados de Valores)

Utilize `Literal` quando um tipo ou parâmetro só puder assumir um conjunto restrito e exato de valores estáticos:

```python
from typing import Literal

type PaymentStatus = Literal["pending", "approved", "rejected"]

def update_status(status: PaymentStatus) -> None:
    ...
```

---

## 4. `Final` e `ClassVar`

- `Final`: Declara que uma constante ou atributo não pode ser reatribuído (análise estática).
  ```python
  from typing import Final
  MAX_RETRIES: Final[int] = 3
  ```
- `ClassVar`: Declara que uma variável pertence à classe e não às suas instâncias.
  ```python
  from typing import ClassVar
  class User:
      DEFAULT_ROLE: ClassVar[str] = "member"
  ```
