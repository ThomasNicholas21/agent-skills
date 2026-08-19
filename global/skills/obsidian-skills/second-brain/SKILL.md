---
name: second-brain
description: >
  Portal obrigatório para operações no Segundo Cérebro (Obsidian).
  Use para buscar, criar, atualizar, vincular, decidir, pesquisar,
  registrar em log ou persistir conhecimento no vault.
---

# Portal do Segundo Cérebro
O vault é a memória persistente; a conversa é a memória temporária.
Mantenha o vault:
* rico;
* consistente;
* pesquisável;
* conectado;
* atualizado;
* rastreável;
* desduplicado;
* útil para futuros agentes.
Persista informações duradouras sempre que puderem aprimorar sessões futuras. Sem necessidade de emojis, utilize sempre algo que irá melhorar a consulta para agentes de IA.

## Protocolo Principal
Para operações de persistência relevantes:
```text
CARREGAR → BUSCAR → COMPREENDER → AGIR → PROPAGAR → INDEXAR → REGISTRAR → VALIDAR
```
## 1. CARREGAR (LOAD)
Antes de qualquer trabalho relevante:
* Leia `_GEMINI.md`.
* Leia `index.md`.
* Leia o `log.md` recente apenas quando o histórico for relevante.
* Carregue apenas notas de projeto/contexto relevantes.
Nunca presuma que o contexto da conversa corresponde ao estado atual do vault.

## 2. BUSCAR (SEARCH)
Antes de criar conhecimento:
* Use `obsidian-find`.
* Busque pelo conceito e por entidades relacionadas.
* Verifique projetos, pessoas, tarefas, decisões e pesquisas relacionadas.
Escolha:
```text
conceito existente   → ATUALIZAR
conhecimento conexo  → COMPLEMENTAR
contradição          → RECONCILIAR
novo conceito        → CRIAR
```
Prefira `ATUALIZAR > CRIAR`.
Nunca crie duplicatas sem antes realizar uma busca.

## 3. COMPREENDER (UNDERSTAND)
Antes de escrever, determine:
* entidade;
* tipo de nota;
* relacionamentos;
* fonte;
* nível de confiança;
* frescor/atualidade;
* contradições.
Nunca invente informações ausentes.
Use `TBD`, `medium` ou `speculation` quando apropriado.

## 4. AGIR (ACT)
Use a habilidade mais específica:
| Operação | Habilidade |
| --- | --- |
| Busca | `obsidian-find` |
| Salvar | `obsidian-save` |
| Sincronização de projeto | `save-project-brain` |
| Projeto | `obsidian-project` |
| Arquitetura | `obsidian-architect` |
| Decisão | `obsidian-decide` |
| Ideia | `obsidian-capture` |
| Log de desenvolvimento | `obsidian-log` |
| Diário | `obsidian-daily` |
| Tarefa | `obsidian-task` |
| Pessoa | `obsidian-person` |
| Pesquisa | `research` / `research-deep` |
| Ingestão | `obsidian-ingest` |
| Síntese | `obsidian-synthesize` |
| Reconciliação | `obsidian-reconcile` |
| Integridade/Saúde | `obsidian-health` |
| Reindexação | `obsidian-reindex` |
| Siga o **fluxo de trabalho completo** da habilidade selecionada. |  |
| O portal define o ciclo de vida da persistência. |  |
| As habilidades especializadas definem a completude específica de cada domínio. |  |

## 5. PROPAGAR (PROPAGATE)
Propague apenas quando a informação afetar materialmente as entidades relacionadas.
Relações típicas:
```text
Projeto          → projeto + tarefa + diário
Decisão          → projeto + diário + ADR/conhecimento
Tarefa           → quadro + tarefa + projeto + diário
Desenvolvimento  → log de dev + projeto + diário
Pessoa           → pessoa + diário + projetos
Pesquisa         → pesquisa + conceitos/projetos/decisões afetados

```
Não propague sem necessidade.

## 6. INDEXAR (INDEX)
O `index.md` é o mapa de navegação do vault.
Use:
```text
índice → área → notas candidatas → obsidian-find → contexto

```
Use `obsidian-find` para a recuperação real.
Atualize o índice após criar, mover, renomear ou alterar estruturalmente notas, quando exigido.

## 7. REGISTRAR (LOG)
Toda operação que modifique o vault DEVE ser registrada.
Use `obsidian-log` para registrar:
* o que mudou;
* notas criadas/atualizadas;
* decisões;
* problemas;
* pendências relevantes.
O registro deve permitir que futuros agentes recuperem a atividade recente sem a conversa original.

## 8. VALIDAR (VALIDATE)
Após persistir, verifique:
* frontmatter;
* wikilinks;
* duplicação;
* consistência;
* propagação;
* índice;
* log;
* requisitos da habilidade especializada.
Gravar um arquivo não significa conclusão.
Uma operação especializada só está concluída quando o escopo exigido tiver sido efetivamente executado.

## PADRÃO AI-FIRST
Toda nota criada ou substancialmente atualizada deve ser:
* autossuficiente;
* legível por máquina;
* estruturada com frontmatter;
* conectada via `[[wikilinks]]`;
* preservadora da fonte;
* consciente da atualidade temporal;
* consciente do nível de confiança.
Toda nota contém:

## Para o futuro Claude
[Resumo conciso e autossuficiente.]

## Para o futuro Gemini
[Resumo equivalente com o mesmo contexto duradouro.]
Ambos os agentes devem receber o mesmo contexto semântico.
Para fatos externos:
* preserve a URL de origem;
* inclua a data/recência relevante;
* nunca apresente informações desatualizadas como atuais.
Use `TBD` em vez de inventar dados.

## PERSISTÊNCIA
Salve automaticamente dados duradouros de:
* decisões;
* contexto de projetos;
* trabalho técnico;
* mudanças de arquitetura;
* bugs/soluções investigados;
* tarefas assumidas;
* pessoas relevantes;
* pesquisas;
* ideias/aprendizados;
* integrações;
* convenções;
* descobertas importantes.
Pergunte antes de salvar:
* dados financeiros;
* conteúdo explicitamente confidencial;
* diários/notas pessoais;
* qualquer item explicitamente marcado como "não persistir".

## RECUPERAÇÃO DE SESSÃO
Para sessões novas ou retomadas que sejam relevantes:
```text
_GEMINI.md → index.md → log recente → contexto relevante → atividade recente

```
Quando houver divergência entre a conversa e o vault, dê preferência ao estado verificado do vault.

## HABILIDADES ESPECIALIZADAS
O portal gerencia o ciclo de vida da persistência.
As habilidades especializadas garantem a completude do domínio.
Exemplos:
* `save-project-brain` → template de projeto completo.
* `obsidian-architect` → contexto de arquitetura completo.
* `obsidian-project` → metadados de projeto completos.
* `obsidian-person` → contexto de pessoa completo.
* `obsidian-decide` → contexto de decisão completo.
Nunca reduza uma habilidade especializada a apenas "salvar o que mudou".

## EFICIÊNCIA DE CONTEXTO
Quando o acesso ao terminal for necessário, prefira equivalentes RTK.
Use RTK para:
* leitura de arquivos;
* buscas;
* navegação;
* Git;
* logs;
* testes;
* builds;
* Docker;
* bancos de dados;
* saídas de CLI.
Use comandos nativos apenas quando não houver equivalente RTK ou quando a saída do RTK for insuficiente para garantir a exatidão.
Escale a granularidade da saída em vez de adivinhar:
```text
RTK → detalhado (verbose) → proxy/raw → nativo

```
Carregue apenas o contexto necessário para a operação atual.
Nunca carregue o vault inteiro quando uma busca direcionada for suficiente.

## CONCLUSÃO
```text
[ ] Conhecimento existente pesquisado
[ ] Duplicação evitada
[ ] Nota correta criada/atualizada
[ ] Fluxo de trabalho especializado concluído
[ ] Propagação relevante executada
[ ] Frontmatter/wikilinks preservados
[ ] Preâmbulos para Claude + Gemini presentes
[ ] Índice verificado
[ ] Operação registrada no log
[ ] Contradições/pendências verificadas
[ ] Recuperação por futuros agentes viabilizada
```
Se alguma etapa obrigatória tiver sido ignorada, corrija-a antes de finalizar.