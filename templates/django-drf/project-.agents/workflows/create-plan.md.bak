---
name: create-simple-feature-workflow
description: >-
  Analisa uma funcionalidade simples, discute requisitos e opções técnicas com o usuário,
  e cria e executa um único plano de implementação após aprovação explícita.
---

# Workflow de Feature Simples
Utilize para funcionalidades pequenas e autocontidas que podem ser analisadas,
planejadas e implementadas em uma única etapa.
Não utilize este workflow para funcionalidades que envolvam múltiplos domínios,
mudanças arquiteturais relevantes, várias etapas independentes ou dependências
significativas entre componentes. Nesses casos, utilize o workflow de planejamento
de feature completo.

## Critério de Feature Simples

Considere uma funcionalidade simples quando:
- Possui escopo pequeno e bem delimitado.
- Pode ser implementada em uma única etapa.
- Não exige roadmap ou fases independentes.
- Não introduz uma mudança arquitetural significativa.
- Não depende de outra feature ainda não implementada.
- Pode envolver Models, API, Services e Testes, desde que todos façam parte
  da mesma alteração coesa.
- A implementação pode ser validada com um conjunto direto de testes e verificações.

Exemplos:
- Adicionar um campo simples a um model e expô-lo na API.
- Criar um endpoint CRUD pequeno.
- Adicionar uma validação de negócio localizada.
- Adicionar um filtro ou ordenação.
- Adicionar uma pequena integração dentro de um fluxo existente.
- Adicionar uma notificação ou comportamento pontual.

Se durante a análise a funcionalidade se mostrar maior do que o esperado,
pare e recomende migrar para o workflow completo.

# Gate 0 — Analisar Antes de Planejar
NUNCA crie `implementation_plan.md` ou modifique código antes de:
1. Analisar o requisito.
2. Inspecionar o repositório relevante.
3. Verificar decisões arquiteturais e padrões existentes.
4. Identificar os componentes afetados.
5. Discutir requisitos e opções técnicas com o usuário.
6. Receber aprovação explícita da abordagem.

## Durante a análise
Busque, quando aplicável:
- Models relacionados.
- Serializers.
- Views / ViewSets.
- Services.
- Queries / Managers.
- Schemas.
- URLs.
- Testes existentes.
- Configurações relacionadas.
- Skills específicas do projeto.
- Documentação ou decisões arquiteturais existentes.
Não faça alterações no código durante esta etapa.

# 1. Análise
Construa o contexto técnico antes de propor a implementação.
Determine:
- O que exatamente precisa ser alterado.
- Como o comportamento atual funciona.
- Qual padrão existente deve ser seguido.
- Quais arquivos/componentes serão afetados.
- Quais dependências existem.
- Quais riscos ou efeitos colaterais existem.
- Qual é o menor escopo necessário.

## Apresentação da Análise
Apresente:
- **Compreensão**: ...
- **Padrões Existentes**: ...
- **Áreas Afetadas**: ...
- **Restrições**: ...
- **Perguntas Abertas**: ...
- **Opções Técnicas**:
  1. ...
  2. ...
- **Recomendação**: ...
Em seguida, discuta a abordagem com o usuário.

# 2. Debate
Não gere `implementation_plan.md` durante esta fase.
Resolva:
- Requisitos funcionais.
- Regras de negócio.
- Comportamentos esperados.
- Casos de erro.
- Decisões técnicas.
- Estratégia de testes.
- Escopo da alteração.
Evite perguntas desnecessárias.
Encerre o debate assim que houver informação suficiente para implementar
a funcionalidade sem fazer suposições relevantes.
Quando a abordagem estiver definida, pergunte:
> Requisitos e abordagem confirmados. Posso gerar o plano de implementação?
Prossiga somente após aprovação explícita.

# 3. Plano de Implementação
Após a aprovação, crie um único:
`implementation_plan.md`
O plano deve conter:

## Contexto
Explique:
- Qual problema será resolvido.
- Como o comportamento atual funciona.
- Qual abordagem foi escolhida.

## Escopo
Liste:
- Arquivos que serão alterados.
- Arquivos que serão criados.
- Componentes envolvidos.
- Alterações esperadas em cada componente.
Não inclua arquivos ou refatorações que não sejam necessários para a feature.

## Solução
Descreva a implementação passo a passo.
A solução deve:
- Seguir os padrões existentes.
- Reutilizar componentes existentes quando apropriado.
- Evitar abstrações prematuras.
- Evitar mudanças arquiteturais desnecessárias.
- Manter o escopo mínimo.

## Testes
Defina:
- Testes unitários necessários.
- Testes de integração necessários.
- Casos de sucesso.
- Casos de erro.
- Casos de borda relevantes.
Não crie testes para comportamentos fora do escopo.

## Verificação
Defina:
- Comandos necessários.
- Testes que devem passar.
- Validações manuais, quando necessárias.
- Critérios objetivos de aceitação.

## Riscos
Liste somente riscos relevantes para a implementação.
Inclua:
- Possíveis efeitos colaterais.
- Compatibilidade com código existente.
- Dependências.
- Pontos que precisam de atenção durante a implementação.

# 4. Gate de Execução
Depois de criar o `implementation_plan.md`, NÃO implemente automaticamente.
Apresente um resumo do plano e aguarde aprovação explícita.
Pergunte:
> Plano pronto. Posso executar a implementação?
Somente após aprovação explícita execute o plano.

# 5. Execução
Execute exclusivamente o que estiver definido no `implementation_plan.md`.
Durante a implementação:
- Respeite o Scope Lock.
- Não faça refatorações não relacionadas.
- Não introduza funcionalidades futuras.
- Siga os padrões encontrados durante a análise.
- Caso seja necessário alterar o escopo, pare e consulte o usuário.

## Após implementar
Execute as verificações definidas no plano:
- Testes relevantes.
- Linters, quando aplicável.
- Type checking, quando aplicável.
- Verificações específicas do projeto.
Corrija problemas diretamente relacionados à implementação.
Não corrija problemas preexistentes e não relacionados à feature.

# 6. Conclusão
Após a implementação:
Apresente:
- **Implementado**: ...
- **Arquivos alterados**: ...
- **Testes executados**: ...
- **Resultado dos testes**: ...
- **Observações**: ...
Se tudo estiver correto, finalize a execução.
Não crie uma nova fase.

# Condições de Parada
Pare e consulte o usuário se:
- O requisito continuar ambíguo.
- A arquitetura existente entrar em conflito com a solução.
- Os padrões existentes forem insuficientes para determinar a implementação.
- A funcionalidade se mostrar maior do que uma feature simples.
- Surgir necessidade de alteração arquitetural significativa.
- Uma dependência obrigatória estiver ausente.
- For necessário alterar arquivos fora do escopo previsto.
- Os testes revelarem regressões fora do escopo.
- A implementação exigir uma decisão de negócio não definida.
Se a funcionalidade deixar de ser simples, recomende migrar para:
`create-feature-plan-workflow`

# Regras
- Analise antes de planejar.
- Debata antes de implementar.
- Exija aprovação explícita antes do plano.
- Exija aprovação explícita antes da implementação.
- Crie apenas um `implementation_plan.md`.
- Crie um plano detalhado e com código que planeja implementar
- Não crie `feature_roadmap.md`.
- Não divida artificialmente a implementação em fases.
- Prefira padrões existentes no repositório.
- Escolha sempre o menor escopo viável.
- Não antecipe requisitos futuros.
- Respeite Scope Lock.
- Não faça refatorações não relacionadas.
- Mantenha a implementação coesa e autocontida.