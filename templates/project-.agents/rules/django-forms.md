---
trigger:
  glob: "**/{forms.py,forms/**/*.py}"
---

# Regras de Desenvolvimento: Django Forms & ModelForms

Ao criar ou editar qualquer formulário no Django (`forms.py`), você DEVE seguir estritamente as regras de arquitetura, validação e minimalismo abaixo:

---

## 1. Escolha da Classe Base (`ModelForm` vs `Form`)

- **`forms.ModelForm`**: Use quando o formulário estiver diretamente vinculado a uma tabela do banco de dados (ex: criar/editar `Order`, `User`).
- **`forms.Form`**: Use para ações desvinculadas de um único model (ex: logins, buscas, transferências entre contas ou ações de serviço).

---

## 2. Ordem Estrutural Obrigatória da Classe `ModelForm`

Toda classe `ModelForm` DEVE seguir esta ordem determinística:

1. **`class Meta`**: Definindo `model`, `fields`, `widgets`, `labels` e `help_texts`.
2. **Métodos de Validação de Campo Único**: `clean_<nome_do_campo>()`.
3. **Método de Validação Cruzada / Global**: `clean()`.
4. **Métodos Helpers / Delegação para Service Layer**.

---

## 3. Validação e Tratamento de Dados

- **Validação de Campo Único (`clean_<campo>()`)**: Use para validar formatos ou restrições de um único campo. Retorne o valor limpo ao final.
- **Validação Cruzada (`clean()`)**: Use para regras que envolvam 2 ou mais campos simultaneamente. Lance `forms.ValidationError` em falhas.

---

## 4. Integração com Django Admin (`ModelAdmin`)

Associe o formulário customizado diretamente no atributo `form` da classe `ModelAdmin`:

```python
from django.contrib import admin
from .forms import OrderAdminForm
from .models import Order


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    form = OrderAdminForm
    list_display = (
        "code",
        "user",
        "status",
        "total_amount",
        "created_at",
    )
    search_fields = (
        "code",
        "user__email",
    )
    autocomplete_fields = ("user",)
```

---

## 5. Exemplo Completo de Implementação (`ModelForm`)

```python
from django import forms
from django.core.exceptions import ValidationError
from .models import Order


class OrderAdminForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = [
            "user",
            "code",
            "status",
            "total_amount",
            "notes",
            "is_active",
        ]
        widgets = {
            "code": forms.TextInput(
                attrs={
                    "class": "vTextField",
                    "placeholder": "Ex: ORD-12345",
                }
            ),
            "status": forms.Select(
                attrs={
                    "class": "custom-select",
                }
            ),
            "notes": forms.Textarea(
                attrs={
                    "rows": 4,
                    "placeholder": "Observações...",
                }
            ),
            "total_amount": forms.NumberInput(
                attrs={
                    "step": "0.01",
                }
            ),
        }
        labels = {
            "code": "Código do Pedido",
            "total_amount": "Valor Total (R$)",
        }

    def clean_code(self):
        code = self.cleaned_data.get("code")
        if code and not code.startswith("ORD-"):
            raise ValidationError("O código do pedido deve começar com 'ORD-'.")

        return code.upper()

    def clean(self):
        cleaned_data = super().clean()
        status = cleaned_data.get("status")
        total_amount = cleaned_data.get("total_amount")

        if status == "COMPLETED" and (total_amount is None or total_amount <= 0):
            raise ValidationError(
                "Não é possível concluir um pedido com valor zerado ou negativo."
            )

        return cleaned_data
```

---

## 6. Exemplo de Formulário Genérico (`Form`) com Service Layer

```python
from decimal import Decimal
from django import forms
from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError

User = get_user_model()


class BalanceTransferForm(forms.Form):
    source_user = forms.ModelChoiceField(
        queryset=User.objects.filter(is_active=True),
        label="Usuário Origem",
    )
    target_user = forms.ModelChoiceField(
        queryset=User.objects.filter(is_active=True),
        label="Usuário Destino",
    )
    amount = forms.DecimalField(
        max_digits=10,
        decimal_places=2,
        min_value=Decimal("0.01"),
        label="Valor (R$)",
    )

    def clean(self):
        cleaned_data = super().clean()
        source = cleaned_data.get("source_user")
        target = cleaned_data.get("target_user")

        if source and target and source == target:
            raise ValidationError(
                "O usuário de origem não pode ser igual ao de destino."
            )

        return cleaned_data

    def execute(self):
        from .services import AccountService

        return AccountService.transfer(
            source_user=self.cleaned_data["source_user"],
            target_user=self.cleaned_data["target_user"],
            amount=self.cleaned_data["amount"],
        )
```
