# Knowledge: Validação em 3 Níveis no Serializer

## 1. Nível 1: Validação de Campo Declarativa
Aplicada na definição do campo ou em `validators=[...]`:
```python
def validate_positive(value):
    if value <= 0:
        raise serializers.ValidationError("O valor deve ser positivo.")


class PaymentSerializer(serializers.Serializer):
    amount = serializers.DecimalField(
        max_digits=10, decimal_places=2, validators=[validate_positive]
    )
```

## 2. Nível 2: Validação de Campo Único (`validate_<field>`)
Para regras de negócio que dependem de apenas um campo:
```python
def validate_code(self, value):
    if not value.isupper():
        raise serializers.ValidationError("O código deve ser maiúsculo.")
    return value
```

## 3. Nível 3: Validação Cruzada Multi-Campo (`validate`)
Para regras que comparam múltiplos campos:
```python
def validate(self, attrs):
    if attrs.get("start_date") > attrs.get("end_date"):
        raise serializers.ValidationError(
            {"end_date": "Data final deve ser posterior à inicial."}
        )
    return attrs
```

## 4. Onde Validar Regras de Banco
Restrições de banco (unicidade, integridade referencial) pertencem ao **Model** (`Meta.constraints`, `clean()`), permitindo que o `ModelSerializer` as herde automaticamente.