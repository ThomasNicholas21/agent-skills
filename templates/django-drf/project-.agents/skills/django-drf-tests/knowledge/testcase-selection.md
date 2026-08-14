# Knowledge: Seleção de Classes TestCase e Uso de setUpTestData

---

## 1. Tabela de Seleção de Classes de Teste

| Classe de Teste | Acesso ao Banco? | Isolamento Transacional | Caso de Uso Recomendado |
| :--- | :--- | :--- | :--- |
| `SimpleTestCase` | **NÃO** | N/A | Testes de utilitários, validadores sintáticos, formatadores e services sem persistência. Execução ultrarrápida. |
| `TestCase` | **SIM** | **SIM** (Rollback por teste) | Escolha padrão para a maioria dos testes que consultam ou persistem dados no ORM (Models, Services, Serializers e Views). |
| `TransactionTestCase` | **SIM** | **NÃO** (Flush de tabelas) | Usar **apenas** ao testar `transaction.atomic()`, commits reais ou locks. **PROIBIDO** usar por padrão (extremamente lento). |
| `APITestCase` (DRF) | **SIM** | **SIM** (Rollback por teste) | Escolha padrão para testar endpoints e ViewSets no Django REST Framework. Herda de `TestCase` do Django. |

---

## 2. Otimização de Performance com `setUpTestData`

Em testes que herdam de `TestCase` ou `APITestCase`:

- `setUp(self)`: Executa **antes de cada método de teste**. Use apenas se os dados forem alterados pelo teste.
- `@classmethod setUpTestData(cls)`: Executa **uma única vez por classe de teste**. Use para criar massa de dados imutável compartilhada entre múltiplos testes da mesma classe.

```python
from django.test import TestCase
from apps.users.tests.factories import UserFactory


class UserProfileServiceTestCase(TestCase):
    @classmethod
    def setUpTestData(cls):
        # Criado apenas UMA vez para todos os metodos desta classe
        cls.user = UserFactory.create_user(email="shared@domain.com")

    def test_profile_retrieval(self):
        self.assertEqual(self.user.email, "shared@domain.com")
```
