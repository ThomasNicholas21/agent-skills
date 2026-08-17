---
name: second-brain
description: >
  Roteador inteligente e portal de entrada para o Obsidian Second Brain. Use sempre que o usuario solicitar
  pesquisa no cofre, contexto de sessao, memoria persistente, historico de decisoes, mapeamento de projetos,
  raciocinio socratico, ingestao de documentos locais ou manutencao do cofre. Classifica o prompt do usuario
  e o direciona para a skill oficial ideal que opera de forma 100% local sem dependencia de APIs externas pagas.
---

# Second Brain Gateway & Prompt Router

Esta habilidade atua como o **roteador inteligente central de intencoes** entre os pedidos do usuario no chat e o ecossistema oficial do **Obsidian Second Brain**.

O objetivo e interpretar o prompt em linguagem natural e direcionar a execucao para o comando local de menor custo de tokens e maior precisao, mantendo a memoria longitudinal limpa, estruturada e sem duplicidades.

Todas as operacoes de persistencia, leitura e atualizacao no cofre DEVEM ser conduzidas atraves das **skills oficiais do Obsidian**, operando de forma 100% local e sem dependencia de servicos de terceiros ou APIs pagas.

---

## Setup e Resolucao Mandatoria do Vault Root e Diretorios no Linux

Sempre que a skill `/second-brain` for invocada, o agente DEVE ler e resolver **imediatamente** as variaveis de ambiente parametrizadas, garantindo acesso rapido e sem necessidade de buscas exploratorias adicionais:

| Variavel de Ambiente | Caminho / Valor Resolvido no Linux | Descricao e Finalidade |
|---|---|---|
| `$OBSIDIAN_VAULT_PATH` | `$OBSIDIAN_VAULT_PATH` ou `/mnt/c/Users/thoma/Meus Documentos/obsidian-second-brain-vault` ou `$OBSIDIAN_VAULT_DIR` | Raiz do cofre central do Obsidian Second Brain (localizado fora do repositorio de codigo). |
| `$OBSIDIAN_VAULT_DIR` / `$SECOND_BRAIN_DIR` | `$HOME/obsidian/obsidian-second-brain` | Diretorio do cofre de conhecimento do Obsidian (desacoplado do codigo-fonte). |
| `$AGENT_SKILLS_DIR` | `/home/thomas/projects/agent-skills` | Raiz do repositorio hub de codigo, regras, skills e workflows. |
| `$DOC_DIR` | `$AGENT_SKILLS_DIR/docs` (`/home/thomas/projects/agent-skills/docs`) | Base de conhecimento tecnico e manuais no repositorio. |
| `$DOC_DIR/tools` | `$AGENT_SKILLS_DIR/docs/tools` | Manuais de ferramentas no repositorio (`rtk-guide.md`, `obsidian-second-brain.md`). |
| `$DOC_DIR/design-patterns` | `$AGENT_SKILLS_DIR/docs/design-patterns` | Catalogo de Design Patterns no repositorio (`INDEX.md`, GoF, Guru, Service Patterns). |
| `$GEMINI_DIR` | `/home/thomas/.gemini` | Diretorio de configuracao global do agente Google Antigravity. |
| `$CLAUDE_DIR` | `/home/thomas/.claude` | Diretorio de configuracao global do agente Claude Code. |

**Regra de Ouro (Vault Root)**: O cofre do Obsidian FICA EM UM LOCAL DIFERENTE do repositorio de codigo. Todas as leituras e escritas no Second Brain DEVEM ocorrer estritamente na raiz do cofre resolvida (`$OBSIDIAN_VAULT_PATH` / `$OBSIDIAN_VAULT_DIR` / `$SECOND_BRAIN_DIR`). Leia `_CLAUDE.md` na raiz do Vault antes de criar notas para carregar convencoes e schemas do usuario. **NUNCA** misture arquivos do cofre dentro do repositorio de codigo nem grave notas em locais efemeros.

---

## Guia de Acesso, Escrita e Edicao no Linux

Para interagir com o cofre do Obsidian no Linux (seja nativo ou WSL), siga rigorosamente as seguintes diretrizes tecnicas:

### 1. Tratamento de Caminhos e Espacos no Linux

- No Linux/WSL, caminhos para o cofre podem conter espacos (exemplo: `/mnt/c/Users/thoma/Meus Documentos/obsidian-second-brain-vault`).
- **Sempre utilize aspas duplas** ao referenciar variaveis de ambiente ou caminhos no terminal:
  ```bash
  VAULT="${OBSIDIAN_VAULT_PATH:-$OBSIDIAN_VAULT_DIR}"
  cat "$VAULT/_CLAUDE.md"
  ```
- Se a variavel nao estiver carregada no shell ativo, execute o script de ambiente do repositorio:
  ```bash
  source /home/thomas/projects/agent-skills/scripts/agent-env.sh
  ```

### 2. Melhores Praticas para Leitura de Arquivos

- Para inspecionar notas do cofre ou arquivos de regras:
  - Utilize a ferramenta nativa de visualizacao do agente (`view_file` com caminho absoluto entre aspas).
  - No terminal, utilize `cat "$VAULT/caminho/nota.md"`, `head`, `tail` ou `grep`.

### 3. Melhores Praticas para Criacao e Escrita Total

- **Ferramentas do Agente**: Utilize a ferramenta nativa `write_to_file` especificando o caminho absoluto no cofre.
- **Via Terminal Shell**: Utilize o padrao Heredoc com aspas simples para proteger caracteres especiais e variaveis:
  ```bash
  cat <<'EOF' > "$VAULT/wiki/projects/exemplo/index.md"
  ---
  type: project-hub
  date: 2026-08-17
  tags:
    - project
    - ai-first
  ai-first: true
  ---

  ## For future Claude
  Visao geral do projeto exemplo no Second Brain.

  # Projeto Exemplo
  EOF
  ```

### 4. Melhores Praticas para Edicao e Modificacao Cirurgica

- **Ferramentas do Agente**: Utilize `replace_file_content` ou `multi_replace_file_content` para edicoes estruturadas de blocos especificos.
- **Acrescimo de Conteudo (Append)**:
  ```bash
  cat <<'EOF' >> "$VAULT/wiki/projects/exemplo/index.md"

  ### Nova Atualizacao
  Registro de atualizacao adicionado em 2026-08-17.
  EOF
  ```
- **Substituicoes Simples**: Utilize `sed -i` com tratamento cuidadoso de delimitadores.

### 5. Operacoes Proibidas

- **PROIBIDO USO DE PYTHON PARA PERSISTENCIA**: O agente NAO DEVE utilizar Python (`python`, `python3`, scripts `.py`, ou bibliotecas como `pathlib`/`open`) para criar, modificar, sobrescrever ou remover arquivos do Obsidian Vault.
- Scripts Python sao restritos exclusivamente para analise temporaria de dados em `scratch/`, nunca como mecanismo de persistencia no cofre.

---

## 1. Tabela de Roteamento por Intencao do Prompt (Skills Locais)

Analise o pedido do usuario e direcione a execucao para a skill correspondente do Obsidian:

### A) Contexto de Sessao e Identidade
| Intencao do Usuario no Prompt | Comando a Executar |
| :--- | :--- |
| "Quem sou eu?", "Carregar meu contexto", "Iniciar sessao", "Atualizar estado" | `/obsidian-world` |
| "Criar nota diaria geral do dia", "O que tenho para hoje?", "Atualizar daily" | `/obsidian-daily` |
| "Criar daily do projeto X", "Daily do projeto", "Registrar daily em DAILIES_DIR" | `/project-daily [nome]` |
| "Resumo da semana", "O que fiz este mes?", "Recapitulativo" | `/obsidian-recap [today\|week\|month]` |

### B) Busca e Recuperacao de Memoria
| Intencao do Usuario no Prompt | Comando a Executar |
| :--- | :--- |
| "Onde discutimos X?", "Ja resolvemos esse problema antes?", "Buscar sobre Y" | `/obsidian-find <termo>` |
| "Resumir nota X mantendo as fontes", "Condensar este documento" | `/obsidian-distill <nota>` |

### C) Salvamento e Captura de Conversa
| Intencao do Usuario no Prompt | Comando a Executar |
| :--- | :--- |
| "Salve essa conversa", "Guarde nossas decisoes e tarefas da sessao" | `/obsidian-save` |
| "Tenho uma ideia rapida", "Anote essa ideia" | `/obsidian-capture <texto>` |
| "Registrar decisao de arquitetura X", "Gravar ADR" | `/obsidian-decide [--formal]` |
| "Registrar sessao de dev de hoje", "Log de trabalho no projeto X" | `/obsidian-log` |

### D) Ingestao de Documentos e Midias Locais
| Intencao do Usuario no Prompt | Comando a Executar |
| :--- | :--- |
| "Leia este artigo/PDF/documento local", "Ingerir este arquivo de texto" | `/obsidian-ingest <arquivo>` |
| "Resuma este video do YouTube a partir de transcricao publica" | `/youtube <url>` |

### E) Pesquisa Local e Sintese no Cofre (Vault-Grounded)
| Intencao do Usuario no Prompt | Comando a Executar |
| :--- | :--- |
| "Responda sobre X usando APENAS as notas do meu cofre sem web" | `/notebooklm <topico>` |
| "Criar nota de sintese tematica a partir das notas existentes no cofre" | `/obsidian-synthesize` |

### F) Ferramentas de Raciocinio Socratico, Ensino e Consultoria de Solucoes
| Intencao do Usuario no Prompt | Comando a Executar |
| :--- | :--- |
| "Atue como meu professor", "Me ensine didaticamente sobre X", "Debater conceito socratico Y" | `ai-tutor [topico]` |
| "Apresentar solucoes para o problema X", "Analisar vantagens e desvantagens de arquitetura Y" | `solution-architect [problema]` |
| "Quero debater uma ideia", "Me faca perguntas para estruturar X" | `/obsidian-brainstorm [topico]` |
| "Critique minha ideia", "Procure no meu historico por que isso pode dar errado" | `/obsidian-challenge` |
| "Convocar painel de especialistas para avaliar esta decisao" | `/obsidian-panel` |
| "Quais padroes nao nomeados estao surgindo nas minhas notas?" | `/obsidian-emerge` |
| "Conecte o conceito A com o conceito B" | `/obsidian-connect [A] [B]` |
| "Transformar esta ideia rascunhada em um projeto completo" | `/obsidian-graduate` |

### G) Mapeamento de Codigo e Repositorio
| Intencao do Usuario no Prompt | Comando a Executar |
| :--- | :--- |
| "Mapear codigo-fonte", "Documentar arquitetura deste repositorio" | `/obsidian-architect` |
| "Criar/gerenciar nota mestre do projeto X" | `/obsidian-project [nome]` |
| "Sincronizar codigo, git, URLs e diff do repositorio no Second Brain" | `/save-project-brain` |

### H) Manutencao, Tarefas e Saude do Cofre
| Intencao do Usuario no Prompt | Comando a Executar |
| :--- | :--- |
| "Limpar vault", "Verificar links quebrados", "Checar saude do cofre" | `/obsidian-health` |
| "Resolver contradicoes entre notas", "Reconciliar verdades" | `/obsidian-reconcile` |
| "Adicionar tarefa X ao Kanban", "Nova task para o projeto Y" | `/obsidian-task [descricao]` |
| "Cadastrar obrigacao recorrente (imposto, assinatura)" | `/obsidian-recurring` |
| "Visualizar mapa mental/canvas do cofre" | `/obsidian-visualize` |

---

## 2. Regra de Resolucao de Colisao (Longest Matching Trigger)

Se o prompt do usuario corresponder a mais de um comando, **o gatilho mais especifico deve prevalecer**:

- **Ideia rapida** vs **Varredura da sessao**: Use `/obsidian-capture` (para uma ideia rapida isolada) em vez de `/obsidian-save` (que varre toda a conversa por pessoas, tarefas e decisoes).
- **Busca por palavra-chave** vs **Sintese fundamentada**: Use `/obsidian-find` para localizar notas especificas; use `/notebooklm` para elaborar uma sintese tematica baseada nas notas do cofre.
- **Tarefa pontual** vs **Tarefa recorrente**: Use `/obsidian-recurring` se houver cadencia mensal/semanal; use `/obsidian-task` se for pontual.

---

## 3. Diretrizes Principais de Memoria (Search-Before-Create)

1. **Buscar Antes de Criar**: Antes de gerar uma nova nota de projeto, pessoa ou conceito, execute `/obsidian-find <termo>` para evitar duplicatas.
2. **Conformidade AI-First e OKM**:
   - Toda escrita deve possuir o preambulo `## For future Claude`.
   - Rastreamento bi-temporal (`timeline: from/until/learned/source`) para fatos que mudam.
   - Marcacao de recencia `(as of YYYY-MM)` em afirmacoes externas.
   - Links internos obrigatorios (`[[wikilinks]]`).
3. **Filtro de Relevancia**: Nao salve logs efemeros de terminal ou correcoes triviais de sintaxe. Salve decisoes arquiteturais, bugs complexos resolvidos e marcos de projeto.