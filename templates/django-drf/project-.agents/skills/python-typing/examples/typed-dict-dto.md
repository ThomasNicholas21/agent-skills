# Example: Payloads de DTO e Configuração com TypedDict
```python
from decimal import Decimal
from typing import TypedDict, NotRequired, ReadOnly


class CustomerAddress(TypedDict):
    street: str
    city: str
    zip_code: str


class CreateOrderPayload(TypedDict):
    customer_id: int
    amount: Decimal
    currency: ReadOnly[str]
    shipping_address: CustomerAddress
    discount_code: NotRequired[str]


def process_order_payload(payload: CreateOrderPayload) -> None:
    # O type checker sabe exatamente o tipo de cada chave
    customer_id: int = payload["customer_id"]
    amount: Decimal = payload["amount"]
    discount: str | None = payload.get("discount_code")
```