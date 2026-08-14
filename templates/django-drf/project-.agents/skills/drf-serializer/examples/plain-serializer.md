# Example: Serializer Genérico (Plain Serializer) para Payloads RPC/Serviço

```python
from rest_framework import serializers


class CheckoutInputSerializer(serializers.Serializer):
    """
    Serializer genérico (DTO de entrada) para payload de checkout que não se mapeia 1:1 a um modelo.
    """
    cart_id = serializers.UUIDField(required=True)
    payment_method = serializers.ChoiceField(choices=["CREDIT_CARD", "PIX", "BOLETO"])
    coupon_code = serializers.CharField(required=False, allow_blank=True, default="")

    def validate_coupon_code(self, value):
        if value and not value.isalnum():
            raise serializers.ValidationError("Cupom deve conter apenas caracteres alfanuméricos.")
        return value.upper()
```
