# Example: Docstrings Multilinha (Multi-line Docstring)
```python
from decimal import Decimal
from apps.payments.models import Payment, PaymentResult
from apps.payments.exceptions import GatewayTimeoutError


def process_payment(
    payment: Payment, *, capture_immediately: bool = True
) -> PaymentResult:
    """
    Process a payment transaction through the external payment gateway.

    The payment payload is validated for fraud rules prior to transmission.
    If capture_immediately is True, the funds are captured in a single step;
    otherwise, an authorization holds the funds for up to 7 days.

    Side Effects:
        - Updates payment.status in the database.
        - Dispatches a PAYMENT_PROCESSED event to the message broker.

    Raises:
        GatewayTimeoutError: If the external payment provider does not respond within 30 seconds.
    """
    ...
```