---
name: create-bugfix-plan-workflow
description: >-
  Diagnostica bugs usando evidências, discute a causa raiz e a solução com o usuário,
  e gera o plano de implementação apenas após aprovação explícita.
---

# Workflow de Correção de Bugs (Bugfix)
Utilize este workflow para diagnóstico de bugs e planejamento de correções.

## Gate 0 — Analisar Antes de Planejar
NUNCA crie `implementation_plan.md` ou modifique código antes de:
1. Investigar o problema.
2. Confirmar a causa raiz.
3. Discutir a solução com o usuário.
4. Receber aprovação explícita.

## 1. Analisar
Investigue antes de propor uma solução:
- Leia tracebacks, logs e o código relevante.
- Reproduza o problema sempre que possível.
- Inspecione e execute testes existentes relacionados.
- Busque padrões e implementações semelhantes no repositório.
- Consulte o Second Brain quando a decisão depender de arquitetura ou regras de negócio.
- Determine: causa raiz, evidências, condições de reprodução, raio de impacto e arquivos afetados.
**Não modifique código durante esta fase.**

### Apresentação da Análise
Apresente os achados de forma concisa:
- **Causa Raiz**: ...
- **Evidências**: ...
- **Reprodução**: ...
- **Raio de Impacto**: ...
- **Hipóteses Alternativas**: ...
- **Opções de Correção**: 1. ... 2. ...
- **Recomendação**: ...
Em seguida, discuta a abordagem com o usuário.

## 2. Debate
Não gere plano durante esta fase.
- Questione premissas e resolva ambiguidades.
- Compare alternativas e trade-offs.
- Confirme o impacto e a estratégia de testes.
- Encerre as perguntas assim que a decisão estiver clara.

Quando a abordagem convergir, pergunte:
> Causa raiz e abordagem confirmadas. Posso gerar o plano de implementação?

Prossiga apenas após aprovação explícita.

## 3. Planejamento
Somente após aprovação, crie `implementation_plan.md` contendo:
- **Causa Raiz**: Causa raiz e evidências.
- **Escopo**: Arquivos que devem mudar e o motivo.
- **Solução**: Abordagem escolhida e justificativa técnica.
- **Testes**: Testes de regressão necessários e reprodução do bug.
- **Riscos**: Efeitos colaterais e raio de impacto.
- **Verificação**: Comandos e critérios para validar a correção.

O plano DEVE seguir Scope Lock e modificar apenas o estritamente necessário.

## 4. Condições de Parada
Pare e consulte o usuário se:
- A causa raiz não puder ser confirmada.
- A solução entrar em conflito com a arquitetura estabelecida.
- A correção exigir arquivos fora do escopo previsto.
- Existirem múltiplas soluções viáveis sem dados suficientes para escolha.
- Testes revelarem regressões fora do escopo.
- Uma dependência obrigatória estiver ausente.

## Regras
- Analise antes de planejar.
- Nunca implemente antes da abordagem ser aprovada.
- Nunca crie `implementation_plan.md` sem aprovação explícita.
- Prefira evidências a suposições.
- Prefira a menor correção viável.
- Não refatore código não relacionado.
- Reutilize padrões existentes no repositório.
- Crie um plano detalhado e com código que planeja implementar