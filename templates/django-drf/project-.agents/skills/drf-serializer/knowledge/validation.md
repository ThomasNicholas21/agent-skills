# Knowledge: Validação em 3 Níveis em Serializers

---

## 1. Nível 1: Validação de Campo e Validadores Declarativos

Aplicada diretamente na definição do campo ou via função em `validators=[...]`:

```python
from rest_framework import serializers

def validate_positive_amount(value):
    if value <= 0:
        raise serializers.ValidationError("O valor deve ser estritamente positivo.")

class PaymentSerializer(serializers.Serializer):
    amount = serializers.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[validate_positive_amount]
    )
```

---

## 2. Nível 2: Validação de Campo Único (`validate_<field_name>`)

Método de instância para validar e sanitizar um único campo. Recebe o valor de entrada e deve retornar o valor tratado ou lançar `serializers.ValidationError`:

```python
class UserSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=50)

    def validate_username(self, value):
        if not value.isalnum():
            raise serializers.ValidationError("O nome de usuário deve conter apenas letras e números.")
        return value.lower()
```

---

## 3. Nível 3: Validação Cruzada entre Campos (`validate`)

Método de instância para validar dependências entre dois ou mais campos. Recebe o dicionário `attrs` contendo os campos pré-validados pelos níveis anteriores:

```python
class DateRangeSerializer(serializers.Serializer):
    start_date = serializers.DateField()
    end_date = serializers.DateField()

    def validate(self, attrs):
        if attrs["start_date"] >= attrs["end_date"]:
            raise serializers.ValidationError({
                "end_date": "A data final deve ser estritamente posterior à data inicial."
            })
        return attrs
```

---

## 4. Regra de Escolha do Nível de Validação

- **Regra de 1 campo solto**: Use `validate_<field_name>()`.
- **Regra dependente de 2 ou mais campos**: Use `validate(self, attrs)`.
- **Validação de Modelo**: Restrições do modelo e mensagens de erro do banco DEVEM ser configuradas no **Model**, sendo herdadas automaticamente por `ModelSerializer`.
