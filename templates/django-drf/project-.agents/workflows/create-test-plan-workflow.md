---
name: create-test-plan-workflow
description: >-
  Analisa cobertura e riscos de teste, identifica lacunas de regressão, alinha prioridades com o usuário,
  e gera um plano de implementação apenas após aprovação explícita.
---

# Workflow de Planejamento de Testes
Utilize para analisar testes existentes e planejar cobertura de testes automatizados.

## 1. Gate — Analisar Antes de Planejar
Não modifique testes nem crie `implementation_plan.md` antes de:
1. Analisar a suíte de testes existente.
2. Mapear o comportamento relevante da aplicação.
3. Identificar lacunas de cobertura e riscos de regressão.
4. Discutir prioridades com o usuário.
5. Receber aprovação explícita.

## 2. Analisar
Inspecione o repositório utilizando RTK:
- Executor de testes e configurações (`pytest` vs `unittest` do Django).
- Estrutura de diretórios de testes, fixtures, factories e mixins existentes.
- Models, QuerySets, Serializers, Views, ViewSets, Services e integrações.
- Execute testes existentes relevantes para identificar o estado atual.
**Não modifique testes durante a análise.**

### Análise de Cobertura e Riscos
Identifique para cada comportamento:
- Cobertura existente vs lacunas.
- Testes frágeis ou redundantes.
- Cenários críticos de negócio sem proteção de regressão.
- Casos de borda, transações, concorrência e queries N+1.
Priorize **comportamento e risco**, não quantidade de testes.

### Apresentação da Análise
Apresente:
- **Infraestrutura de Teste**: Runner e convenções detectadas.
- **Cobertura Atual**: O que já está testado.
- **Lacunas**: Cenários ausentes ou insuficientes.
- **Riscos**: Comportamentos mais propensos a regressão.
- **Prioridades**: 1. Crítico 2. Importante 3. Opcional.
- **Recomendação**: Estratégia proposta e justificativa.

Em seguida, discuta com o usuário.

## 3. Debate & Gate de Aprovação
Use o debate para confirmar os cenários mais críticos, definir a profundidade dos testes e evitar testes de detalhes óbvios de implementação.

Quando alinhado, pergunte:
> Escopo de testes e prioridades confirmados. Posso gerar o plano de implementação?

Prossiga somente após aprovação explícita.

## 4. Plano de Implementação
Após aprovação, crie `implementation_plan.md` contendo:
- **Objetivo**: Comportamentos que a suíte deve proteger.
- **Cobertura Atual & Lacunas**: Cenários existentes e faltantes.
- **Estratégia**: Nível adequado para cada cenário (unit, model, service, API, integração).
- **Casos de Teste**: Cenário, setup, ação, resultado esperado e prioridade (caminho feliz, falhas de validação, autenticação/permissão, 404, conflitos, edge cases, contagem de queries).
- **Massa de Dados**: Reutilização de factories/mixins existentes (`django-drf-tests`).
- **Verificação**: Comandos exatos de execução e critérios de sucesso.

## 5. Regras de Teste & Scope Lock
- `SimpleTestCase` para testes sem acesso ao banco de dados.
- `TestCase` para testes com banco de dados.
- `APITestCase` para testes de API/endpoints DRF.
- `pytest` / `pytest-django` apenas quando já configurado no repositório.
- Use `force_authenticate` para autenticação em testes de API.
- Isole serviços externos com mocks.
- Priorize comportamento sobre detalhes internos de implementação e evite testes redundantes.
- Crie um plano detalhado e com código que planeja implementar