# Example: Pytest + Pytest-Django + Parametrize (Apenas se Pytest For Detectado)

> **Importante**: Utilize a sintaxe pytest APENAS se o repositório possuir `pytest` previamente configurado (`pytest.ini`, `pyproject.toml`, `conftest.py`).

```python
import pytest
from decimal import Decimal
from apps.payments.services import FeeCalculatorService


# Teste parametrizado puro sem banco de dados
@pytest.mark.parametrize(
    "amount,percentage,expected_fee",
    [
        (Decimal("100.00"), Decimal("5.00"), Decimal("5.00")),
        (Decimal("200.00"), Decimal("10.00"), Decimal("20.00")),
        (Decimal("0.00"), Decimal("5.00"), Decimal("0.00")),
    ],
)
def test_calculate_fee_parametrized(amount, percentage, expected_fee):
    fee = FeeCalculatorService.calculate(amount=amount, percentage=percentage)
    assert fee == expected_fee


# Teste que exige acesso ao banco via marca do pytest-django
@pytest.mark.django_db
def test_create_order_with_pytest_db(db):
    from apps.orders.models import Order
    order = Order.objects.create(code="ORD-00001", status="PENDING", total_amount=Decimal("100.00"))
    assert order.id is not None
```
