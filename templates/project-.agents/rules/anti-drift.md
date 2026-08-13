---
trigger:
  glob: "**/*"
---

# Workspace Anti-Drift & Scope Control Rules

Estas regras controlam o escopo de qualquer tarefa executada no workspace.

## 1. Task Objective

Antes de modificar qualquer arquivo:

- Identifique explicitamente o objetivo solicitado pelo usuário.
- Determine quais arquivos, módulos e componentes são diretamente relevantes para atingir esse objetivo.
- Não expanda o objetivo por iniciativa própria.
- Se houver ambiguidade relevante sobre o objetivo ou escopo, pergunte antes de modificar código.
- Considere como fora de escopo qualquer melhoria que não seja necessária para concluir a tarefa solicitada.

## 2. Scope Boundary

- Modifique SOMENTE arquivos diretamente necessários para a tarefa.
- Não faça refatorações não solicitadas.
- Não altere arquitetura, padrões ou estrutura do projeto sem necessidade para a tarefa.
- Não faça melhorias de código oportunistas.
- Não altere dependências, configurações ou infraestrutura sem necessidade direta.
- Não reformate arquivos que não precisam ser modificados.
- Não renomeie arquivos, classes, funções ou variáveis fora do escopo.
- Não remova código aparentemente obsoleto sem confirmação de que isso faz parte da tarefa.
- Não corrija problemas descobertos incidentalmente, a menos que sejam necessários para concluir a tarefa.
- Preserve o comportamento existente fora do escopo solicitado.

## 3. Pre-Edit Inspection

Antes de editar:

1. Inspecione os arquivos diretamente relacionados à tarefa.
2. Identifique dependências entre os componentes envolvidos.
3. Consulte as instruções aplicáveis ao diretório/arquivo.
4. Determine a menor alteração necessária para atingir o objetivo.
5. Se a alteração exigir arquivos adicionais, justifique internamente por que cada arquivo é necessário.

Não edite código antes de concluir essa inspeção.

## 4. Minimal Change Principle

Sempre prefira:

- menor número de arquivos alterados;
- menor quantidade de linhas alteradas;
- menor mudança estrutural;
- reutilização da arquitetura existente;
- implementação consistente com os padrões já utilizados no projeto.

Não introduza uma nova abstração quando uma alteração local for suficiente.

Não introduza uma nova dependência quando a funcionalidade puder ser implementada com as dependências existentes.

## 5. No Opportunistic Refactoring

Durante a implementação, você pode encontrar:

- código duplicado;
- problemas de naming;
- funções grandes;
- possíveis melhorias de arquitetura;
- problemas de performance;
- débito técnico;
- inconsistências de estilo.

Não corrija esses problemas automaticamente.

Se não forem necessários para a tarefa atual:

- mantenha-os intactos;
- mencione-os ao usuário somente se forem relevantes;
- não os inclua no patch atual.

## 6. Change Boundary

Durante a execução:

- Monitore continuamente quais arquivos estão sendo modificados.
- Se um arquivo não estava inicialmente dentro do escopo, não o modifique sem determinar que ele é necessário.
- Se uma alteração começar a exigir mudanças em uma área significativamente diferente do objetivo original, pare e reavalie o escopo.
- Não continue expandindo a implementação apenas porque uma nova melhoria foi descoberta.

A descoberta de um problema não significa autorização para corrigi-lo.

## 7. Verification Is Mandatory

Depois de qualquer alteração de código:

1. Execute os testes relevantes.
2. Execute os linters/formatters relevantes.
3. Utilize RTK quando disponível:
   - `rtk pytest`
   - `rtk ruff`
   - `rtk jest`
4. Se houver um comando específico estabelecido pelo projeto para validação, utilize-o.
5. Não considere a tarefa concluída sem executar a verificação apropriada.

Se os testes ou linters falharem:

- determine se a falha foi causada pela alteração atual;
- corrija somente problemas relacionados à tarefa;
- execute novamente a verificação.

Não altere código não relacionado apenas para obter uma suíte verde.

## 8. Final Diff Audit

Antes de concluir a tarefa:

- Inspecione o diff completo.
- Verifique todos os arquivos modificados.
- Confirme que cada alteração possui relação direta com o objetivo solicitado.
- Remova alterações acidentais.
- Remova formatação ou reestruturação não necessária.
- Confirme que nenhum arquivo fora do escopo foi alterado.
- Confirme que nenhuma dependência ou configuração foi modificada sem necessidade.

O estado final deve representar SOMENTE as mudanças necessárias para a tarefa.

## 9. Scope Violation Recovery

Se você perceber que saiu do escopo:

1. Pare a implementação.
2. Identifique as alterações fora do escopo.
3. Reverta somente essas alterações.
4. Retorne ao objetivo original.
5. Continue somente dentro do escopo autorizado.

Não racionalize uma alteração fora do escopo apenas porque ela "melhora" o código.

## 10. Architectural Consistency

Ao implementar uma tarefa:

- siga os padrões já utilizados no projeto;
- reutilize abstrações existentes quando apropriado;
- respeite a arquitetura atual;
- não introduza padrões arquiteturais novos sem necessidade;
- não substitua uma implementação existente por outra apenas por preferência pessoal.

O objetivo é integrar a mudança ao sistema existente, não redesenhar o sistema.

## 11. Memory Persistence

Persist key architectural decisions and progress milestones to Obsidian Second Brain via `/second-brain`.

Somente registre informações que sejam relevantes para continuidade futura do projeto.

Não registre detalhes triviais da implementação.

## 12. Completion Criteria

Uma tarefa somente está concluída quando:

- o objetivo original foi atendido;
- somente arquivos necessários foram alterados;
- não existem alterações oportunistas;
- testes relevantes foram executados;
- linters relevantes foram executados;
- o diff final foi revisado;
- não existem mudanças acidentais;
- decisões arquiteturais relevantes foram persistidas quando necessário.