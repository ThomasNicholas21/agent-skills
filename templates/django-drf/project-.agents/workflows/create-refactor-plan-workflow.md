# Workflow: Plano de Refatoração e Análise de Impacto (create-refactor-plan-workflow)

Este workflow orienta a análise de impacto, avaliação de contratos e elaboração de um plano de refatoração seguro para código existente em projetos Django/DRF.

---

## 1. Análise de Escopo e Mapeamento de Impacto

1. **Identificação do Alvo**: Defina exatamente a função, classe, modelo ou camada a ser refatorada.
2. **Varredura de Locais de Chamada (Blast Radius)**: Utilize `rtk grep` e `rtk find` para localizar todos os locais do repositório afetados pela alteração:
   - Impacto em Models, QuerySets e Managers.
   - Impacto em Serializers e regras de validação.
   - Impacto em ViewSets, Views e decoradores OpenAPI (`schemas.py`).
   - Impacto em Services, regras de negócio e integrações.
   - Impacto em URLs e rotas atreladas.
3. **Avaliação da Suíte de Testes Existente**: Execute os testes existentes via `rtk pytest`. Se a cobertura do código a ser refatorado for insuficiente, **invoque a skill `django-drf-tests`** e crie os testes de regressão necessários ANTES de refatorar.

---

## 2. Debate de Impacto com o Usuário

1. Apresente ao usuário o mapa de impacto detalhando quais arquivos e contratos serão afetados.
2. Discuta os riscos de quebra de compatibilidade retroativa e opções de refatoração.
3. Obtenha a confirmação do usuário sobre o plano de refatoração.

---

## 3. Elaboração do Plano de Refatoração (`implementation_plan.md`)

Crie o arquivo de plano de implementação contendo:
- **Resumo do Impacto**: Lista de componentes afetados e garantias de preservação de contrato.
- **Passo a Passo de Refatoração**:
  - Modificações pontuais em Models / Managers (skill `django-model`).
  - Otimizações no Serializer ou ViewSet (skills `drf-serializer` e `drf-viewset`).
  - Atualização de Schemas ou URLs (skills `drf-schema` e `drf-django-url`).
- **Justificativa (*why*) e Código de Referência**: Snippets objetivos demonstrando o código antes e depois da refatoração.
- **Plano de Verificação de Regressão**: Comandos de testes automatizados e asserções de queries (`assertNumQueries`).
