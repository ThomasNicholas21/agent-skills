# Project Architecture: Agent Skills Ecosystem

## Architecture & System Overview
The **Agent Skills** ecosystem is a centralized infrastructure for managing, parameterizing, and automating rules (`rules/`), workflows (`workflows/`), and skills (`skills/`) for autonomous coding agents (Google Antigravity and Claude Code).

The ecosystem is structured into four main operational tracks:

1. **Global Skills & Rules Track (`global/`)**:
   - `global/GEMINI.md` & `global/CLAUDE.md`: Always-On universal agent operating directives.
   - `global/global_workflows/`: Universal workflows for quality audit, TDD, project study, and Second Brain sync.
   - `global/skills/`: Categorized global skill packages (`patterns-skills/`, `obsidian-skills/`, `util-skills/`, and standalone skills) bi-directionally synchronized with `~/.gemini/config/skills/` and `~/.claude/skills/`.

2. **Project Templates Track (`templates/project-.agents/`)**:
   - `rules/`: 15 specialized development rules (`drf-viewsets`, `drf-serializers`, `django-models`, `django-forms`, `django-validators`, `django-and-drf-performance`, `drf-exceptions`, `drf-urls`, `testing-standards`, `antigravity-rtk-rules`, `anti-drift`, `style-guide`, etc.).
   - `skills/`: Onboarding and meta-skills (`skill-creator`, `update-agents`, etc.).
   - `workflows/`: Local project workflows (`/update-agents`, `/create-plan`, `/refactor-clean`).

3. **Knowledge Base Track (`docs/`)**:
   - `docs/design-patterns/`: Central catalog (`INDEX.md`) and references for GoF Patterns, Refactoring Guru, and Service Design Patterns.
   - `docs/tools/`: RTK token killer optimization manual and Obsidian Second Brain manuals.

4. **Automation & Environment Track (`scripts/`)**:
   - `init-project-agents.sh` & `clone-agent-template.sh`: Instantiates `.agents/`, `CLAUDE.md`, and `GEMINI.md` into any target project.
   - `sync-global-skills.sh`: Bi-directional synchronization of skills (unpacking submodules) and global rules (`GEMINI.md`/`CLAUDE.md`).
   - `agent-env.sh` & `load-global-env.sh`: Global environment variable parametrization (`DOC_DIR`, `AGENT_SKILLS_DIR`, `GEMINI_DIR`, `CLAUDE_DIR`, `OBSIDIAN_VAULT_DIR`, `SECOND_BRAIN_DIR`).

---

## Directory & File Structure

```text
agent-skills/
├── .env.example                           # Exemplo de configuração de env vars
├── PROJECT.md                             # Documento de arquitetura do projeto
├── README.md                              # Documentação oficial do ecossistema
├── docs/                                  # Base de conhecimento de Design Patterns e Ferramentas
│   ├── design-patterns/                   # GoF, Refactoring Guru e Service Design Patterns + INDEX.md
│   └── tools/                             # Manuais do RTK e Obsidian Second Brain
├── global/                                # Espelho global (sincronizado com ~/.gemini/ e ~/.claude/)
│   ├── GEMINI.md                          # Diretivas Always-On universais
│   ├── global_workflows/                  # Workflows globais (audit-quality, study-project, tdd-feature, etc.)
│   └── skills/                            # Skills globais (patterns-skills, obsidian-skills, util-skills, feature)
├── templates/                             # Templates mestres para novos projetos
│   └── project-.agents/                   # Estrutura base da pasta .agents/ para repositórios
│       ├── rules/                         # 15 Regras (models, viewsets, serializers, drf-architecture, performance, testes, RTK)
│       ├── skills/                        # Skills locais (skill-creator, update-agents)
│       └── workflows/                     # Workflows locais (/update-agents)
└── scripts/                               # Scripts executáveis de automação
    ├── agent-env.sh                       # Carregador de variáveis de ambiente do repositório
    ├── init-project-agents.sh             # Inicialização de infraestrutura em projetos destino
    ├── clone-agent-template.sh            # Clonagem mestre de templates
    ├── sync-global-skills.sh              # Sincronização bidirecional de skills e regras globais
    └── load-global-env.sh                 # Carregador de variáveis globais na shell profile
```

---

## Technical Standards

### 1. Skill Package Standard (`SKILL.md`)
- **Frontmatter YAML**: Must contain `name` in `kebab-case` and `description` in 3rd-person imperative/descriptive style.
- **Progressive Disclosure**: `SKILL.md` body must be lean (<100 lines), referencing detailed docs in `references/`.
- **RTK Directives**: Executable procedures must use `rtk` prefix for terminal efficiency.

### 2. Rule Package Standard (`trigger: glob:`)
- **Activation**: Rules in `templates/project-.agents/rules/` use `trigger: glob:` patterns supporting both single files and package directories (e.g. `**/{viewsets.py,viewsets/**/*.py}`).

### 3. Environment Variables Standard
- `AGENT_SKILLS_DIR`: Path to `agent-skills` repository root.
- `DOC_DIR`: Path to `$AGENT_SKILLS_DIR/docs`.
- `GEMINI_DIR`: Path to `$HOME/.gemini`.
- `CLAUDE_DIR`: Path to `$HOME/.claude`.
