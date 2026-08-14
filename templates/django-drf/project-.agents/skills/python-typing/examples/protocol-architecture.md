# Example: Arquitetura Desacoplada com Protocol (Static Duck Typing)

```python
from decimal import Decimal
from typing import Protocol
from dataclasses import dataclass


@dataclass(frozen=True)
class PaymentResult:
    transaction_id: str
    is_success: bool


class PaymentGateway(Protocol):
    """Protocolo comportamental para gateways de pagamento."""
    def process_charge(self, amount: Decimal, currency: str) -> PaymentResult:
        ...


class PagarmeGateway:
    """Implementacao concreta que satisfaz PaymentGateway sem heranca explicita."""
    def process_charge(self, amount: Decimal, currency: str) -> PaymentResult:
        return PaymentResult(transaction_id="tx_12345", is_success=True)


class CheckoutService:
    def __init__(self, gateway: PaymentGateway) -> None:
        self.gateway = gateway

    def checkout(self, amount: Decimal) -> PaymentResult:
        return self.gateway.process_charge(amount, currency="BRL")
```
