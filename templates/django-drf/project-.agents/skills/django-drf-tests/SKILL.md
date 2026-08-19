---
name: django-drf-tests
description: >-
  Especialista em testes automatizados para Django e DRF. Aplica pirâmide de testes por camada,
  detecção de runner (unittest vs pytest), Model Factory Mixins com **kwargs e prevenção de queries N+1.
---

# Django & DRF Tests Skill
Orienta a construção de suítes de testes determinísticas, rápidas e estruturadas por camadas para Django e DRF.

## Quando Ativar
- Criar ou refatorar testes unitários, de integração ou de API REST.
- Detectar se o repositório usa Django `unittest` nativo ou `pytest` (`pytest-django` / `pytest-xdist`).
- Escolher a classe base ideal (`SimpleTestCase`, `TestCase`, `TransactionTestCase`, `APITestCase`).
- Criar **Model Factory Mixins** reutilizáveis com `create_<model>(**kwargs)`.
- Validar contagem de queries ORM (`assertNumQueries` / `django_assert_num_queries`).

## Regra de Detecção de Runner
> NUNCA introduza `pytest` por preferência própria. Se o projeto tiver `pytest.ini`, `pyproject.toml` (com seção pytest) ou `conftest.py`, use `pytest` + `pytest-django`. Caso contrário, use o runner nativo do Django (`django.test`).

## Conhecimento (`knowledge/`)
1. [`knowledge/layered-testing.md`](./knowledge/layered-testing.md): Pirâmide de testes e responsabilidades por camada.
2. [`knowledge/framework-detection.md`](./knowledge/framework-detection.md): Detecção de runner e execução paralela.
3. [`knowledge/testcase-selection.md`](./knowledge/testcase-selection.md): `SimpleTestCase` vs `TestCase` vs `TransactionTestCase` e `setUpTestData`.
4. [`knowledge/drf-testing-tools.md`](./knowledge/drf-testing-tools.md): `APIClient`, `force_authenticate`, `reverse()` e status HTTP.
5. [`knowledge/factory-mixins.md`](./knowledge/factory-mixins.md): Padrão Model Factory Mixins com `**kwargs`.
6. [`knowledge/performance-and-isolation.md`](./knowledge/performance-and-isolation.md): `assertNumQueries`, `--keepdb`, `--reuse-db`.
7. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão e proibições.

## Exemplos (`examples/`)
- [`examples/unit-service.md`](./examples/unit-service.md): Teste unitário puro sem banco (`SimpleTestCase`).
- [`examples/model-and-queryset.md`](./examples/model-and-queryset.md): Teste de Model e Custom QuerySet com `setUpTestData`.
- [`examples/serializer-validation.md`](./examples/serializer-validation.md): Teste de validação de Serializer.
- [`examples/drf-api-viewset.md`](./examples/drf-api-viewset.md): Teste de API com `APITestCase`, `force_authenticate` e `assertNumQueries`.
- [`examples/mixin-factory.md`](./examples/mixin-factory.md): Exemplo completo de Model Factory Mixin.
- [`examples/pytest-fixture-and-parametrize.md`](./examples/pytest-fixture-and-parametrize.md): Teste com `pytest-django` e `@pytest.mark.parametrize`.

## Checklist
1. **Runner**: Verificou se usa `pytest` ou `unittest` antes de escrever o teste?
2. **Camada**: Testou regras em Services, validações no Serializer e HTTP no ViewSet?
3. **Sem Banco Desnecessário**: Usou `SimpleTestCase` quando não há acesso ao ORM?
4. **Factory Mixin**: Usou `create_<model>(**kwargs)` em vez de `Model.objects.create()` solto no teste?
5. **`setUpTestData`**: Usou `@classmethod setUpTestData` para dados imutáveis compartilhados?
6. **Performance**: Adicionou `assertNumQueries(...)` em listagens e endpoints críticos?