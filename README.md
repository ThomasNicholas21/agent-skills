# Agent Skills: Hub Central de Arquitetura e Configurações para Agentes de IA

O **Agent Skills** é um ecossistema centralizado para criação, gerenciamento e automação de regras (*Rules*), fluxos de trabalho (*Workflows*) e habilidades (*Skills*) para agentes autônomos de codificação, com suporte nativo ao **Google Antigravity** e **Claude Code**.

---

## 🎯 Objetivo do Projeto

Este repositório resolve os dois maiores problemas no desenvolvimento com agentes de IA:

1. **Saturação de Contexto (*Context Saturation / Context Rot*)**: Reduz o ruído textual de comandos de terminal e arquivos estáticos mantendo a janela de contexto limpa e focada no raciocínio da LLM via **RTK (Rust Token Killer)**.
2. **Amnésia entre Sessões (*Context Loss*)**: Estabelece uma base de memória longitudinal viva e bi-temporal para registrar decisões de arquitetura e aprendizados sem re-explicações via **Obsidian Second Brain**.

---

## ⚙️ Variáveis de Ambiente

As portas de integração e caminhos do ecossistema são parametrizados via variáveis de ambiente. Utilize o arquivo [`scripts/agent-env.sh`](scripts/agent-env.sh) ou copie o [`.env.example`](.env.example):

```bash
export GEMINI_DIR="$HOME/.gemini"
export CLAUDE_DIR="$HOME/.claude"
export OBSIDIAN_VAULT_DIR="$HOME/obsidian/obsidian-second-brain"
export SECOND_BRAIN_DIR="$OBSIDIAN_VAULT_DIR"
export AGENT_SKILLS_DIR="$HOME/projects/agent-skills"
```

---

## 🛠️ Scripts de Automação & Workflows de Inicialização

### 1. Inicializar Infraestrutura de Agentes em Novo Projeto
Para inicializar a pasta `.agents/` em um novo projeto destino:

```bash
./scripts/init-project-agents.sh /caminho/do/projeto-destino
```
*Este script copia a estrutura de regras (`rules/`), habilidades (`skills/`) e fluxos (`workflows/`) para o projeto destino.*

### 2. Calibração Interativa via `/update-agents`
Ao importar o template para um novo projeto, execute o comando de onboarding:
```text
/update-agents
```
*Inicia uma entrevista interativa (estilo `/grill-me`), inspeciona o código via RTK e adapta todas as regras do projeto (`.agents/rules/`) utilizando as diretrizes da **`skill-creator`**.*

### 3. Sincronizar Skills Globais com `~/.gemini/` e `~/.claude/`
Para atualizar a base global de skills a partir do repositório `agent-skills`:

```bash
# Sincronizar TODAS as skills globais (bidirecional):
./scripts/sync-global-skills.sh

# Sincronizar com expurgo de skills órfãs nos agentes (somente push repo -> agentes):
./scripts/sync-global-skills.sh --prune

# Sincronizar uma skill específica com expurgo:
./scripts/sync-global-skills.sh --prune generate-mock-data
```

---

## 📚 Catálogo de Regras do Template (`templates/project-.agents/rules/`)

As regras são ativadas automaticamente pelo agente via casamento de padrões de arquivo (`trigger: glob:`):

| Regra (`rule.md`) | Gatilho (`glob`) | Descrição e Convenções Principais |
| :--- | :--- | :--- |
| **`architecture.md`** | `**/*.py` | Clean Architecture modular: subpasta `api/` nos apps e cascata de roteamento `core/api/urls.py`. |
| **`django-models.md`** | `**/models.py` | Separação explícita de `QuerySet` e `Manager` com `get_queryset()` e `objects = CustomManager()`. |
| **`django-forms.md`** | `**/forms.py` | Estrutura de Forms/ModelForms, validação em `clean_<campo>()` e delegação para `services.py`. |
| **`drf-viewsets.md`** | `**/viewsets.py` | Padrão `GenericViewSet` + Mixins explícitos, seleção dinâmica de serializers e orquestração HTTP. |
| **`drf-views.md`** | `**/views.py` | Hierarquia de views: `APIView` (não-CRUD), `GenericAPIView` e Generic Views concretas (`generics.*`). |
| **`drf-serializers.md`**| `**/serializers.py` | Separação estrita de DTOs: `ReadSerializer` (consultas) e `WriteSerializer` (mutações). |
| **`drf-exceptions.md`** | `**/exceptions.py` | Hierarquia de `DomainException` da Service Layer mapeada por handler global no DRF. |
| **`django-validators.md`**| `**/validators.py` | Validadores de domínio reutilizáveis entre Service Layer, Models (`clean()`) e Serializers. |
| **`drf-urls.md`** | `**/urls.py` | Roteamento hierárquico em 3 níveis e Nested URLs via `drf-nested-routers`. |
| **`drf-architecture.md`** | `**/*.py` | Diretrizes de arquitetura DRF, desacoplamento de camadas e padrão Service Layer/ViewSet. |
| **`django-and-drf-performance.md`** | `**/*.py` | Guia mestre com 70 pontos de performance: `Subquery`, `OuterRef`, `select_related`, `prefetch_related`, N+1 e Redis. |
| **`testing-standards.md`** | `**/test*.py` | Testes determinísticos, mixins de criação herdados, `SimpleTestCase` (sem banco), `TestCase` e `APITestCase`. |
| **`antigravity-rtk-rules.md`** | `*` | Uso mandatório do prefixo `rtk` para compressão de saída de terminal em 60–90%. |
| **`anti-drift.md`** | `*` | Salvaguardas contra refatorações não solicitadas e violações de escopo. |
| **`style-guide.md`** | `**/*.py` | Diretrizes de código limpo, formatação e convenções de estilo. |

---

## 🧩 Catálogo de Habilidades (Skills)

### 🏗️ Meta-Skills & Onboarding
- **`skill-creator`**: Guia determinístico para planejar, desenhar e gerar novas Skills, Rules e Workflows no padrão Antigravity.
- **`update-agents`**: Skill interativa de diagnóstico e calibração de regras para projetos recém-importados.
- **`create-service-skill`**: Meta-skill para criação estruturada de skills de integração com serviços de terceiros.

### 📐 Padrões de Projeto (`patterns-skills/`)
- **`analyze-design-pattern`**: Orquestrador que avalia o contexto do usuário e recomenda/aplica o padrão adequado.
- **`pattern-service-layer`**: Encapsula regras de negócio, transações atômicas e chamadas externas em `services.py`.
- **`pattern-repository`**: Abstrai consultas ORM/SQL complexas e otimizações de banco de dados em `repositories.py`.
- **`pattern-factory`**: Geração parametrizada de objetos e data factories.
- **`pattern-serializer-strategy`**: Separação de DTOs de leitura e escrita.
- **`service-integration-pattern`**: Template de integração resiliente de APIs externas com retries e idempotência.

### 🛠️ Utilitários & Engenharia (`util-skills/`)
- **`rtk`**: Proxy de compressão de saída de terminal para economia de contexto.
- **`development-core`**: Aplicação de rigor de engenharia de software e arquitetura limpa.
- **`project-context`**: Mapeamento inicial de escopo e limites do repositório.
- **`generate-mock-data`**: Geração determinística de dados realistas com Faker (`pt_BR`) e FactoryBoy.
- **`drf-spectacular`**: Documentação OpenAPI 3.0, Swagger UI e `@extend_schema`.
- **`refactor` & `test`**: Runbooks para refatoração segura e execução de suítes de teste.

### 🧠 Memória Persistente & Ensino (`obsidian-skills/`)
- Ecossistema de 50 skills integradas ao **Obsidian Second Brain** (OKM - Open Knowledge Metabolism) cobrindo captura, ensino didático socrático (`ai-tutor`), consultoria de soluções com prós e contras (`solution-architect`), destilação, reconciliação, diagramação, logs diários e persistência bi-temporal de decisões de arquitetura (`save-project-brain`, `obsidian-project`, `obsidian-save`, etc.).

---

## 🏛️ Arquitetura em 3 Pilares

```text
 ┌────────────────────────────────────────────────────────────────────────┐
 │                       AGENT (Antigravity / Claude)                     │
 └───────────────────┬────────────────────────────────┬───────────────────┘
                     │                                │
     ┌───────────────▼───────────────┐    ┌───────────▼───────────────────┐
     │     RTK (Rust Token Killer)   │    │     OBSIDIAN SECOND BRAIN     │
     │   Otimização de Terminal 60-90%│    │  Memória Bi-temporal & LLM Wiki │
     └───────────────────────────────┘    └───────────────────────────────┘
```

1. **Harness de Orquestração (Google Antigravity & Claude Code)**:
   - **Hierarquia de Escopos**: Camada Global (`~/.gemini/`) vs Camada Local (`.agents/` em cada repositório).
   - **Divulgação Progressiva (*Progressive Disclosure*)**: Carregamento sob demanda via metadados YAML em arquivos `SKILL.md`.
   - **Plan-Before-Execute Gate**: Todo plano de ação deve ser apresentado e aprovado antes de alterar código.

2. **Otimização de Terminal (RTK - Rust Token Killer)**:
   - Intercepta comandos no ambiente Bash (WSL/Linux) com overhead inferior a 10ms.
   - Compacta saídas através de filtragem inteligente, agrupamento e deduplicação de logs.

3. **Memória Persistente Longitudinal (Obsidian Second Brain)**:
   - Mantém o histórico vivo de decisões, regras de negócio e marcos do projeto desacoplado do código-fonte.

---

## 📂 Estrutura de Diretórios do Repositório

```text
agent-skills/
├── .env.example                           # Exemplo de configuração de env vars
├── docs/                                  # Manuais RTK, Design Patterns e Second Brain
├── global/                                # Espelho global (sincronizado com ~/.gemini/ e ~/.claude/)
│   ├── GEMINI.md                          # Diretivas Always-On universais
│   └── skills/                            # Skills globais (patterns, util-skills, obsidian, feature)
├── templates/                             # Templates mestres para novos projetos
│   └── project-.agents/                   # Estrutura base da pasta .agents/ para repositórios
│       ├── rules/                         # 15 Regras (models, viewsets, serializers, drf-architecture, performance, testes)
│       ├── skills/                        # Skills locais (skill-creator, update-agents)
│       └── workflows/                     # Workflows locais (/update-agents)
├── scripts/                               # Scripts executáveis
│   ├── agent-env.sh                       # Carregador de variáveis de ambiente
│   ├── init-project-agents.sh             # Inicialização de novos projetos
│   ├── clone-agent-template.sh            # Clonagem mestre de templates
│   ├── load-global-env.sh                 # Carregador global de variáveis no profile shell
│   └── sync-global-skills.sh              # Sincronização de skills globais
└── README.md                              # Documentação oficial do ecossistema
```

---

## 📄 Licença e Manutenção
Mantido para padronização de agentes de IA locais e globais no ecossistema Antigravity e Claude Code.
