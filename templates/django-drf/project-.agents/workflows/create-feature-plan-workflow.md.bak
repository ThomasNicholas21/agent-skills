---
name: create-feature-plan-workflow
description: >-
  Analisa uma nova funcionalidade, discute requisitos e opções técnicas com o usuário,
  e cria e executa planos de implementação incrementais após aprovação explícita.
---

# Workflow de Planejamento de Feature
Utilize para planejamento e implementação de novas funcionalidades.

## Gate 0 — Analisar Antes de Planejar
NUNCA crie `implementation_plan.md` ou modifique código antes de:
1. Analisar o requisito e o repositório.
2. Verificar decisões do projeto e padrões existentes.
3. Discutir requisitos e opções técnicas com o usuário.
4. Receber aprovação explícita.

## 1. Analisar
Construa o contexto técnico antes de propor soluções:
- Compreenda o requisito sem fazer suposições.
- Consulte o Second Brain quando arquitetura ou regras de negócio forem relevantes.
- Busque models, APIs, services, padrões e testes existentes no repositório.
- Identifique componentes afetados, dependências, restrições e riscos.
- Determine o menor escopo viável.
**Não modifique código nesta fase.**

### Apresentação da Análise
Apresente:
- **Compreensão**: ...
- **Padrões Existentes**: ...
- **Áreas Afetadas**: ...
- **Restrições**: ...
- **Perguntas Abertas**: ...
- **Opções Técnicas**: 1. ... 2. ...
- **Recomendação**: ...

Em seguida, discuta a abordagem com o usuário.

## 2. Debate
Não gere plano durante esta fase.
- Esclareça requisitos funcionais e de negócio.
- Resolva ambiguidades e valide premissas.
- Compare abordagens técnicas viáveis.
- Defina escopo e estratégia de testes.
- Encerre as perguntas assim que a decisão estiver clara.

Quando a abordagem convergir, pergunte:
> Requisitos e abordagem confirmados. Posso gerar o roadmap e o primeiro plano de implementação?

Prossiga apenas após aprovação explícita.

## 3. Roadmap
Após a aprovação, crie `feature_roadmap.md` contendo:
- Visão geral da funcionalidade.
- Fases de implementação e status de cada fase.
- Decisões tomadas durante o debate.
- Dependências entre as fases.

Fases padrão:
1. **Models** — persistência e restrições de dados (`django-model`).
2. **API** — serializers, views, ViewSets, schemas e URLs (`drf-serializer`, `drf-view`, `drf-viewset`, `drf-schema`, `django-drf-url`).
3. **Regras de Negócio & Geração de fluxo de teste funcional** — regras de domínio, integrações e testes funcionais.
Adapte ou remova fases se a funcionalidade não exigir. Persista decisões importantes no Second Brain quando aplicável.

## 4. Planejamento Lazy (Fase a Fase)
Gere apenas o plano para a próxima fase pendente. Crie um `implementation_plan.md` por vez contendo:
- **Contexto**: Fase atual e pré-requisitos concluídos.
- **Escopo**: Arquivos/componentes que devem mudar.
- **Solução**: Abordagem escolhida e justificativa técnica.
- **Testes**: Testes necessários para validar a fase.
- **Verificação**: Comandos e critérios de aceitação.
- **Riscos**: Efeitos colaterais e dependências.

O plano DEVE seguir Scope Lock e evitar refatorações não relacionadas.

## 5. Execução de Fase
Para cada fase:
1. Gere o plano da fase.
2. Aguarde aprovação explícita.
3. Execute apenas essa fase.
4. Execute as verificações e testes relevantes.
5. Atualize o roadmap.
6. Pare e pergunte:
> Fase N concluída. Posso gerar o plano para a Fase N+1?

Não continue automaticamente para a próxima fase sem aprovação.

## Condições de Parada
Pare e consulte o usuário se:
- Requisitos permanecerem ambíguos.
- A arquitetura entrar em conflito com decisões existentes do projeto.
- Padrões existentes forem insuficientes para determinar a implementação.
- A solução exigir arquivos ou alterações arquiteturais inesperadas.
- Uma dependência obrigatória estiver ausente.
- Testes revelarem regressões fora do escopo.

## Regras
- Analise antes de planejar.
- Debata antes de implementar.
- Exija aprovação explícita em cada gate.
- Crie um plano detalhado e com código que planeja implementar
- Prefira padrões existentes no repositório e a menor solução viável.
- Não antecipe requisitos futuros.
- Mantenha apenas uma fase de implementação ativa por vez.