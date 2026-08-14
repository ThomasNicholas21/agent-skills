---
trigger:
  glob: "**/test*.py"
---

# Regras de Desenvolvimento: Testes Automatizados (Django / DRF / Pytest)

Ao criar ou editar suítes de testes (`test*.py`), siga estritamente estes princípios.

---

## 1. Detecção Obrigatoria do Framework de Testes

- **Detecção do Runner**: O agente NUNCA deve introduzir `pytest` por preferência própria em projetos não configurados.
- **Regra de Seleção**:
  - Se o repositório possuir `pytest.ini`, `conftest.py` ou `pyproject.toml` (com seção `pytest`), utilize a sintaxe `pytest` + `pytest-django` (`@pytest.mark.django_db`).
  - Caso contrário, utilize a infraestrutura nativa do Django (`django.test.SimpleTestCase`, `django.test.TestCase`, `rest_framework.test.APITestCase`).

---

## 2. Escolha da Infraestrutura Mínima de Teste

| Tipo de Teste | Classe Base / Marcador | Acesso ao Banco | Uso Principal |
| :--- | :--- | :--- | :--- |
| **Unitário Puro** | `SimpleTestCase` (ou sem `@pytest.mark.django_db`) | **PROIBIDO** | Valudadores sintáticos, formatadores, utilitários, services sem banco. Execução ultrarrápida. |
| **Integração / Domain** | `TestCase` / `@pytest.mark.django_db` | **SIM** (Rollback por teste) | Models, Custom Managers, Services com persistência. |
| **API Endpoints** | `APITestCase` / `APIClient` | **SIM** (Rollback por teste) | Endpoints DRF, Autenticação, Permissões e Respostas. |
| **Transações Reais** | `TransactionTestCase` | **SIM** (Flush de tabelas) | Usar **apenas** para testar `transaction.atomic()` ou commit real. **PROIBIDO** como classe padrão. |

---

## 3. Test Setup & Model Factory Mixins

- **Proibição de Instanciação Direta Repetitiva**: NÃO instancie modelos com dezenas de parâmetros manualmente nos métodos de teste.
- **Uso de Test Mixins com `**kwargs`**: Utilize classes Mixin centralizadas em `apps/<app>/tests/mixins.py` com métodos `create_<model>(**kwargs)` que oferecem defaults inteligentes e aceitam sobrescrita flexível via `**kwargs`.
- **`setUpTestData(cls)`**: Prefira para criar massa de dados estáticos compartilhados executados apenas 1 vez por classe de teste.

---

## 4. Qualidade, Isolamento e Performance

- **Padrão AAA**: Organize métodos de teste estritamente em **Arrange** (Preparar), **Act** (Executar) e **Assert** (Verificar).
- **Sem I/O Externo**: Não faça requisições HTTP reais ou chamadas de serviços externos. Use `unittest.mock.patch` ou `InMemoryStorage`.
- **Autenticação Rápida**: Use `self.client.force_authenticate(user=user)` em vez de simular o fluxo completo de login em testes de API.
- **Verificação de Queries**: Use `self.assertNumQueries(N)` / `django_assert_num_queries` em testes de consulta para prevenir N+1.

---

## 5. Gatilho de Invocação de Skill

> *Para projetar suítes de teste unitárias, de integração, testes de API, detecção de runner ou **Model Factory Mixins com `**kwargs`**, **invoque a skill `django-drf-tests`**.*
