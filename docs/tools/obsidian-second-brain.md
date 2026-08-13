# Guia Completo do Obsidian Second Brain para Agentes de IA

O **Obsidian Second Brain** (desenvolvido por Eugeniu Ghelbur) é um ecossistema de memória longitudinal persistente que transforma um cofre Obsidian em uma base de conhecimento viva e auto-editável em Markdown.

---

## 1. Visão Geral e Arquitetura OKM

O Second Brain adota o padrão **Open Knowledge Metabolism (OKM)** para gerenciar o conhecimento do desenvolvedor e do agente através de 4 princípios:

1. **Reescrita Dinâmica**: Em vez de append-only infinito, as notas existentes são sintetizadas e atualizadas continuamente a cada nova fonte.
2. **Política de Frescor / Recência (*Freshness Policy*)**: Eliminação de dados obsoletos e classificação temporal por recência (`as of YYYY-MM`).
3. **Rastreamento Bi-temporal**: Registro da data do evento no mundo real (`from`/`until`) e da data de assimilação no cofre (`learned`).
4. **Reconciliação Automática**: Resolução proativa de contradições entre notas antigas e novas.

---

## 2. Categorias de Skills e Comandos (46 Comandos)

O ecossistema organiza 46 comandos em 4 camadas funcionais mais agentes de segundo plano:

### A) Gestão de Cofre e Memória Base (Operações)
- `/obsidian-init`: Inicializa o cofre criando `_CLAUDE.md` / `AGENTS.md` (regras e esquema de IA), `index.md` (índice central) e logs de operação.
- `/obsidian-save`: Comando mestre que analisa a sessão e dispara subagentes paralelos para salvar decisões, tarefas, pessoas, projetos e ideias em notas interconectadas (`[[nota]]`).
- `/obsidian-daily`: Cria ou atualiza a nota diária puxando compromissos, tarefas e atividades.
- `/obsidian-ingest`: Processa URLs, PDFs, áudio (`.m4a` via Whisper) e imagens/screenshots para reescrever de 5 a 15 páginas do cofre por fonte.
- `/obsidian-find <termo>`: Executa busca híbrida (palavras-chave e semântica) nas notas do cofre.
- `/obsidian-reconcile`: Roda varredura de reconciliação para resolver divergências entre notas.
- `/obsidian-health`: Diagnóstico de integridade estrutural do cofre (Vault Health Score, links quebrados, notas órfãs, frescor OKM).
- `/obsidian-reindex`: Reindexa conexões e recalcula a matriz de wikilinks.
- `/obsidian-task` / `/obsidian-recurring`: Gerencia tarefas pontuais e obrigações recorrentes (impostos, assinaturas, pagamentos).

### B) Ferramentas de Pensamento e Síntese
- `/obsidian-brainstorm [tópico]`: Entrevista socrática em múltiplos turnos para convergência de ideias.
- `/obsidian-panel`: Simula um painel com personas/especialistas distintos para avaliar uma decisão.
- `/obsidian-challenge`: Analisa criticamente hipóteses utilizando o próprio histórico do cofre para apontar contradições ou falhas passadas.
- `/obsidian-distill`: Destila notas extensas extraindo apenas conceitos nucleares com proveniência de dados.
- `/obsidian-emerge`: Identifica padrões e tópicos emergentes não nomeados entre múltiplos documentos do cofre.
- `/obsidian-synthesize`: Cria notas de síntese temática a partir de buscas no cofre.
- `/obsidian-decide`: Registra decisões formais de arquitetura (ADRs) com contexto e consequências.

### C) Contexto e Mapeamento de Projetos
- `/obsidian-world`: Carrega identidade (`SOUL.md`), fatos críticos (`CRITICAL_FACTS.md`) e estado atual com orçamentos progressivos de tokens (L0-L3).
- `/obsidian-architect`: Examina todo o código-fonte do repositório ativo e cria/atualiza a documentação arquitetural no cofre.
- `/obsidian-project`: Cria e gerencia a nota principal de acompanhamento de um projeto (visão geral, metas, tarefas).

### D) Pesquisa Externa e Ingestão de Mídia
- `/research <tópico>`: Realiza pesquisa web rápida (fontes públicas gratuitas ou Perplexity Sonar) e salva o dossiê no cofre.
- `/research-deep <tópico>`: Pesquisa *Vault-First* multi-fonte que analisa o cofre primeiro para preencher apenas as lacunas de informação.
- `/notebooklm <tópico>`: Síntese *Vault-Grounded* que carrega as notas mais relevantes do cofre no Gemini File Search para respostas fundamentadas.
- `/youtube <url> [--visual]`: Extrai e resume transcrições de vídeos do YouTube; com `--visual`, extrai e analisa quadros de cena via visão computacional.
- `/podcast <url>`: Processa episódios de podcast (RSS / Apple Podcasts / Whisper) para síntese no cofre.
- `/x-pulse` / `/x-read`: Processa posts, threads e tendências no X (Twitter) via xAI Grok.

---

## 3. Como Utilizar o Obsidian Second Brain em Projetos

### Fluxo de Inicialização de Projeto:
1. Ao iniciar a sessão, execute `/obsidian-world` para carregar o contexto de identidade e fatos críticos.
2. Ao iniciar em um repositório, execute `/obsidian-project` para criar a nota mestre do projeto no cofre.
3. Execute `/obsidian-architect` para mapear a estrutura atual do código-fonte para o cofre.

### Fluxo Diário de Desenvolvimento:
1. Durante as sessões de código, ao definir novas regras ou arquiteturas, execute `/obsidian-save` para salvar o contexto atual no cofre.
2. Para consultar decisões passadas sem sair do projeto, execute `/obsidian-find <termo>`.
3. Ao concluir alterações no Git, execute a skill de sincronização de projeto (`/obsidian-save` nativo ou a skill customizada `/save-project-brain`).

---

## 4. Diagnóstico de Saúde e Manutenção

Recomenda-se executar periodicamente o comando `/obsidian-health` no chat para verificar a pontuação de saúde do seu cofre e manter a integridade da memória do agente.
