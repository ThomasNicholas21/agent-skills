# Workflow: Plano de Nova Funcionalidade em 3 Fases (create-feature-plan-workflow)

Este workflow guia a análise de requisitos, debate de possibilidades e a elaboração de um plano de implementação estruturado em 3 fases sequenciais e independentes para a construção de novas funcionalidades.

---

## 1. Análise de Requisitos e Debate com o Usuário

1. **Entendimento da Demanda**: Analise o requisito solicitado pelo usuário.
2. **Consulta ao Second Brain**: Execute `/obsidian-find <termo>` ou `/obsidian-project` para resgatar ADRs e decisões históricas no cofre.
3. **Exploração do Repositório**: Inspecione o código existente com comandos RTK (`rtk grep`, `rtk find`) para evitar duplicações.
4. **Debate de Possibilidades**: Apresente ao usuário as opções de arquitetura, vantagens, desvantagens e alinhe a abordagem técnica antes de criar o plano.

---

## 2. Estrutura do Plano de Implementação em 3 Fases Sequenciais

O plano de implementação DEVE ser dividido obrigatoriamente em **3 Fases Separadas**. Cada fase DEVE ser aprovada e executada de forma totalmente independente:

```text
Fase 1: Models First  ──>  Fase 2: API Layer  ──>  Fase 3: Business Logic and Validation
 (Executar e Validar)       (Executar e Validar)      (Executar e Validar)
```

---

### Fase 1: Models First (Camada de Persistência)
- **Skills**: Invoque a skill `django-model`.
- **Foco**:
  - Modelos Django (`models.py`), campos específicos (UUID, Decimal, etc.).
  - Custom QuerySets e Managers encadeáveis (`managers.py`).
  - Restrições de banco (`UniqueConstraint`, `CheckConstraint`) e Meta.
  - Otimizações no Django Admin (`admin.py`).
- **Entregável**: Modelos criados, migrados e testados isoladamente.

---

### Fase 2: API Layer (Serializers, Views, ViewSets, Schemas e URLs)
- **Skills**: Invoque as skills `drf-serializer`, `drf-view`, `drf-viewset`, `drf-schema` e `drf-django-url`.
- **Foco**:
  - `ModelSerializer` e `Serializer` (validações de 3 níveis, escrita aninhada manual com `transaction.atomic()`).
  - ViewSets (`ModelViewSet`, `ReadOnlyModelViewSet`, `@action`) ou `APIView`.
  - Módulo `schemas.py` com decoradores `@extend_schema_view` / `@extend_schema`.
  - Roteamento modular (`urls.py`, `nested_urls.py`, `SimpleRouter`).
- **Entregável**: Endpoints RESTful funcionais e documentados no Swagger.

---

### Fase 3: Business Logic e Validações.
- **Skills**: Invoque as skills `django-drf-tests`, (`python-typing` e `python-docstring` se estiver sendo utilizado no projeto).
- **Foco**:
  - Camada de serviço (`services.py`), regras de negócio e integrações externas.
  - Testes automatizados por camada (Model, Serializer, ViewSet, Service) usando `Model Factory Mixins` (`create_<model>(**kwargs)`).
  - Asserções de performance de banco (`assertNumQueries`).
- **Entregável**: Suíte de testes automatizados passando e funcionalidade concluída.

---

## 3. Formato do Documento (`implementation_plan.md`)

O documento de plano gerado DEVE conter:
- Divisão explícita em Fase 1, Fase 2 e Fase 3.
- Justificativa técnica (*why*) para cada componente.
- Snippets de código de referência práticos e objetivos (sem prolixidade).
