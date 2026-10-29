---
name: create-refactor-plan-workflow
description: >-
  Analisa o impacto de refatorações de código, valida escopo e riscos com o usuário,
  e gera um plano de implementação somente após aprovação explícita.
---

# Workflow de Refatoração
Utilize para refatorações estruturais ou não triviais.

## 1. Gate — Analisar Antes de Planejar
Não modifique código nem crie `implementation_plan.md` antes de:
1. Analisar a implementação atual.
2. Mapear o impacto e dependências.
3. Identificar riscos e restrições.
4. Discutir a abordagem com o usuário.
5. Receber aprovação explícita.

## 2. Analisar
Inspecione o repositório utilizando RTK:
- Alvo exato da refatoração.
- Chamadores diretos e indiretos (`rtk grep`, `rtk find`).
- Models, QuerySets, Managers, Serializers, Views, ViewSets, Services, URLs e Schemas relacionados.
- Testes existentes e contratos de API afetados.
- Consulte o Second Brain caso a refatoração envolva decisões arquiteturais prévias.
**Não modifique código durante a análise.**

### Apresentação da Análise
Apresente:
- **Alvo**: O que está sendo refatorado.
- **Design Atual**: Como funciona hoje.
- **Impacto**: Arquivos, chamadores e contratos afetados.
- **Testes**: Cobertura existente e resultados relevantes.
- **Riscos**: Riscos de compatibilidade, performance ou comportamento.
- **Opções**: 1. Refatoração mínima 2. Abordagem alternativa (se houver).
- **Recomendação**: Abordagem recomendada e justificativa.

Em seguida, discuta com o usuário.

## 3. Debate & Gate de Aprovação
Use o debate para esclarecer o objetivo, eliminar escopo desnecessário, definir garantias de compatibilidade e confirmar a cobertura de testes de regressão.

Quando alinhado, pergunte:
> Escopo e abordagem de refatoração confirmados. Posso gerar o plano de implementação?

Prossiga somente após aprovação explícita.

## 4. Plano de Implementação
Após aprovação, crie `implementation_plan.md` contendo:
- **Objetivo**: O que a refatoração muda e o porquê.
- **Estado Atual**: Estrutura e comportamento existentes.
- **Escopo**: Arquivos/componentes autorizados a mudar.
- **Etapas**: Passos ordenados de implementação.
- **Compatibilidade**: Contratos e comportamentos que devem permanecer inalterados.
- **Testes**: Testes de regressão necessários antes ou durante a refatoração (`django-drf-tests`).
- **Verificação**: Comandos exatos de verificação (incluindo contagem de queries se sensível a performance).
- **Riscos**: Riscos e estratégias de mitigação.

## 5. Scope Lock & Regras
- Altere apenas o escopo aprovado.
- Preserve o comportamento existente, salvo acordo explícito.
- Evite limpezas e refatorações oportunistas fora do escopo.
- Reutilize padrões existentes do projeto e prefira a menor alteração viável.
- Não introduza novas abstrações a menos que justificadas pela refatoração.
- Crie um plano detalhado e com código que planeja implementar