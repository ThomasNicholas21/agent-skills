---
name: django-drf-tests
description: >-
  Especialista em arquitetura de testes automatizados para Django e Django REST Framework.
  Aplica pirâmide de testes por camada, detecção de runner (unittest vs pytest/pytest-django/pytest-xdist),
  Model Factory Mixins com **kwargs, e testes de performance contra queries N+1.
---

# Django & DRF Tests Skill

Esta habilidade orienta a construção de suítes de testes determinísticas, isoladas, rápidas e estruturadas em camadas para projetos Django e Django REST Framework.

---

## Quando Ativar Esta Skill

Ative esta skill quando a tarefa envolver:
- Criar ou refatorar testes unitários, de integração ou testes de API REST no Django e DRF.
- Detectar se o repositório utiliza Django `unittest` nativo ou `pytest` (`pytest-django` / `pytest-xdist`).
- Escolher a classe base ideal de teste (`SimpleTestCase`, `TestCase`, `TransactionTestCase`, `APITestCase`).
- Criar **Model Factory Mixins** reutilizáveis com `create_<model>(**kwargs)` para desacoplar a criação de dados.
- Implementar verificações de regressão de performance de banco (`assertNumQueries` / `django_assert_num_queries`).
- Configurar execução paralela e otimização de velocidade de suíte (`setUpTestData`, `--keepdb`, `--reuse-db`).

---

## Regra Fundamental de Framework de Teste

> **Regra de Detecção de Runner**: O agente NUNCA deve introduzir `pytest` por preferência própria em projetos que não possuem `pytest` previamente configurado. Se o repositório possuir `pytest.ini`, `pyproject.toml` (com seção pytest) ou `conftest.py`, utilize `pytest` + `pytest-django`. Caso contrário, utilize o runner nativo do Django (`unittest` / `django.test`).

---

## Índice de Conhecimento Profundo (`knowledge/`)

1. [`knowledge/layered-testing.md`](./knowledge/layered-testing.md): Pirâmide de testes e responsabilidades por camada (Model, Serializer, ViewSet, Service, Integration).
2. [`knowledge/framework-detection.md`](./knowledge/framework-detection.md): Detecção de runner (Django `unittest` vs `pytest` + `pytest-django` + `pytest-xdist`).
3. [`knowledge/testcase-selection.md`](./knowledge/testcase-selection.md): `SimpleTestCase` vs `TestCase` vs `TransactionTestCase`, e uso de `setUpTestData`.
4. [`knowledge/drf-testing-tools.md`](./knowledge/drf-testing-tools.md): `APIRequestFactory`, `APIClient`, `force_authenticate`, `reverse()` e validação de status HTTP.
5. [`knowledge/factory-mixins.md`](./knowledge/factory-mixins.md): Padrão **Model Factory Mixins** com `create_<model>(**kwargs)` e defaults inteligentes.
6. [`knowledge/performance-and-isolation.md`](./knowledge/performance-and-isolation.md): `assertNumQueries`, `--keepdb`, `--reuse-db`, hasher rápido (`MD5PasswordHasher`) e `InMemoryStorage`.
7. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão para construção de testes e regras estritas.

---

## Exemplos de Código (`examples/`)

- [`examples/unit-service.md`](./examples/unit-service.md): Teste unitário puro de serviço sem acesso ao banco de dados (`SimpleTestCase`).
- [`examples/model-and-queryset.md`](./examples/model-and-queryset.md): Teste de Model e Custom QuerySet com `setUpTestData`.
- [`examples/serializer-validation.md`](./examples/serializer-validation.md): Teste de validação e representação de Serializer.
- [`examples/drf-api-viewset.md`](./examples/drf-api-viewset.md): Teste de endpoint DRF com `APITestCase`, `force_authenticate` e `assertNumQueries`.
- [`examples/mixin-factory.md`](./examples/mixin-factory.md): Exemplo completo de **Model Factory Mixin reutilizável com `**kwargs`**.
- [`examples/pytest-fixture-and-parametrize.md`](./examples/pytest-fixture-and-parametrize.md): Exemplo de teste com `pytest` + `pytest-django` + `@pytest.mark.parametrize` (utilizado apenas quando `pytest` estiver configurado).

---

## Checklist de Implementação de Testes

1. **Detecção do Runner**: Verificou se o repositório usa `pytest` ou `unittest` nativo do Django antes de escrever a sintaxe do teste?
2. **Camada Correta**: Testou a regra na camada correta (regras de negócio em Services, validações no Serializer, HTTP no ViewSet)?
3. **Sem Banco Desnecessário**: Herdou de `SimpleTestCase` (ou omitiu `@pytest.mark.django_db`) quando o teste não exige persistência?
4. **Padrão Factory Mixin**: O setup de dados utiliza o método `create_<model>(**kwargs)` em vez de instanciar o modelo diretamente no teste?
5. **Uso de `setUpTestData`**: Utilizou `@classmethod def setUpTestData(cls)` para criar dados imutáveis compartilhados por testes de uma mesma classe?
6. **Verificação de Queries**: Adicionou `assertNumQueries(...)` em testes de endpoints críticos para prevenir N+1?
