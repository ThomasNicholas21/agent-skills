# Example: Teste de Model e Custom QuerySet com setUpTestData

```python
from django.test import TestCase
from apps.orders.models import Order
from apps.orders.tests.mixins import OrderTestMixin


class OrderQuerySetTestCase(OrderTestMixin, TestCase):
    """
    Testes de Model e Custom QuerySet utilizando massa de dados compartilhada imutavel via setUpTestData.
    """

    @classmethod
    def setUpTestData(cls):
        # 1. Massa de dados criada uma unica vez para todos os metodos da classe
        cls.user = cls.create_user(email="buyer@example.com")
        cls.pending_order = cls.create_order(user=cls.user, status="PENDING")
        cls.paid_order = cls.create_order(user=cls.user, status="PAID")

    def test_filter_paid_orders(self):
        paid_orders = Order.objects.filter_paid()

        self.assertIn(self.paid_order, paid_orders)
        self.assertNotIn(self.pending_order, paid_orders)

    def test_unique_order_code_constraint(self):
        with self.assertRaises(Exception):
            self.create_order(code=self.paid_order.code)
```
