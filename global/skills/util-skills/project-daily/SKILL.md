---
name: project-daily
description: >
  Cria a daily de hoje para um projeto em $DAILIES_DIR.
  Mantém Index.md na raiz, project.md como hub, dailies sequenciais e cadernos de apoio.
metadata:
  category: workflow
---

# Project Daily

Cria a daily de hoje para o projeto. Escrita simples, humana, direto ao ponto.

---

## Estrutura

```text
$DAILIES_DIR/
├── Index.md                          # Lista todos os projetos
├── <Projeto>/
│   ├── project.md                    # Hub: links, tags, histórico de dailies
│   ├── Dailies/
│   │   └── N - Daily - YYYY-MM-DD.md
│   └── Notes/
│       ├── TODO.md                   # Em Progresso / Backlog / Concluído
│       ├── IPS.md                    # IPs, portas, hosts
│       ├── Users.md                  # Usuários e acessos
│       ├── Links.md                  # URLs, repos, dashboards
│       └── Accounts.md              # Contas e credenciais
```

---

## Fluxo de Execução

### 1. Resolver diretórios

- Ler `$DAILIES_DIR` do ambiente. Se não existir, pedir ao usuário.
- Nome do projeto: argumento do usuário ou nome do repo Git ativo.
- Slug: versão kebab-case do nome (ex: `MeuProjeto` → `meu-projeto`).
- `DIR="$DAILIES_DIR/<Projeto>"`.

### 2. Scaffolding (se o projeto não existir)

Se a pasta do projeto não existir, criar tudo:

```bash
DIR="$DAILIES_DIR/<Projeto>"
mkdir -p "$DIR/Dailies" "$DIR/Notes"
```

1. Criar `project.md` a partir de `templates/Projects/project.base.md`.
2. Criar cadernos em `Notes/` a partir de `notes.base.md` e `todo.base.md`.
3. Garantir que o projeto está listado em `$DAILIES_DIR/Index.md` (criar do `templates/index.base.md` se necessário).

### 3. Criar a daily de hoje

1. Verificar dailies existentes em `"$DIR/Dailies/"`.
2. Se já existe daily para hoje → **atualizar** (mesmo N).
3. Se não → `N = maior N existente + 1` (ou `1` se primeira).
4. Nome: `<N> - Daily - <YYYY-MM-DD>.md`.
5. Preencher usando `templates/Projects/daily.base.md`.

### 4. Atualizar project.md

Adicionar linha na tabela de histórico:

```markdown
| N | [[Dailies/N - Daily - YYYY-MM-DD|N - Daily - YYYY-MM-DD]] | YYYY-MM-DD | Destaque em 1 frase |
```

---

## Templates

### Daily (`daily.base.md`)

```markdown
---
tags:
  - projects
  - projects/{{PROJECT_SLUG}}
  - projects/{{PROJECT_SLUG}}/daily
  - daily
  - daily/{{YEAR}}
date: {{DATE}}
sequence: {{SEQUENCE}}
project: {{PROJECT_NAME}}
---

# {{SEQUENCE}} - Daily - {{DATE}}

**Projeto:** [[../project|{{PROJECT_NAME}}]] | **Índice:** [[../../Index|📑 Projetos]] | **Anterior:** {{PREVIOUS_DAILY_LINK}} | **TODO:** [[../Notes/TODO|TODO]]

**O que fiz:**
- item

**O que vou fazer:**
- item

**Pendências:**
- Nenhuma

---

## Detalhamento Técnico

### Por que (motivação)
- razão

### Como (implementação)
- detalhe

### Impactos
- mudança
```

### project.md (`project.base.md`)

```markdown
---
tags:
  - projects
  - projects/{{PROJECT_SLUG}}
  - projects/{{PROJECT_SLUG}}/daily
project_name: {{PROJECT_NAME}}
slug: {{PROJECT_SLUG}}
date_created: {{DATE}}
---

# Projeto: {{PROJECT_NAME}}

**Índice Geral:** [[../Index|📑 Projetos]]

## Visão Geral
{{PROJECT_DESCRIPTION}}

## Cadernos de Apoio
- [[Notes/TODO|📋 TODO]]
- [[Notes/IPS|🌐 IPs]]
- [[Notes/Users|👥 Usuários]]
- [[Notes/Links|🔗 Links]]
- [[Notes/Accounts|🔑 Contas]]

## Histórico de Dailies

| # | Daily | Data | Destaques |
|---|---|---|---|
```

### Index.md (`index.base.md`)

```markdown
---
tags:
  - projects
  - daily-index
---

# 📑 Catálogo de Projetos

| Projeto | Tag | Descrição | Acesso |
|---|---|---|---|
| {{PROJECT_NAME}} | `#projects/{{PROJECT_SLUG}}` | {{DESCRIPTION}} | [[{{PROJECT_NAME}}/project|Abrir]] |
```

---

## Regras

1. **Linguagem humana** — escrever como uma pessoa escreveria numa standup. Sem ruídos de IA.
2. **Caminhos entre aspas duplas** — sempre `"$DAILIES_DIR"`.
3. **Não usar Python** — usar `write_to_file`, `replace_file_content`, ou shell nativo.
4. **Preservar conteúdo existente** — ler antes de escrever em arquivos já existentes.
5. **Second Brain** — acionar `/obsidian-decide` ou `/obsidian-save` **só** para decisões duráveis que devem ir pro cofre.

---

## Como Invocar

```text
/project-daily MeuProjeto
```
