---
name: rtk
description: High-performance CLI proxy instructions for LLM agents. Automatically routes terminal operations, file inspection, searches, git, builds, tests, logs, container, and cloud commands through RTK filters to reduce context window usage by 60-90%.
---

# RTK — Terminal Efficiency & Context Preservation Layer

## Purpose
Compress terminal output by 60% to 90% before sending it to the LLM context window, while strictly preserving exit codes, error stack traces, and necessary diagnostic evidence. Correctness always takes precedence over compression.

---

## 1. Global Performance Flags
* `--ultra-compact`: Enable inline formatting and ultra-dense ASCII output (Level 2 optimization).
* `--skip-env`: Set `SKIP_ENV_VALIDATION=1` for child processes (Next.js, tsc, lint, prisma).
* `-v` / `-vv`: Increase verbosity level if standard compression hides essential diagnostic details.

---

## 2. Complete Subcommand Reference

### Inspeção de Código & Navegação
| Operação Nativa | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| `cat <file>` | `rtk read <file>` | Leitura sem linhas em branco e comentários redundantes |
| `ls <dir>` | `rtk ls <dir>` | Listagem sintética de diretórios |
| `tree <dir>` | `rtk tree <dir>` | Árvore de diretórios otimizada |
| `find <pattern>` | `rtk find <glob>` | Busca de arquivos em formato de árvore condensada |
| `grep <pattern>` | `rtk grep "<pattern>" [path]` | Busca agrupada por arquivo com deduplicação |
| `ripgrep <pattern>` | `rtk rg "<pattern>" [path]` | Wrapper nativo do ripgrep com filtro de saída RTK |
| `git diff` | `rtk diff` | Diff ultra-condensado (apenas linhas alteradas) |
| `cat app.log` | `rtk log <file>` | Filtro de log com remoção de duplicatas |
| `wc <file>` | `rtk wc <file>` | Contagem de linhas/palavras/bytes sem padding |
| `cat data.json` | `rtk json <file>` | JSON comprimido (ou `--keys-only` para esquema) |

### Testes, Linters & Tipagem
| Ferramenta | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Testes Gerais | `rtk test <cmd>` / `rtk err <cmd>` | Exibe estritamente erros e falhas |
| Pytest (Python) | `rtk pytest` | Suíte Pytest mantendo apenas stack traces de falhas |
| Ruff (Python) | `rtk ruff` | Linter e formatter Python acelerado |
| Mypy (Python) | `rtk mypy` | Checagem de tipos Python com erros agrupados |
| Jest / Vitest | `rtk jest` / `rtk vitest` | Runners de teste JS/TS com saída resumida |
| Playwright | `rtk playwright` | Testes E2E com logs sintéticos |
| TypeScript | `rtk tsc` | Compilador TypeScript com erros agrupados por arquivo |
| ESLint / Prettier | `rtk lint` / `rtk prettier` | Linter e formatter com regras agrupadas |
| Formatter Geral | `rtk format` | Formatação universal (prettier, black, ruff) |
| PHP Quality | `rtk phpstan` / `rtk phpunit` / `rtk pest` / `rtk paratest` / `rtk ecs` / `rtk pint` | Ferramentas de análise, teste e estilo PHP |
| Ruby Quality | `rtk rubocop` / `rtk rspec` / `rtk rake` | Testes e linters em Ruby e Rails |
| Go Quality | `rtk golangci-lint` | Wrapper para linters em Go |

### Runtimes, Package Managers & Builds
| Ecossistema | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Rust / Cargo | `rtk cargo test` / `rtk cargo check` / `rtk cargo clippy` | Builds, testes e clippy em Rust |
| Node.js / pnpm | `rtk pnpm <cmd>` / `rtk npm <cmd>` / `rtk npx <cmd>` | Execução de scripts e gerenciamento sem boilerplate |
| Python Pip / uv | `rtk pip <cmd>` / `rtk uv <cmd>` | Instalação e execução Python preservando o venv |
| Go | `rtk go <cmd>` | Builds e testes em Go |
| .NET | `rtk dotnet <cmd>` | Build, test, restore e format em .NET |
| Java / Kotlin | `rtk gradlew <cmd>` / `rtk mvn <cmd>` | Gradle wrapper Android e Maven |
| Scala | `rtk sbt <cmd>` | Build e testes em Scala |

### Infraestrutura, Containers & BD
| Serviço | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Docker | `rtk docker ps` / `rtk docker compose logs` | Containers e logs sem tabelas verbosas |
| Kubernetes | `rtk kubectl get pods` / `rtk oc <cmd>` | Status de pods Kubernetes e OpenShift |
| AWS CLI | `rtk aws <cmd>` | AWS CLI com JSON comprimido |
| PostgreSQL | `rtk psql <cmd>` | Cliente psql sem bordas decorativas |
| Prisma ORM | `rtk prisma <cmd>` | CLI Prisma sem artes ASCII e banners |

### Controle de Versão & PRs
| Plataforma | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Git | `rtk git status` / `rtk git diff` / `rtk git log -n 5` | Operações Git condensadas |
| GitHub CLI | `rtk gh pr list` / `rtk gh checks` | PRs e status de CI do GitHub |
| GitLab CLI | `rtk glab <cmd>` | Operações da CLI do GitLab |
| Graphite | `rtk gt <cmd>` | Gerenciamento de stacked PRs |

### Métricas & Diagnósticos
| Ferramenta | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Economia Total | `rtk gain` / `rtk gain --history` | Painel de tokens economizados e histórico |
| Análise Financeira | `rtk cc-economics` | Gasto de contexto vs. economia do RTK |
| Oportunidades | `rtk discover` | Lista comandos rodados fora do RTK no histórico |
| Taxa de Adoção | `rtk session` | Frequência de uso do RTK nas últimas sessões |
| Aprendizado | `rtk learn` | Analisa histórico de erros para aprender correções |
| Auditoria Hook | `rtk hook-audit` | Métricas do reescritor de comandos (`RTK_HOOK_AUDIT=1`) |

### Controle Low-Level & Proxy
| Função | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Configuração | `rtk init` / `rtk config` | Inicializa regras ou exibe arquivo de configuração |
| Confiança TOML | `rtk trust` / `rtk untrust` | Gerencia permissão de filtros locais no repositório |
| Validação | `rtk verify` | Verifica integridade de hooks e testes de filtros |
| Pipeline Unix | `rtk pipe` | Filtra entrada via stdin (`cat log \| rtk pipe`) |
| Raw com Métricas | `rtk proxy <cmd>` | Executa saída bruta mas registra tokens no `gain` |
| Raw sem Filtro | `rtk run <cmd>` | Executa comando puro via `sh -c` sem monitoramento |

---

## 3. Matriz de Escalonamento de Diagnóstico
Se a saída do RTK for excessivamente comprimida para diagnosticar uma falha:
1. **Nível 1 (Padrão)**: `rtk <comando>`
2. **Nível 2 (Específico / Ultra-compacto)**: `rtk <comando> --path <target>` ou `rtk <comando> --ultra-compact`
3. **Nível 3 (Detalhado)**: `rtk <comando> -v`
4. **Nível 4 (Nativo / Raw)**: `rtk proxy <comando>` (mantém rastreamento) ou comando nativo puro.

---

## 4. Regras de Otimização e Integridade
* **Exit Status**: O RTK propaga estritamente o código de saída do processo filho. `exit status != 0` representa uma falha real e **nunca deve ser ignorado**.
* **Zero Swallowing**: Nunca ignore saídas de erro. Se o resultado filtrado omitiu detalhes essenciais para depuração, escale para o Nível 3 ou Nível 4.
* **Zero Guessing**: Em caso de dúvida sobre parâmetros ou suporte, execute `rtk --help` ou `rtk <subcomando> --help`.