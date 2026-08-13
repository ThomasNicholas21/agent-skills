---
trigger:
  glob: "**/{validators.py,validators/**/*.py}"
---

# Regras de Desenvolvimento: Validações Django & DRF

Ao criar validações em projetos Django / DRF, você DEVE seguir a árvore de decisão abaixo para determinar **onde** colocar a lógica de validação.

---

## 1. Árvore de Decisão: Onde Colocar a Validação

### Padrão: Valide diretamente no Serializer ou `clean()`

Por padrão, toda validação DEVE ser feita **inline** no Serializer (`validate_<campo>()` / `validate()`) ou no `clean()` / `clean_<campo>()` do Form/Model. NÃO crie arquivos `validators.py` preventivamente (YAGNI).

### Quando extrair para `validators.py`

Crie um arquivo `validators.py` na raiz do app **somente** quando **uma ou mais** das condições abaixo for verdadeira:

1. **Reuso**: A mesma regra de validação é consumida em **mais de um lugar** (ex: Serializer + Model `clean()` + Service Layer).
2. **Serializer gordo**: O Serializer acumula tantas validações que prejudica a legibilidade e a manutenção (mais de 5-6 métodos `validate_*`).

```text
features/<app>/
├── models.py
├── services.py
├── validators.py        # Criado somente quando necessário (reuso ou serializer gordo)
└── api/
    ├── serializers.py    # Padrão: validações inline aqui
    └── viewsets.py
```

---

## 2. Hierarquia de `ValidationError`: Django vs DRF

O Django e o DRF possuem dois `ValidationError` **distintos e incompatíveis**. A escolha depende de **onde** a validação é executada:

| Contexto | Exceção | Import |
|---|---|---|
| `models.py` (`clean()`, campo `validators=[]`) | `django.core.exceptions.ValidationError` | `from django.core.exceptions import ValidationError` |
| `forms.py` (`clean()`, `clean_<campo>()`) | `django.core.exceptions.ValidationError` | `from django.core.exceptions import ValidationError` |
| `serializers.py` (`validate_<campo>()`, `validate()`) | `rest_framework.serializers.ValidationError` | `from rest_framework import serializers` |
| `services.py` (regras de domínio) | Exceção customizada (`DomainException`) | `from core.exceptions import BusinessValidationError` |
| `validators.py` (arquivo compartilhado) | `django.core.exceptions.ValidationError` | `from django.core.exceptions import ValidationError` |

**Regra**: Validators reutilizáveis em `validators.py` usam **sempre** `django.core.exceptions.ValidationError`. O DRF converte automaticamente essa exceção para o formato de resposta HTTP quando consumida por um Serializer.

---

## 3. Padrões de Retorno de Erro

### 3.1 Erro único por campo

Use quando a validação se refere a **um único campo** com **uma única regra**. Lance `ValidationError` com uma **string simples**:

```python
# No Serializer (DRF) -- padrão inline:
def validate_code(self, value):
    if not value or not value.startswith("ORD-"):
        raise serializers.ValidationError("O código deve iniciar com 'ORD-'.")
    return value.upper()


# No clean_<campo>() do Form:
def clean_code(self):
    code = self.cleaned_data.get("code")
    if not code or not code.startswith("ORD-"):
        raise ValidationError("O código deve iniciar com 'ORD-'.")
    return code.upper()
```

### 3.2 Múltiplos erros no mesmo campo

Use quando um campo viola **mais de uma regra** e você quer reportar **todas as violações de uma vez**. Lance `ValidationError` com uma **lista**:

```python
# No Serializer (DRF):
def validate_password(self, value):
    errors = []

    if len(value) < 8:
        errors.append("A senha deve ter pelo menos 8 caracteres.")
    if not any(c.isupper() for c in value):
        errors.append("A senha deve conter pelo menos uma letra maiúscula.")
    if not any(c.isdigit() for c in value):
        errors.append("A senha deve conter pelo menos um número.")

    if errors:
        raise serializers.ValidationError(errors)
    return value


# No clean_<campo>() do Form:
def clean_password(self):
    value = self.cleaned_data.get("password", "")
    errors = []

    if len(value) < 8:
        errors.append("A senha deve ter pelo menos 8 caracteres.")
    if not any(c.isupper() for c in value):
        errors.append("A senha deve conter pelo menos uma letra maiúscula.")
    if not any(c.isdigit() for c in value):
        errors.append("A senha deve conter pelo menos um número.")

    if errors:
        raise ValidationError(errors)
    return value
```

### 3.3 Múltiplos erros em campos diferentes (validação cruzada)

Use quando a validação envolve **2 ou mais campos** e você quer reportar **todos os erros de uma vez**, cada um associado ao seu respectivo campo. Lance `ValidationError` com um **dicionário**:

```python
# No Serializer (DRF) -- validate():
def validate(self, attrs):
    errors = {}

    if attrs.get("status") == "COMPLETED" and attrs.get("total_amount", 0) <= 0:
        errors["total_amount"] = "Pedidos concluídos devem ter valor positivo."

    if attrs.get("status") == "COMPLETED" and not attrs.get("code"):
        errors["code"] = "Pedidos concluídos devem ter um código atribuído."

    if errors:
        raise serializers.ValidationError(errors)
    return attrs


# No clean() do Model ou Form:
def clean(self):
    super().clean()
    errors = {}

    if self.status == "COMPLETED" and (self.total_amount is None or self.total_amount <= 0):
        errors["total_amount"] = "Pedidos concluídos devem ter valor positivo."

    if self.status == "COMPLETED" and not self.code:
        errors["code"] = "Pedidos concluídos devem ter um código atribuído."

    if errors:
        raise ValidationError(errors)
```

---

## 4. Exemplo: Validação Inline no Serializer (Padrão)

Este é o padrão **preferido** quando as validações não são reutilizadas em outro lugar:

```python
from rest_framework import serializers
from apps.orders.models import Order


class OrderWriteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ["user", "code", "status", "total_amount"]

    def validate_code(self, value):
        if not value or not value.startswith("ORD-"):
            raise serializers.ValidationError("O código deve iniciar com 'ORD-'.")
        return value.upper()

    def validate_total_amount(self, value):
        if value is None or value <= 0:
            raise serializers.ValidationError("O valor deve ser maior que zero.")
        return value

    def validate(self, attrs):
        errors = {}

        if attrs.get("status") == "COMPLETED" and attrs.get("total_amount", 0) <= 0:
            errors["total_amount"] = "Pedidos concluídos devem ter valor positivo."

        if attrs.get("status") == "COMPLETED" and not attrs.get("code"):
            errors["code"] = "Pedidos concluídos devem ter um código atribuído."

        if errors:
            raise serializers.ValidationError(errors)
        return attrs
```

---

## 5. Exemplo: Extração para `validators.py` (Quando Necessário)

Extraia **somente** quando houver reuso ou o Serializer estiver muito gordo:

### A. `validators.py` (raiz do app)

```python
from django.core.exceptions import ValidationError


def validate_order_code_format(value):
    if not value or not value.startswith("ORD-"):
        raise ValidationError("O código do pedido deve iniciar com 'ORD-'.")


def validate_positive_amount(value):
    if value is None or value <= 0:
        raise ValidationError("O valor deve ser estritamente maior que zero.")
```

### B. Reuso no `models.py` (campo `validators` + `clean`)

```python
from django.db import models
from django.core.exceptions import ValidationError
from apps.orders.validators import validate_order_code_format, validate_positive_amount


class Order(models.Model):
    code = models.CharField(
        max_length=50,
        validators=[validate_order_code_format],
    )
    status = models.CharField(max_length=20, default="PENDING")
    total_amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[validate_positive_amount],
    )

    class Meta:
        indexes = [models.Index(fields=["status"])]

    objects = models.Manager()

    def clean(self):
        super().clean()
        errors = {}

        if self.status == "COMPLETED" and (self.total_amount is None or self.total_amount <= 0):
            errors["total_amount"] = "Pedidos concluídos devem ter valor positivo."

        if self.status == "COMPLETED" and not self.code:
            errors["code"] = "Pedidos concluídos devem ter um código atribuído."

        if errors:
            raise ValidationError(errors)

    def __str__(self):
        return f"Order #{self.code}"
```

### C. Reuso no `serializers.py` (delegando para o validator)

```python
from rest_framework import serializers
from apps.orders.models import Order
from apps.orders.validators import validate_order_code_format, validate_positive_amount


class OrderWriteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ["user", "code", "status", "total_amount"]

    def validate_code(self, value):
        validate_order_code_format(value)
        return value.upper()

    def validate_total_amount(self, value):
        validate_positive_amount(value)
        return value

    def validate(self, attrs):
        errors = {}

        if attrs.get("status") == "COMPLETED" and attrs.get("total_amount", 0) <= 0:
            errors["total_amount"] = "Pedidos concluídos devem ter valor positivo."

        if attrs.get("status") == "COMPLETED" and not attrs.get("code"):
            errors["code"] = "Pedidos concluídos devem ter um código atribuído."

        if errors:
            raise serializers.ValidationError(errors)
        return attrs
```

### D. Validadores de Domínio na Service Layer

Para regras de negócio que envolvem estado da entidade (não validação de input), use exceções de domínio customizadas na Service Layer:

```python
from django.db import transaction
from core.exceptions import BusinessValidationError
from apps.orders.models import Order


class OrderService:
    @staticmethod
    @transaction.atomic
    def cancel_order(order):
        if order.status == "COMPLETED":
            raise BusinessValidationError(
                "Não é possível cancelar um pedido que já foi concluído."
            )
        if order.status == "CANCELLED":
            raise BusinessValidationError("Este pedido já está cancelado.")

        order.status = "CANCELLED"
        order.save(update_fields=["status", "updated_at"])
        return order
```
