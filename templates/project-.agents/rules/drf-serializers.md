---
trigger:
  glob: "**/{serializers.py,serializers/**/*.py}"
---

# Regras de Desenvolvimento: DRF Serializers

Ao criar ou editar qualquer serializador no Django REST Framework (`serializers.py`), você DEVE seguir estritamente as regras de arquitetura, separação de responsabilidades e sintaxe abaixo:

---

## 1. Separação Estrita entre Leitura (`ReadSerializer`) e Escrita (`WriteSerializer`)

- **É PROIBIDO** utilizar o mesmo `ModelSerializer` para operações de leitura (GET) e escrita (POST/PUT/PATCH).
- **`ReadSerializer`**:
  - Utilizado em requisições de consulta (`list`, `retrieve`).
  - Contém relacionamentos aninhados (*nested serializers*) detalhados para exibição rica.
  - Todos os campos são marcados como `read_only=True`.
- **`WriteSerializer`**:
  - Utilizado em requisições de mutação (`create`, `update`, `partial_update`).
  - Recebe apenas chaves primárias planas (`PrimaryKeyRelatedField` / IDs), garantindo *payloads* leves.
  - Focado estritamente em validação sintática e de tipos.

---

## 2. Validações Sintáticas vs Regras de Negócio

- **O que validar no Serializer**: Apenas validação sintática, formatos de dados, obrigatoriedade de campos e coerção de tipos.
- **PROIBIDO no Serializer**: Executar transações de banco de dados (`transaction.atomic`), regras de domínio complexas ou chamadas a serviços externos. Toda a execução de negócio DEVE ser delegada para a **Service Layer (`services.py`)**.

---

## 3. Estrutura de Validação de Dados

- **Validação de Campo Único (`validate_<nome_do_campo>`)**: Use para validar o formato de um campo individual. Retorne o valor validado/normalizado.
- **Validação Cruzada (`validate`)**: Use para checar consistência sintática entre dois ou mais campos.

---

## 4. Exemplos de Implementação (Otimizados para Agentes)

```python
from rest_framework import serializers
from apps.orders.models import Order
from apps.users.api.serializers import UserReadSerializer


class OrderReadSerializer(serializers.ModelSerializer):
    user = UserReadSerializer(read_only=True)
    formatted_total = serializers.SerializerMethodField()

    class Meta:
        model = Order
        fields = [
            "id",
            "code",
            "user",
            "status",
            "total_amount",
            "formatted_total",
            "created_at",
        ]

    def get_formatted_total(self, obj):
        return f"R$ {obj.total_amount:.2f}"


class OrderWriteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = [
            "user",
            "code",
            "total_amount",
            "status",
        ]

    def validate_code(self, value):
        if not value.startswith("ORD-"):
            raise serializers.ValidationError(
                "O código do pedido deve iniciar com 'ORD-'."
            )
        return value.upper()

    def validate(self, attrs):
        status = attrs.get("status")
        total_amount = attrs.get("total_amount")

        if status == "COMPLETED" and (total_amount is None or total_amount <= 0):
            raise serializers.ValidationError(
                "Pedidos concluídos devem ter um valor válido."
            )

        return attrs
```
