---
trigger:
  glob: "**/test*.py"
---

# Regras de Desenvolvimento: Testes Django/DRF Performáticos, Isolados e Determinísticos

Ao criar ou editar qualquer arquivo de teste (`test*.py`), agentes e LLMs DEVEM seguir estritamente estas regras.

O objetivo é produzir testes rápidos, determinísticos, independentes, paralelizáveis, fáceis de manter, com o menor custo de banco e I/O, adequados para execução local e CI/CD.

Prioridade arquitetural de testes:
> **Teste mais simples possível → Menor infraestrutura necessária → Menor custo de execução.**

---

## 1. Escolha da Classe de Teste por Infraestrutura Mínima

A classe base DEVE ser escolhida de acordo com a infraestrutura realmente necessária pelo comportamento testado:

| Classe | Banco | Uso Principal | Regra |
| :--- | :--- | :--- | :--- |
| **`SimpleTestCase`** | **PROIBIDO** (`databases = set()`) | Unitários puros com dependência Django (validadores, serializers sintáticos). | Preferencial quando não há ORM |
| **`unittest.TestCase`** | **PROIBIDO** | Unitários puros sem dependência Django (funções puras, utilitários). | Usar quando Django não é necessário |
| **`TestCase`** | **SIM** (Rollback Transacional) | Models, Managers, QuerySets, Service Layer e integração ORM. | Classe padrão para testes com banco |
| **`APITestCase`** | **SIM** (Rollback Transacional) | Endpoints DRF, autenticação, permissões, serializers integrados. | Classe padrão para testes de API |
| **`TransactionTestCase`** | **SIM** (Commit Real) | Transações reais, `select_for_update()`, commit/rollback explícito. | **EXCEÇÃO RARA** |
| **`APITransactionTestCase`** | **SIM** (Commit Real) | Equivalente ao anterior para API DRF. | **EXCEÇÃO RARA** |

### Fluxo de Decisão:

```text
Precisa de banco?
│
├── NÃO
│   ├── Precisa de Django? ──> SimpleTestCase
│   └── Não precisa ─────────> unittest.TestCase
│
└── SIM
    ├── Precisa de transação real? ──> TransactionTestCase / APITransactionTestCase
    └── NÃO ────────────────────────> TestCase / APITestCase
```

---

## 2. Testes Unitários Sem Banco (`SimpleTestCase`)

Quando o comportamento não depende de persistência, ORM ou transação:

```python
from django.test import SimpleTestCase
from apps.orders.validators import validate_order_code_format


class ValidateOrderCodeTest(SimpleTestCase):
    databases = set()

    def test_should_accept_valid_code(self):
        validate_order_code_format("ORD-12345")

    def test_should_reject_invalid_code(self):
        with self.assertRaises(ValidationError):
            validate_order_code_format("INVALID-12345")
```

NÃO adicionar dependência de banco de dados apenas para facilitar a escrita do teste.

---

## 3. Uso Correto de `setUpTestData()` vs `setUp()`

- **`setUpTestData(cls)`**: Deve ser preferido para criar dados estáticos compartilhados por toda a classe de teste (executado apenas 1 vez por classe).
- **`setUp(self)`**: Usar **apenas** para dados que precisam ser redefinidos/recriados a cada método de teste.

```python
class OrderServiceTest(OrderTestMixin, TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.user = cls.create_user()

    def test_should_create_order(self):
        order = OrderService.create_order(
            user=self.user, validated_data={"code": "ORD-123"}
        )
        self.assertEqual(order.code, "ORD-123")
```

⚠️ **Aviso**: NÃO crie dezenas de objetos em `setUpTestData()` que somente um método de teste utiliza. Crie apenas dependências realmente compartilhadas.

---

## 4. Reuso de Dados com Test Mixins (Sem Instanciação Manual)

Helpers de criação de modelos DEVEM ser centralizados em classes Mixin em `apps/<app>/tests/mixins.py`.

### Regras de Uso de Mixins:
1. **NÃO instancie Mixins manualmente** (`mixin = OrderTestMixin()`). O Mixin DEVE ser herdado pela classe de teste.
2. Mixins podem herdar outros mixins para reutilizar dependências (`OrderTestMixin` herda de `UserTestMixin`).
3. Mixins DEVEM fornecer valores padrão inteligentes e aceitar *overrides*.

```python
# apps/orders/tests/mixins.py
import uuid
from decimal import Decimal
from apps.orders.models import Order
from apps.users.tests.mixins import UserTestMixin


class OrderTestMixin(UserTestMixin):

    def create_order(
        self,
        *,
        user=None,
        status="PENDING",
        total_amount=Decimal("100.00"),
        is_active=True,
    ):
        if user is None:
            user = self.create_user()

        return Order.objects.create(
            user=user,
            code=f"ORD-{uuid.uuid4().hex[:6].upper()}",
            status=status,
            total_amount=total_amount,
            is_active=is_active,
        )
```

```python
# apps/orders/tests/test_services.py
from django.test import TestCase
from apps.orders.services import OrderService
from apps.orders.tests.mixins import OrderTestMixin


# Herança múltipla: Mixin vem ANTES da classe de teste do Django
class OrderServiceTest(OrderTestMixin, TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.user = cls.create_user()

    def test_should_cancel_order(self):
        order = self.create_order(user=self.user, status="PENDING")
        cancelled = OrderService.cancel_order(order=order)
        self.assertEqual(cancelled.status, "CANCELLED")
```

---

## 5. Testes de API DRF (`APITestCase` & `APIClient`)

### A. Autenticação Rápida (`force_authenticate`)
Quando o objetivo do teste NÃO for validar o fluxo de login em si, use `self.client.force_authenticate(user=user)` para evitar o custo de geração de tokens:

```python
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from apps.orders.tests.mixins import OrderTestMixin


class OrderApiTest(OrderTestMixin, APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.user = cls.create_user()
        cls.order = cls.create_order(user=cls.user)

    def test_should_list_orders(self):
        self.client.force_authenticate(user=self.user)
        url = reverse("orders-list")
        response = self.client.get(url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)
```

### B. Recomendações em Testes de API:
- **Usar `reverse()`**: NUNCA use URLs hardcoded (ex: `self.client.get("/api/orders/")`). Use `reverse("orders-list")` ou `reverse("orders-detail", kwargs={"pk": order.pk})`.
- **Formato JSON**: Em requisições de escrita, especifique o formato: `self.client.post(url, data, format="json")`.
- **Response Data**: Acesse `response.data` diretamente em vez de deserializar com `json.loads(response.content)`.

---

## 6. Proibição de Chamadas de Rede Reais & Mocking In-Place

Testes locais e de CI DEVEM ser 100% independentes de serviços externos (Gateways de pagamento, Firebase, SMTP, APIs REST terceiras).

- Use `unittest.mock.patch` mockando a dependência **no namespace onde ela é utilizada** (namespace do código sob teste):

```python
from unittest.mock import patch
from django.test import TestCase


class PaymentServiceTest(TestCase):

    @patch("apps.payments.services.gateway.create_payment")
    def test_should_process_payment(self, mock_create_payment):
        mock_create_payment.return_value = {
            "id": "pay_123",
            "status": "approved",
        }
        # Execução e validação da Service Layer local
```

---

## 7. `assertNumQueries()` para Verificação de Performance

Quando a eficiência da consulta (prevenção de N+1) for parte do contrato da funcionalidade:

```python
def test_should_fetch_orders_without_n_plus_one(self):
    url = reverse("orders-list")
    self.client.force_authenticate(user=self.user)

    with self.assertNumQueries(2):
        response = self.client.get(url)

    self.assertEqual(response.status_code, 200)
```

---

## 8. Determinismo, Paralelização e Flags do Test Runner

- **Nomenclatura**: Siga a convenção `test_should_<behavior>_when_<condition>`.
- **Independência**: Testes DEVEM rodar em qualquer ordem (`python manage.py test --shuffle`).
- **Paralelização**: Testes DEVEM suportar execução paralela (`python manage.py test --parallel 4`).
- **Banco em Dev**: Use `--keepdb` localmente para evitar reconstruir a estrutura do banco a cada execução.
- **Execução via RTK**:

```bash
rtk pytest apps/orders/tests/test_services.py
```
