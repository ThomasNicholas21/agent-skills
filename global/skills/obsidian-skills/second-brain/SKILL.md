---
name: second-brain
description: >
  Roteador inteligente e portal de entrada para o Obsidian Second Brain. Use sempre que o usuário solicitar
  pesquisa, contexto de sessão, memória persistente, histórico de decisões, mapeamento de projetos, raciocínio socrático,
  ingestão de mídias/documentos ou manutenção do cofre. Classifica o prompt do usuário e o direciona para a skill
  oficial ideal entre todos os 50 comandos disponíveis.
---

# Second Brain Gateway & Prompt Router

Esta habilidade atua como o **roteador inteligente central de intenções** entre os pedidos do usuário no chat e o ecossistema oficial do **Obsidian Second Brain**.

O objetivo é interpretar o prompt em linguagem natural e direcionar a execução para o comando exato de menor custo de tokens e maior precisão, mantendo a memória longitudinal limpa e sem duplicidades.

---

## Setup & Resolução Mandatória do Vault Root e Diretórios do Ecossistema

Sempre que a skill `/second-brain` for invocada, o agente DEVE ler e resolver **imediatamente** as variáveis de ambiente parametrizadas (definidas em `.env.example`), garantindo acesso rápido e sem necessidade de buscas exploratórias adicionais:

| Variável de Ambiente | Caminho / Valor Resolvido | Descrição e Finalidade |
|---|---|---|
| `$OBSIDIAN_VAULT_PATH` | `$OBSIDIAN_VAULT_PATH` ou `/mnt/c/Users/thoma/Meus Documentos/obsidian-second-brain-vault` ou `$OBSIDIAN_VAULT_DIR` | Raiz do cofre central do Obsidian Second Brain (localizado fora do repositório de código). |
| `$OBSIDIAN_VAULT_DIR` / `$SECOND_BRAIN_DIR` | `$HOME/obsidian/obsidian-second-brain` | Diretório do cofre de conhecimento do Obsidian (desacoplado do código-fonte). |
| `$AGENT_SKILLS_DIR` | `/home/thomas/projects/agent-skills` | Raiz do repositório hub de código, regras, skills e workflows. |
| `$DOC_DIR` | `$AGENT_SKILLS_DIR/docs` (`/home/thomas/projects/agent-skills/docs`) | Base de conhecimento técnico e manuais no repositório. |
| `$DOC_DIR/tools` | `$AGENT_SKILLS_DIR/docs/tools` | Manuais de ferramentas no repositório (`rtk-guide.md`, `obsidian-second-brain.md`). |
| `$DOC_DIR/design-patterns` | `$AGENT_SKILLS_DIR/docs/design-patterns` | Catálogo de Design Patterns no repositório (`INDEX.md`, GoF, Guru, Service Patterns). |
| `$GEMINI_DIR` | `/home/thomas/.gemini` | Diretório de configuração global do agente Google Antigravity. |
| `$CLAUDE_DIR` | `/home/thomas/.claude` | Diretório de configuração global do agente Claude Code. |

**Regra de Ouro (Vault Root)**: O cofre do Obsidian FICA EM UM LOCAL DIFERENTE do repositório de código. Todas as leituras e escritas no Second Brain DEVEM ocorrer estritamente na raiz do cofre resolvida (`$OBSIDIAN_VAULT_PATH` / `$OBSIDIAN_VAULT_DIR` / `$SECOND_BRAIN_DIR`). Leia `_CLAUDE.md` na raiz do Vault antes de criar notas para carregar convenções e schemas do usuário. **NUNCA** misture arquivos do cofre dentro do repositório de código nem grave notas em locais efêmeros.

### Operações permitidas

- Criar ou sobrescrever arquivos: `cat > arquivo <<'EOF' ... EOF`
- Acrescentar conteúdo: `cat >> arquivo <<'EOF' ... EOF`
- Substituições simples: `sed`
- Edições estruturadas ou complexas: ferramenta de edição do agente, quando disponível.

### Operações proibidas

O agente NÃO DEVE utilizar Python (`python`, `python3`, scripts `.py`,
ou bibliotecas como `pathlib`/`open`) para criar, modificar, sobrescrever
ou remover arquivos do Obsidian Vault.

Python pode ser utilizado para análise ou processamento de dados quando
necessário, mas nunca como mecanismo de persistência no Vault.

---

## 1. Tabela de Roteamento por Intenção do Prompt

Analise o pedido do usuário e mapeie diretamente para o comando correspondente:

### A) Contexto de Sessão e Identidade
| Intenção do Usuário no Prompt | Comando a Executar |
| :--- | :--- |
| "Quem sou eu?", "Carregar meu contexto", "Iniciar sessão", "Atualizar estado" | `/obsidian-world` |
| "Criar nota diária", "O que tenho para hoje?", "Atualizar daily" | `/obsidian-daily` |
| "Resumo da semana", "O que fiz este mês?", "Recapitulativo" | `/obsidian-recap [today\|week\|month]` |

### B) Busca e Recuperação de Memória
| Intenção do Usuário no Prompt | Comando a Executar |
| :--- | :--- |
| "Onde discutimos X?", "Já resolvemos esse problema antes?", "Buscar sobre Y" | `/obsidian-find <termo>` |
| "Resumir nota X mantendo as fontes", "Condensar este documento" | `/obsidian-distill <nota>` |

### C) Salvamento e Captura de Conversa
| Intenção do Usuário no Prompt | Comando a Executar |
| :--- | :--- |
| "Salve essa conversa", "Guarde nossas decisões e tarefas da sessão" | `/obsidian-save` |
| "Tenho uma ideia rápida", "Anote essa ideia" | `/obsidian-capture <texto>` |
| "Registrar decisão de arquitetura X", "Gravar ADR" | `/obsidian-decide [--formal]` |
| "Registrar sessão de dev de hoje", "Log de trabalho no projeto X" | `/obsidian-log` |

### D) Ingestão de Mídias e Documentos Externa
| Intenção do Usuário no Prompt | Comando a Executar |
| :--- | :--- |
| "Leia este artigo/PDF/site", "Ingerir este documento", "Analisar screenshot" | `/obsidian-ingest <url\|arquivo>` |
| "Resuma este vídeo do YouTube", "Extrair transcrição do YouTube" | `/youtube <url>` |
| "Assista a este vídeo com código/diagramas na tela" | `/youtube <url> --visual` |
| "Resumir este episódio de podcast", "Transcrição de podcast" | `/podcast <url>` |
| "Ler este post do X (Twitter)", "Analisar thread do X" | `/x-read <url>` |
| "Processar capturas pendentes enviadas pelo celular/Telegram" | `/obsidian-catchup` |

### E) Pesquisa Web e Síntese Fundamentada
| Intenção do Usuário no Prompt | Comando a Executar |
| :--- | :--- |
| "Pesquise sobre o assunto X na web", "Dossiê rápido sobre Y" | `/research <tópico>` |
| "Pesquise o que há de novo sobre X preenchendo apenas o que o vault não sabe" | `/research-deep <tópico>` |
| "Responda sobre X usando APENAS as notas do meu cofre sem web" | `/notebooklm <tópico>` |
| "O que está em alta no X sobre o tópico Y?", "Ideias de conteúdo sobre Y" | `/x-pulse <tópico>` |

### F) Ferramentas de Raciocínio Socrático, Ensino e Consultoria de Soluções
| Intenção do Usuário no Prompt | Comando a Executar |
| :--- | :--- |
| "Atue como meu professor", "Me ensine didaticamente sobre X", "Debater conceito socrático Y" | `ai-tutor [tópico]` |
| "Apresentar soluções para o problema X", "Analisar vantagens e desvantagens de arquitetura Y" | `solution-architect [problema]` |
| "Quero debater uma ideia", "Me faça perguntas para estruturar X" | `/obsidian-brainstorm [tópico]` |
| "Critique minha ideia", "Procure no meu histórico por que isso pode dar errado" | `/obsidian-challenge` |
| "Convocar painel de especialistas para avaliar esta decisão" | `/obsidian-panel` |
| "Quais padrões não nomeados estão surgindo nas minhas notas?" | `/obsidian-emerge` |
| "Conecte o conceito A com o conceito B" | `/obsidian-connect [A] [B]` |
| "Transformar esta ideia rascunhada em um projeto completo" | `/obsidian-graduate` |

### G) Mapeamento de Código e Repositório
| Intenção do Usuário no Prompt | Comando a Executar |
| :--- | :--- |
| "Mapear código-fonte", "Documentar arquitetura deste repositório" | `/obsidian-architect` |
| "Criar/gerenciar nota mestre do projeto X" | `/obsidian-project [nome]` |
| "Sincronizar código, git e diff do repositório no Second Brain" | `/save-project-brain` |
| "Sincronizar e expurgar skills órfãs nos agentes" | `./scripts/sync-global-skills.sh --prune` |

### H) Manutenção, Tarefas e Saúde do Cofre
| Intenção do Usuário no Prompt | Comando a Executar |
| :--- | :--- |
| "Limpar vault", "Verificar links quebrados", "Checar saúde do cofre" | `/obsidian-health` |
| "Resolver contradições entre notas", "Reconciliar verdades" | `/obsidian-reconcile` |
| "Adicionar tarefa X ao Kanban", "Nova task para o projeto Y" | `/obsidian-task [descrição]` |
| "Cadastrar obrigação recorrente (imposto, assinatura)" | `/obsidian-recurring` |
| "Visualizar mapa mental/canvas do cofre" | `/obsidian-visualize` |

---

## 2. Regra de Resolução de Colisão (Longest Matching Trigger)

Se o prompt do usuário corresponder a mais de um comando, **o gatilho mais específico deve prevalecer**:

- **Ideia rápida** vs **Varredura da sessão**: Use `/obsidian-capture` (para uma ideia rápida isolada) em vez de `/obsidian-save` (que varre toda a conversa por pessoas, tarefas e decisões).
- **Pesquisa aberta** vs **Pesquisa no Vault**: Use `/notebooklm` se a busca for restrita ao cofre local; use `/research-deep` se for para combinar cofre + busca externa.
- **Tarefa pontual** vs **Tarefa recorrente**: Use `/obsidian-recurring` se houver cadência mensal/semanal; use `/obsidian-task` se for pontual.

---

## 3. Diretrizes Principais de Memória (Search-Before-Create)

1. **Buscar Antes de Criar**: Antes de gerar uma nova nota de projeto, pessoa ou conceito, execute `/obsidian-find <termo>` para evitar duplicatas.
2. **Conformidade AI-First & OKM**:
   - Toda escrita deve possuir o preâmbulo `## For future Claude`.
   - Rastreamento bi-temporal (`timeline: from/until/learned/source`) para fatos que mudam.
   - Marcação de recência `(as of YYYY-MM)` em afirmações externas.
   - Links internos obrigatórios (`[[wikilinks]]`).
3. **Filtro de Relevância**: Não salve logs efêmeros de terminal ou correções triviais de sintaxe. Salve decisões arquiteturais, bugs complexos resolvidos e marcos de projeto.