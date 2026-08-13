# RTK - Rust Token Killer Mandatory Directive

trigger: glob "**/*"

## Diretrizes Mandatórias de Terminal via RTK

Para otimizar o uso da janela de contexto e prevenir perda de memória operacional, TODAS as operações de terminal executadas pelo agente DEVEM utilizar o prefixo `rtk`.

### 1. Comandos Primários
- **Leitura de Arquivos**: Usar `rtk read <file>` em vez de `cat` ou visualizadores simples.
- **Busca de Texto**: Usar `rtk grep "<pattern>" [path]` para agrupamento e deduplicação de resultados.
- **Exploração de Diretórios**: Usar `rtk find "<glob>" [path]` para visualização compacta de árvores de diretórios.
- **Testes e Compilação**: Usar `rtk pytest`, `rtk cargo test`, `rtk jest` ou `rtk npm test`.
- **Git & Controle de Versão**: Usar `rtk git status`, `rtk git diff`, `rtk git log -n 5`.

### 2. Preservação de Exit Status
- O RTK preserva rigorosamente os códigos de saída (*exit codes*) do processo subjacente.
- NUNCA ignore retornos não-zero (erros de compilação ou falhas de testes). Em caso de erro, analise os logs compactados pelo RTK imediatamente.

### 3. Comandos a serem analisados sempre
#### Inspeção de Código & Navegação
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

#### Testes, Linters & Tipagem
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

#### Runtimes, Package Managers & Builds
| Ecossistema | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Rust / Cargo | `rtk cargo test` / `rtk cargo check` / `rtk cargo clippy` | Builds, testes e clippy em Rust |
| Node.js / pnpm | `rtk pnpm <cmd>` / `rtk npm <cmd>` / `rtk npx <cmd>` | Execução de scripts e gerenciamento sem boilerplate |
| Python Pip / uv | `rtk pip <cmd>` / `rtk uv <cmd>` | Instalação e execução Python preservando o venv |
| Go | `rtk go <cmd>` | Builds e testes em Go |
| .NET | `rtk dotnet <cmd>` | Build, test, restore e format em .NET |
| Java / Kotlin | `rtk gradlew <cmd>` / `rtk mvn <cmd>` | Gradle wrapper Android e Maven |
| Scala | `rtk sbt <cmd>` | Build e testes em Scala |

#### Infraestrutura, Containers & BD
| Serviço | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Docker | `rtk docker ps` / `rtk docker compose logs` | Containers e logs sem tabelas verbosas |
| Kubernetes | `rtk kubectl get pods` / `rtk oc <cmd>` | Status de pods Kubernetes e OpenShift |
| AWS CLI | `rtk aws <cmd>` | AWS CLI com JSON comprimido |
| PostgreSQL | `rtk psql <cmd>` | Cliente psql sem bordas decorativas |
| Prisma ORM | `rtk prisma <cmd>` | CLI Prisma sem artes ASCII e banners |

#### Controle de Versão & PRs
| Plataforma | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Git | `rtk git status` / `rtk git diff` / `rtk git log -n 5` | Operações Git condensadas |
| GitHub CLI | `rtk gh pr list` / `rtk gh checks` | PRs e status de CI do GitHub |
| GitLab CLI | `rtk glab <cmd>` | Operações da CLI do GitLab |
| Graphite | `rtk gt <cmd>` | Gerenciamento de stacked PRs |

#### Métricas & Diagnósticos
| Ferramenta | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Economia Total | `rtk gain` / `rtk gain --history` | Painel de tokens economizados e histórico |
| Análise Financeira | `rtk cc-economics` | Gasto de contexto vs. economia do RTK |
| Oportunidades | `rtk discover` | Lista comandos rodados fora do RTK no histórico |
| Taxa de Adoção | `rtk session` | Frequência de uso do RTK nas últimas sessões |
| Aprendizado | `rtk learn` | Analisa histórico de erros para aprender correções |
| Auditoria Hook | `rtk hook-audit` | Métricas do reescritor de comandos (`RTK_HOOK_AUDIT=1`) |

#### Controle Low-Level & Proxy
| Função | Comando RTK Otimizado | Descrição |
| :--- | :--- | :--- |
| Configuração | `rtk init` / `rtk config` | Inicializa regras ou exibe arquivo de configuração |
| Confiança TOML | `rtk trust` / `rtk untrust` | Gerencia permissão de filtros locais no repositório |
| Validação | `rtk verify` | Verifica integridade de hooks e testes de filtros |
| Pipeline Unix | `rtk pipe` | Filtra entrada via stdin (`cat log \| rtk pipe`) |
| Raw com Métricas | `rtk proxy <cmd>` | Executa saída bruta mas registra tokens no `gain` |
| Raw sem Filtro | `rtk run <cmd>` | Executa comando puro via `sh -c` sem monitoramento |