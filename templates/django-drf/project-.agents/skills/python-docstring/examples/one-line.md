# Example: Docstrings de Linha Única (One-line Docstring)

```python
from decimal import Decimal
from apps.users.models import User


def calculate_fee(amount: Decimal, percentage: Decimal) -> Decimal:
    """Calculate the platform fee from the gross transaction amount."""
    return amount * (percentage / Decimal("100"))


def get_user_by_id(user_id: int) -> User | None:
    """Retrieve an active user by ID."""
    return User.objects.filter(id=user_id, is_active=True).first()
```
