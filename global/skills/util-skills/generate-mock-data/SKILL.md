---
name: generate-mock-data
description: >
  Habilidade Global para Geração de Dados Mockados (Mock Data Generator).
  Fornece utilitários, diretrizes e padrões para gerar dados mockados realistas, determinísticos e performáticos
  para testes funcionais, unitários e ambientes de desenvolvimento local usando Faker, FactoryBoy e Dictionaries tipados.
metadata:
  category: testing-utility
---

# Skill Global: Generate Mock Data (Gerador de Dados Mockados)

Esta habilidade orienta a criação de dados mockados realistas para alimentar casos de testes e fixtures de desenvolvimento sem depender de dados de produção.

---

## 1. Uilização do Faker com Locale pt_BR

Sempre configure a localização para português do Brasil (`pt_BR`) ao gerar nomes, documentos e endereços:

```python
from faker import Faker

fake = Faker('pt_BR')
Faker.seed(42)  # Opcional: Garante reprodutibilidade determinística

def generate_mock_user_payload() -> dict:
    return {
        "first_name": fake.first_name(),
        "last_name": fake.last_name(),
        "email": fake.email(),
        "cpf": fake.cpf(),
        "phone_number": fake.phone_number(),
        "address": {
            "street": fake.street_name(),
            "number": fake.building_number(),
            "neighborhood": fake.bairro(),
            "city": fake.city(),
            "state": fake.state_abbr(),
            "zip_code": fake.postcode()
        }
    }
```

---

## 2. Geração de Dados de Teste Performáticos via FactoryBoy

Ao utilizar ORM (Django, SQLAlchemy), instancie apenas os campos necessários:

```python
import factory
from faker import Faker

fake = Faker('pt_BR')

class OrderPayloadFactory:
    """
    Gera DTOs/Dicionários tipados sem persistência em banco de dados para testes ultrarápidos.
    """
    @staticmethod
    def build_valid_order_request() -> dict:
        return {
            "customer_cpf": fake.cpf(),
            "items": [
                {"product_id": fake.random_int(min=1, max=100), "quantity": fake.random_int(min=1, max=5)},
                {"product_id": fake.random_int(min=101, max=200), "quantity": 1}
            ],
            "payment_method": fake.random_element(elements=["CREDIT_CARD", "PIX", "BOLETO"]),
            "shipping_cost": float(fake.pydecimal(left_digits=2, right_digits=2, positive=True))
        }
```

---

## 3. Diretrizes de Performance em Mocks
1. **Evite Salvar no Banco Quando Desnecessário**: Use `.build()` em vez de `.create()` sempre que o teste validar apenas schemas ou transformações sintáticas.
2. **Reaproveitamento de Seeds**: Utilize seeds fixas em suítes CI/CD para evitar que testes falhem aleatoriamente devido a limites de borda estocásticos.
