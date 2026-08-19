# Example: Teste Unitário sem Banco de Dados (SimpleTestCase)
```python
from decimal import Decimal
from django.test import SimpleTestCase
from apps.payments.services import FeeCalculatorService


class FeeCalculatorServiceTestCase(SimpleTestCase):
    """
    Testes unitarios puros para o servico de calculo de taxas sem acesso ao banco de dados.
    Herda de SimpleTestCase para garantir execucao ultra-rapida.
    """

    def test_calculate_fee_standard_amount(self):
        amount = Decimal("100.00")
        percentage = Decimal("5.00")

        fee = FeeCalculatorService.calculate(amount=amount, percentage=percentage)

        self.assertEqual(fee, Decimal("5.00"))

    def test_calculate_fee_zero_amount(self):
        amount = Decimal("0.00")
        percentage = Decimal("5.00")

        fee = FeeCalculatorService.calculate(amount=amount, percentage=percentage)

        self.assertEqual(fee, Decimal("0.00"))
```