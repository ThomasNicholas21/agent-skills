# Workflow: Plano de Nova Funcionalidade – Analyze Before Plan (create-feature-plan-workflow)

Este workflow segue o padrão **Analyze-Before-Plan**: o agente investiga, debate com o usuário e só gera o plano de implementação sob comando explícito. A feature é dividida em **3 fases lazy** (Models → API → Business), cada uma com seu próprio `implementation_plan.md` gerado, aprovado e executado sequencialmente.

> ⛔ **REGRA INVIOLÁVEL**: O agente é **PROIBIDO** de gerar `implementation_plan.md` em qualquer momento deste workflow sem que o usuário peça explicitamente (ex: "gere o plano", "pode criar", "monta o plano"). A fase de debate DEVE ocorrer primeiro.

---

## Fase A – Análise Exploratória

Objetivo: Montar contexto técnico antes de qualquer discussão.

1. **Entendimento da Demanda**: Leia e interprete o requisito do usuário sem fazer suposições.
2. **Consulta ao Second Brain**: Execute `/obsidian-find <termo>` e `/obsidian-project` para resgatar ADRs, decisões históricas e padrões já utilizados no cofre.
3. **Exploração do Repositório**: Inspecione o código existente com RTK para identificar:
   - Models, Serializers, ViewSets e Services que tocam o mesmo domínio.
   - Padrões de nomenclatura, mixins e abstrações já adotados.
   - Testes existentes e cobertura da área impactada.
4. **Síntese Silenciosa**: Organize internamente os achados. **NÃO** apresente um plano — apenas prepare-se para o debate.

---

## Fase B – Debate Híbrido com o Usuário

Objetivo: Alinhar requisitos, esclarecer ambiguidades e convergir na solução técnica.

> ⛔ **GATE**: O agente NÃO gera nenhum plano nesta fase. Apenas faz perguntas e debate.

### B.1 – Primeira Rodada: Perguntas Estruturadas

Apresente ao usuário uma lista organizada de perguntas, agrupadas por tema:

- **Requisitos Funcionais**: Quais entidades/recursos? Quais operações (CRUD, ações customizadas)? Quais campos obrigatórios?
- **Regras de Negócio**: Quais validações e invariantes? Quais transições de estado? Existem dependências entre entidades?
- **Edge Cases**: Cenários de concorrência? Soft delete vs hard delete? Limites de volume?
- **Integrações**: Consome ou expõe APIs externas? Filas/eventos? Webhooks?
- **Escopo e Prioridade**: MVP vs versão completa? Quais partes são essenciais vs nice-to-have?

### B.2 – Aprofundamento Socrático

Após as respostas da primeira rodada:

1. Aprofunde **um ponto por vez**, fazendo perguntas de follow-up nos temas que ficaram ambíguos.
2. Proponha alternativas técnicas quando houver mais de uma abordagem viável (ex: "podemos usar `choices` ou uma tabela separada — qual prefere?").
3. Questione premissas implícitas (ex: "você mencionou soft delete — precisa de auditoria de quem deletou?").
4. Continue até que **todos os pontos estejam resolvidos** e o usuário confirme que está satisfeito.

### B.3 – Confirmação de Prontidão

Quando o debate convergir, pergunte ao usuário:

> "Todas as dúvidas estão resolvidas. Deseja que eu gere o roadmap e o primeiro plano de implementação (Models)?"

**Só avance para a Fase C com resposta afirmativa explícita.**

---

## Fase C – Roadmap e Planejamento Lazy

Objetivo: Gerar o roadmap como memória do agente e o `implementation_plan.md` da próxima fase pendente.

### C.1 – Gerar o Roadmap (`feature_roadmap.md`)

Crie o artefato `feature_roadmap.md` no diretório de artefatos da conversa (`appDataDir/brain/<conversation-id>/`) com o seguinte template:

```markdown
# Feature Roadmap: <Nome da Feature>

## Visão Geral
<Resumo em 2-3 linhas do que a feature entrega>

## Fases de Implementação

| # | Fase | Status | Escopo Resumido |
|---|------|--------|-----------------|
| 1 | Models First | ⬜ Pendente | <resumo> |
| 2 | API Layer | ⬜ Pendente | <resumo> |
| 3 | Business Logic | ⬜ Pendente | <resumo> |

**Legenda**: ⬜ Pendente · 🔄 Em Progresso · ✅ Concluída

## Decisões do Debate
- <decisão 1 alinhada com o usuário>
- <decisão 2>
- ...

## Dependências Entre Fases
- Fase 2 depende de: Models e migrações da Fase 1.
- Fase 3 depende de: Endpoints da Fase 2 (para testes de integração).
```

Após criar, salve no Second Brain via `/obsidian-save` para rastreabilidade.

### C.2 – Gerar `implementation_plan.md` da Fase Atual

Gere **somente** o `implementation_plan.md` da próxima fase pendente no roadmap, seguindo o conteúdo específico de cada fase:

---

#### Quando a Fase Atual for: **Fase 1 – Models First (Camada de Persistência)**

- **Skills**: Invoque a skill `django-model`.
- **Escopo do Plano**:
  - Modelos Django (`models.py`), campos específicos (UUID, Decimal, etc.).
  - Custom QuerySets e Managers encadeáveis (`managers.py`).
  - Restrições de banco (`UniqueConstraint`, `CheckConstraint`) e Meta.
  - Otimizações no Django Admin (`admin.py`).
- **Entregável esperado**: Modelos criados, migrados e testados isoladamente.

---

#### Quando a Fase Atual for: **Fase 2 – API Layer (Serializers, Views, ViewSets, Schemas e URLs)**

- **Skills**: Invoque as skills `drf-serializer`, `drf-view`, `drf-viewset`, `drf-schema` e `drf-django-url`.
- **Escopo do Plano**:
  - `ModelSerializer` e `Serializer` (validações de 3 níveis, escrita aninhada manual com `transaction.atomic()`).
  - ViewSets (`ModelViewSet`, `ReadOnlyModelViewSet`, `@action`) ou `APIView`.
  - Módulo `schemas.py` com decoradores `@extend_schema_view` / `@extend_schema`.
  - Roteamento modular (`urls.py`, `nested_urls.py`, `SimpleRouter`).
- **Entregável esperado**: Endpoints RESTful funcionais e documentados no Swagger.

---

#### Quando a Fase Atual for: **Fase 3 – Business Logic e Validações**

- **Skills**: Invoque as skills `django-drf-tests`, (`python-typing` e `python-docstring` se estiver sendo utilizado no projeto).
- **Escopo do Plano**:
  - Camada de serviço (`services.py`), regras de negócio e integrações externas.
  - Testes automatizados por camada (Model, Serializer, ViewSet, Service) usando `Model Factory Mixins` (`create_<model>(**kwargs)`).
  - Asserções de performance de banco (`assertNumQueries`).
- **Entregável esperado**: Suíte de testes automatizados passando e funcionalidade concluída.

---

## Fase D – Ciclo Lazy de Execução

Objetivo: Executar cada fase sequencialmente, atualizando o roadmap entre elas.

```text
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ Gerar Plano  │ ──► │ Usuário      │ ──► │ Executar     │ ──► │ Atualizar    │
│ da Fase N    │     │ Aprova       │     │ Fase N       │     │ Roadmap      │
│              │     │              │     │              │     │ (✅ Fase N)  │
└──────────────┘     └──────────────┘     └──────────────┘     └──────┬───────┘
                                                                      │
                                                          ┌───────────▼──────────┐
                                                          │ Há fase pendente?    │
                                                          │ SIM → Volta ao topo  │
                                                          │ NÃO → Feature pronta │
                                                          └──────────────────────┘
```

### Regras do Ciclo:

1. **Um plano por vez**: Sempre use o nome `implementation_plan.md`. O plano anterior é sobrescrito ao gerar o próximo.
2. **Consulte o roadmap**: Antes de gerar cada plano, leia `feature_roadmap.md` para identificar a próxima fase pendente.
3. **Atualize o roadmap**: Após executar cada fase, marque-a como ✅ no `feature_roadmap.md`.
4. **Gate entre fases**: Ao terminar uma fase, pergunte ao usuário: "Fase N concluída. Deseja que eu gere o plano da Fase N+1?"
5. **Persista no Second Brain**: Ao concluir a última fase, execute `/obsidian-save` para registrar a feature como concluída.

---

## Formato do `implementation_plan.md`

Cada plano gerado DEVE conter:

- **Contexto da Fase**: Qual fase do roadmap está sendo implementada e o que já foi feito nas fases anteriores.
- **Escopo Delimitado**: Somente os componentes desta fase — sem antecipar fases futuras.
- **Justificativa Técnica (*why*)**: Para cada componente, explique o motivo da escolha.
- **Snippets de Código de Referência**: Práticos e objetivos (sem prolixidade).
- **Plano de Verificação**: Como validar que a fase foi concluída com sucesso (testes, migrações, endpoints).
