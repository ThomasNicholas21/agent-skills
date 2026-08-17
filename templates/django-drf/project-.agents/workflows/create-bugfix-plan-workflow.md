---
name: create-bugfix-plan-workflow
description: >-
  Workflow determinístico para diagnóstico e correção de bugs (Analyze-Before-Plan).
  Investiga a causa raiz com evidências empíricas (tracebacks, testes, blast radius),
  conduz debate estruturado e gera implementation_plan.md somente sob aprovação explícita.
  Use sempre que o usuário invocar /create-bugfix-plan-workflow ou pedir diagnóstico/correção de bugs.
---

# Workflow: Plano de Correção de Bugs – Analyze Before Plan (create-bugfix-plan-workflow)

Este workflow segue o padrão **Analyze-Before-Plan**: o agente investiga a causa raiz, debate com o usuário e só gera o plano de correção sob comando explícito.

> ⛔ **REGRA INVIOLÁVEL**: O agente é **PROIBIDO** de gerar `implementation_plan.md` em qualquer momento deste workflow sem que o usuário peça explicitamente (ex: "gere o plano", "pode criar", "monta o plano"). A fase de debate DEVE ocorrer primeiro.

---

## Fase A – Diagnóstico e Reprodução

Objetivo: Identificar a causa raiz com evidências empíricas antes de qualquer discussão.

1. **Análise de Traceback**: Leia a traceback completa de erros ou logs de exceção sem fazer suposições.
2. **Execução de Código e Testes**: Execute os testes afetados (`rtk pytest`) ou scripts de reprodução em `scratch/` para observar o comportamento do erro em runtime.
3. **Mapeamento de Causa Raiz**: Identifique o motivo exato pelo qual o bug ocorre (violação de contrato, `NullPointerException`, query N+1, falha de validação no Serializer, estado inconsistente no banco).
4. **Avaliação de Blast Radius**: Utilize `rtk grep` para mapear quais módulos adjacentes podem ser afetados pela correção (efeitos colaterais).

---

## Fase B – Debate Híbrido com o Usuário

Objetivo: Apresentar evidências, alinhar hipóteses e convergir na abordagem de correção.

> ⛔ **GATE**: O agente NÃO gera nenhum plano nesta fase. Apenas faz perguntas e debate.

### B.1 – Primeira Rodada: Perguntas Estruturadas

Apresente ao usuário as evidências coletadas e uma lista organizada de perguntas:

- **Evidências Empíricas**: Traceback, output dos testes, logs de reprodução.
- **Hipótese de Causa Raiz**: Qual é a explicação mais provável? Existem hipóteses alternativas?
- **Reprodutibilidade**: O bug é determinístico ou intermitente? Depende de dados específicos ou estado?
- **Blast Radius**: A correção pode impactar outros módulos? Quais contratos adjacentes são afetados?
- **Cenários de Teste**: Quais cenários (happy path, edge cases) devem ser cobertos pelo teste de regressão?
- **Prioridade**: Qual é o impacto do bug em produção? Precisa de hotfix ou pode seguir o fluxo normal?

### B.2 – Aprofundamento Socrático

Após as respostas da primeira rodada:

1. Aprofunde **um ponto por vez**, investigando os detalhes que ficaram vagos.
2. Questione premissas (ex: "você disse que o bug só acontece com dados X — já testou com Y?").
3. Se houver múltiplas hipóteses, proponha testes de eliminação para confirmar a causa raiz.
4. Continue até que a causa raiz esteja **confirmada** e a abordagem de correção esteja alinhada.

### B.3 – Confirmação de Prontidão

Quando o debate convergir, pergunte ao usuário:

> "A causa raiz e a abordagem de correção estão confirmadas. Deseja que eu gere o plano de implementação?"

**Só avance para a Fase C com resposta afirmativa explícita.**

---

## Fase C – Geração do Plano de Correção

Objetivo: Gerar `implementation_plan.md` somente sob comando explícito do usuário.

### Formato do `implementation_plan.md`

O documento de plano gerado DEVE conter:

- **Diagnóstico da Causa Raiz**: Explicação clara do motivo pelo qual o bug ocorre, com evidências empíricas.
- **Análise de Impacto (Blast Radius)**: Lista de componentes adjacentes afetados pela correção.
- **Teste de Reprodução Automatizado**: Snippet de código do teste (usando skill `django-drf-tests` e `Model Factory Mixins`) que DEVE falhar antes da correção e passar após a correção.
- **Correção Minimalista (Anti-Drift)**: Snippet do código corrigido com justificativa técnica (*why*), alterando estritamente os arquivos necessários sem refatorações oportunistas.
