# Workflow: Plano de Refatoração – Analyze Before Plan (create-refactor-plan-workflow)

Este workflow segue o padrão **Analyze-Before-Plan**: o agente investiga o impacto, debate com o usuário e só gera o plano de refatoração sob comando explícito.

> ⛔ **REGRA INVIOLÁVEL**: O agente é **PROIBIDO** de gerar `implementation_plan.md` em qualquer momento deste workflow sem que o usuário peça explicitamente (ex: "gere o plano", "pode criar", "monta o plano"). A fase de debate DEVE ocorrer primeiro.

---

## Fase A – Investigação de Impacto

Objetivo: Mapear o blast radius completo antes de qualquer discussão.

1. **Identificação do Alvo**: Defina exatamente a função, classe, modelo ou camada a ser refatorada.
2. **Varredura de Blast Radius**: Utilize `rtk grep` e `rtk find` para localizar todos os locais do repositório afetados pela alteração:
   - Impacto em Models, QuerySets e Managers.
   - Impacto em Serializers e regras de validação.
   - Impacto em ViewSets, Views e decoradores OpenAPI (`schemas.py`).
   - Impacto em Services, regras de negócio e integrações.
   - Impacto em URLs e rotas atreladas.
   - Impacto em testes existentes.
3. **Avaliação da Suíte de Testes Existente**: Execute os testes existentes via `rtk pytest`. Se a cobertura do código a ser refatorado for insuficiente, **sinalize ao usuário** que testes de regressão serão necessários ANTES de refatorar (skill `django-drf-tests`).
4. **Consulta ao Second Brain**: Execute `/obsidian-find <termo>` para resgatar ADRs e decisões históricas relacionadas ao código alvo.

---

## Fase B – Debate Híbrido com o Usuário

Objetivo: Alinhar escopo, riscos e abordagem da refatoração.

> ⛔ **GATE**: O agente NÃO gera nenhum plano nesta fase. Apenas faz perguntas e debate.

### B.1 – Primeira Rodada: Perguntas Estruturadas

Apresente ao usuário o mapa de impacto e uma lista organizada de perguntas:

- **Mapa de Impacto**: Quais arquivos e contratos serão afetados? Quantos locais de chamada existem?
- **Motivação**: Qual o objetivo da refatoração? Performance? Legibilidade? Remoção de tech debt? Mudança de contrato?
- **Compatibilidade**: A refatoração pode quebrar contratos públicos (APIs, interfaces)? Precisa de migração de dados?
- **Escopo**: Refatoração cirúrgica (mínima) ou estrutural (altera arquitetura)?
- **Testes**: A cobertura de testes atual é suficiente? Precisa de testes de regressão antes de refatorar?
- **Riscos**: Quais são os cenários de rollback se a refatoração causar problemas?

### B.2 – Aprofundamento Socrático

Após as respostas da primeira rodada:

1. Aprofunde **um ponto por vez**, fazendo perguntas de follow-up nos temas ambíguos.
2. Proponha alternativas de refatoração quando houver mais de uma abordagem (ex: "podemos extrair um mixin ou criar um service — qual caminho prefere?").
3. Apresente o **antes vs depois** conceitual dos trechos mais críticos.
4. Continue até que o escopo e a abordagem estejam totalmente convergidos.

### B.3 – Confirmação de Prontidão

Quando o debate convergir, pergunte ao usuário:

> "O escopo e a abordagem da refatoração estão alinhados. Deseja que eu gere o plano de implementação?"

**Só avance para a Fase C com resposta afirmativa explícita.**

---

## Fase C – Geração do Plano de Implementação

Objetivo: Gerar `implementation_plan.md` somente sob comando explícito do usuário.

### Formato do `implementation_plan.md`

O documento de plano gerado DEVE conter:

- **Resumo do Impacto**: Lista de componentes afetados e garantias de preservação de contrato.
- **Passo a Passo de Refatoração**:
  - Modificações pontuais em Models / Managers (skill `django-model`).
  - Otimizações no Serializer ou ViewSet (skills `drf-serializer` e `drf-viewset`).
  - Atualização de Schemas ou URLs (skills `drf-schema` e `drf-django-url`).
- **Justificativa (*why*) e Código de Referência**: Snippets objetivos demonstrando o código **antes** e **depois** da refatoração.
- **Testes de Regressão Necessários**: Se a cobertura era insuficiente, inclua os testes que devem ser criados antes (skill `django-drf-tests`).
- **Plano de Verificação de Regressão**: Comandos de testes automatizados e asserções de queries (`assertNumQueries`).
