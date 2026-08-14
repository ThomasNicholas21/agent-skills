# Workflow: Plano de Correção de Bugs e Diagnóstico (create-bugfix-plan-workflow)

Este workflow orienta a investigação de causa raiz, execução de código/testes, debate com o usuário e elaboração de um plano de correção de bugs com análise de impacto.

---

## 1. Investigação de Causa Raiz e Execução

1. **Análise de Traceback**: Leia a traceback completa de erros ou logs de exceção sem fazer suposições.
2. **Execução de Código e Testes**: Execute os testes afetados (`rtk pytest`) ou scripts de reprodução em `scratch/` para observar o comportamento do erro em runtime.
3. **Mapeamento de Causa Raiz**: Identifique o motivo exato pelo qual o bug ocorre (violação de contrato, `NullPointerException`, query N+1, falha de validação no Serializer, estado inconsistente no banco).

---

## 2. Debate e Testes de Reprodução com o Usuário

1. Discuta com o usuário as evidências empíricas e hipóteses do bug.
2. Alinhe os cenários de testes funcionais e testes automatizados de reprodução.
3. **Avaliação de Impacto e Efeitos Colaterais**: Avalie o que a correção pode impactar em outros módulos (efeito colateral/blast radius).

---

## 3. Elaboração do Plano de Correção (`implementation_plan.md`)

Crie o arquivo de plano de implementação contendo:
- **Diagnóstico da Causa Raiz**: Explicação clara do motivo pelo qual o bug ocorre.
- **Análise de Impacto (Blast Radius)**: Lista de componentes adjacentes afetados.
- **Teste de Reprodução Automatizado**: Snippet de código do teste (usando skill `django-drf-tests` e `Model Factory Mixins`) que DEVE falhar antes da correção e passar após a correção.
- **Correção Minimalista (Anti-Drift)**: Snippet do código corrigido com justificativa técnica (*why*), alterando estritamente os arquivos necessários sem refatorações oportunistas.
