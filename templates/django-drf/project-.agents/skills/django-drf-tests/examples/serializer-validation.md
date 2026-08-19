# Example: Teste de Validação e Representação de Serializer
```python
from decimal import Decimal
from django.test import TestCase
from apps.orders.serializers import CheckoutSerializer


class CheckoutSerializerTestCase(TestCase):
    def test_valid_checkout_payload(self):
        payload = {
            "amount": "150.00",
            "payment_method": "CREDIT_CARD",
        }
        serializer = CheckoutSerializer(data=payload)

        self.assertTrue(serializer.is_valid())
        self.assertEqual(serializer.validated_data["amount"], Decimal("150.00"))

    def test_invalid_negative_amount(self):
        payload = {
            "amount": "-50.00",
            "payment_method": "CREDIT_CARD",
        }
        serializer = CheckoutSerializer(data=payload)

        self.assertFalse(serializer.is_valid())
        self.assertIn("amount", serializer.errors)
```