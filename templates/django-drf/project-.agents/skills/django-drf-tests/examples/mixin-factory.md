# Example: Model Factory Mixin Reutilizável com **kwargs

```python
# apps/orders/tests/mixins.py
from decimal import Decimal
from apps.users.models import User
from apps.orders.models import Order, OrderItem


class OrderTestMixin:
    """
    Mixin centralizador de criacao de massa de dados do app orders.
    Utiliza defaults inteligentes e permite sobrescrever qualquer campo via **kwargs.
    """

    def create_user(self, **kwargs) -> User:
        count = User.objects.count() + 1
        defaults = {
            "email": f"user_{count}@example.com",
            "is_active": True,
        }
        defaults.update(kwargs)
        return User.objects.create(**defaults)

    def create_order(self, user=None, **kwargs) -> Order:
        user_instance = user or self.create_user()
        count = Order.objects.count() + 1
        defaults = {
            "user": user_instance,
            "code": f"ORD-{count:05d}",
            "status": "PENDING",
            "total_amount": Decimal("100.00"),
        }
        defaults.update(kwargs)
        return Order.objects.create(**defaults)

    def create_order_item(self, order=None, **kwargs) -> OrderItem:
        order_instance = order or self.create_order()
        defaults = {
            "order": order_instance,
            "product_name": "Produto de Teste",
            "unit_price": Decimal("50.00"),
            "quantity": 2,
        }
        defaults.update(kwargs)
        return OrderItem.objects.create(**defaults)
```
