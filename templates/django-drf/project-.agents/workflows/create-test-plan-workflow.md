---
name: create-test-plan-workflow
description: >-
  Workflow para elaboração de plano de testes automatizados abrangente em projetos Django/DRF.
  Mapeia lacunas de cobertura por camada (Models, Serializers, ViewSets, Services), alinha prioridades com
  o usuário e gera implementation_plan.md com snippets de teste (Model Factory Mixins, SimpleTestCase, TestCase, APITestCase).
  Use sempre que o usuário invocar /create-test-plan-workflow ou pedir plano de testes.
---

# Workflow: Plano de Testes Abrangente (create-test-plan-workflow)

Este workflow orienta a análise arquitetural completa de um repositório Django/DRF para elaborar um plano de testes automatizados cobrindo todas as camadas do projeto.

---

## 1. Varredura Completa do Repositório (Project Exploration)

1. **Invoque a skill `django-drf-tests`**.
2. **Inspeção de Módulos**: Mapeie todas as aplicações e camadas do repositório utilizando comandos RTK:
   - Models, Custom QuerySets e Managers (`models.py`, `managers.py`).
   - Serializers e validadores (`serializers.py`).
   - Views, ViewSets e Consumers (`views.py`, `viewsets.py`, `consumers.py`).
   - URLs e roteamento (`urls.py`, `nested_urls.py`).
   - Serviços e regras de negócio (`services.py`).
3. **Detecção do Framework de Testes**: Identifique se o projeto utiliza Django `unittest` nativo ou `pytest` (`pytest.ini`, `conftest.py`, `pyproject.toml`).

---

## 2. Análise de Lacunas e Cobertura por Camada

Mapeie as lacunas de teste identificadas nas seguintes categorias:
- **Models & QuerySets**: Constraints únicas, relacionamentos, managers customizados.
- **Serializers**: Validações de 3 níveis, campos obrigatórios, escrita aninhada manual.
- **ViewSets & Endpoints**: Status HTTP (`200`, `201`, `400`, `401`, `403`, `404`), permissões, filtros, `assertNumQueries`.
- **Services & Regras de Negócio**: Regras de cálculo, orquestração e transações (`transaction.atomic()`).

---

## 3. Debate e Alinhamento com o Usuário

1. Apresente um resumo executivo não verboso com as principais lacunas identificadas por camada.
2. Debata as prioridades de teste com o usuário.
3. Pergunte explicitamente ao usuário se deve gerar o arquivo de plano de implementação (`implementation_plan.md`).

---

## 4. Geração do Plano de Implementação (`implementation_plan.md`)

Após a confirmação do usuário, crie o plano de testes contendo:
- **Justificativa Técnica (*why*)**: Explicação curta do motivo de cada teste.
- **Código de Referência Específico**: Snippets de código prontos utilizando `SimpleTestCase`, `TestCase`, `APITestCase` ou `pytest`, com `force_authenticate` e `Model Factory Mixins` (`create_<model>(**kwargs)`).
