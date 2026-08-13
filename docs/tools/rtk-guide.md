# Guia do RTK (Rust Token Killer) para Agentes de IA

O **RTK (Rust Token Killer)** é um proxy de terminal de altíssimo desempenho desenvolvido em Rust (com overhead de inicialização inferior a 10ms). Ele intercepta as saídas de comandos de terminal executados por agentes de IA e aplica filtros inteligentes para economizar entre **60% e 90% dos tokens de contexto**.

---

## Por que usar o RTK?

### O Problema: Saturação de Contexto (*Context Saturation*)
Assistentes de código baseados em LLM gastam a maior parte de sua janela de contexto lendo saídas verbosas do terminal — como barras de progresso, `git diff` sem alteração, suítes de teste com centenas de linhas de sucesso repetitivas e listagens de diretórios. Isso gera:
- **Custo financeiro elevado** (desperdício maciço de tokens de entrada).
- **Degradação de raciocínio (*Context Rot*)**: A LLM perde atenção no código fonte real devido ao excesso de ruído textual.

### A Solução RTK
O RTK intercepta comandos comuns no ambiente Bash e aplica 4 estratégias sistemáticas:
1. **Smart Filtering**: Remove comentários, linhas em branco e barras de progresso sem valor semântico.
2. **Grouping**: Agrupa modificações e buscas por estrutura de pastas.
3. **Truncation Seletivo**: Mantém apenas as pilhas de execução (*stack traces*) e mensagens de falha, descartando indicadores repetitivos de sucesso.
4. **Preservação de Exit Status**: Preserva rigorosamente os códigos de retorno (`exit status` 0 para sucesso, !=0 para falha), garantindo que testes e workflows não sejam corrompidos por relatórios falsamente bem-sucedidos.

---

## Instalação & Configuração no WSL / Linux

### 1. Instalação do Binário
Execute no terminal do WSL:
```bash
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
```

Garanta que `~/.local/bin` esteja no seu `PATH`:
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Verifique a instalação:
```bash
rtk --version
rtk gain
```

Caso ocorra algum erro durante a verificação, consulte a [Documentação Oficial do RTK](https://www.rtk-ai.app/docs/).

---

## Inicialização Nativa para Agentes de IA

O RTK possui suporte nativo para múltiplos agentes de codificação. Para configurar automaticamente as regras do projeto:

### PreToolUse Hook Global (Reescrita Transparente)
Para permitir que o assistente de IA reescreva automaticamente comandos Bash comuns para os equivalentes do RTK sem alterações manuais de workflow:
```bash
rtk init --global
```

### Google Antigravity (Recomendado)
Para instalar o arquivo de regras nativo `.agents/rules/antigravity-rtk-rules.md` no seu projeto:
```bash
# Inicialização no repositório atual
rtk init --agent antigravity

# Inicialização global para todos os projetos Antigravity
rtk init -g --agent antigravity
```

### Agentes Suportados (`rtk init --agent <agente>`)
- **`antigravity`** (Google Antigravity)
- **`claude`** (Claude Code)
- **`cursor`** (Cursor)
- **`copilot`** (GitHub Copilot CLI)
- **`cline`** / **`windsurf`** / **`opencode`** / **`hermes`** / **`kilo`** / **`factory`** / **`vibe`**

---

## Comandos Otimizados do RTK

Abaixo estão os comandos otimizados suportados pelo RTK para substituir saídas cruas por saídas sintéticas densas:

### 1. Controle de Versão (Git & GitHub CLI)
```bash
rtk git status          # Visualização compacta de arquivos alterados
rtk git diff            # Diff otimizado omitindo trechos sem alterações
rtk git log -n 5        # Histórico de commits resumido
rtk gh pr list          # Lista PRs sem tabelas decorativas verbosas
rtk gh checks           # Exibe apenas status relevantes de CI/CD
```

### 2. Compilação, Testes e Linters (Rust, Python, JS/TS)
```bash
rtk cargo test          # Executa testes Rust mostrando apenas falhas
rtk cargo check         # Checagem de tipos e alertas de compilação
rtk cargo clippy        # Linters de Rust compactados
rtk pytest              # Executa testes Python mantendo apenas stack traces
rtk ruff                # Linter/formatter Python de alta performance
rtk uv run <cmd>        # Executa comandos via uv com ambiente isolado
rtk jest                # Executa suíte de testes JavaScript/TypeScript
rtk vitest              # Runner de testes Vite/JS ultrarrápido
rtk playwright          # Testes E2E com resultados condensados
rtk npm test            # Atalho genérico para gerenciador de pacotes Node
```

### 3. Inspeção de Código e Arquivos
```bash
rtk read src/main.rs    # Leitura limpa de arquivo (remove comentários redundantes)
rtk ls src/             # Listagem ultra-sintética de diretórios
rtk grep "pattern" src/ # Busca agrupada por módulo com deduplicação
rtk find "*.rs" .       # Árvore de arquivos estruturada ultracompacta
```

### 4. Infraestrutura e Containers
```bash
rtk docker ps           # Lista containers ativos omitindo colunas desnecessárias
rtk docker compose logs # Filtra logs repetitivos de containers
rtk kubectl get pods    # Status sintético de pods Kubernetes
```

---

## Meta Comandos (Métricas & Diagnóstico)

O RTK oferece subcomandos de diagnóstico para monitorar sua taxa de adoção e economia de tokens:

```bash
rtk gain                # Exibe o painel geral de economia de tokens
rtk gain --history      # Histórico de comandos com percentual de economia por execução
rtk cc-economics        # Análise financeira: gastos com LLM vs. economia gerada pelo RTK
rtk discover            # Analisa o histórico de comandos e lista oportunidades perdidas sem RTK
rtk session             # Acompanha a taxa de adoção do RTK nas últimas sessões do agente
rtk proxy <comando>     # Executa o comando bruto sem filtragem (útil para depuração)
```

---

## Resumo das Regras para o Agente (`.agents/rules/antigravity-rtk-rules.md`)

Ao rodar `rtk init --agent antigravity`, a seguinte diretriz é gravada para instruir a LLM a utilizar as ferramentas do RTK automaticamente:

```markdown
# RTK Token Savings Instructions

Always use `rtk` subcommands for terminal operations to save 60-90% token context:
- `rtk read <file>` instead of raw reading
- `rtk grep <pattern>` for grouped search
- `rtk find <glob>` for directory exploration
- `rtk git <cmd>` for git operations
- `rtk <test-runner>` for test suites

Do not ignore non-zero exit codes. They indicate real underlying failures.
```
