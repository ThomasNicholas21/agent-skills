# Example: Docstrings de Módulo e Classe

```python
"""
Payment processing domain services and gateway integration utilities.

This module provides high-level orchestrators for credit card and PIX transactions.
"""

from decimal import Decimal
from typing import Final

DEFAULT_TIMEOUT_SECONDS: Final[int] = 30


class PaymentService:
    """
    Provide payment processing and refund operations.

    Orchestrates validation, fraud checking, and gateway communication.
    """

    def refund(self, payment_id: str, amount: Decimal) -> bool:
        """Issue a partial or full refund for a processed payment."""
        ...
```
