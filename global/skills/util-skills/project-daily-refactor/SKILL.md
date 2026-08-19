---
name: project-daily-refactor
description: >
  Migra arquivos legados da pasta OLD/ de um projeto para o padrão oficial
  (project.md, dailies sequenciais, cadernos de apoio). Se OLD/ não existir ou estiver vazia, não faz nada.
metadata:
  category: workflow
---

# Project Daily Refactor

Pega tudo que está na pasta `OLD/` de um projeto e migra para o padrão oficial de dailies.
Se não existir `OLD/` ou estiver vazia → não faz nada.

---

## Estrutura Alvo

```text
$DAILIES_DIR/<Projeto>/
├── project.md                 # Hub do projeto
├── Dailies/
│   └── N - Daily - YYYY-MM-DD.md
├── Notes/
│   ├── TODO.md
│   ├── IPS.md
│   ├── Users.md
│   ├── Links.md
│   └── Accounts.md
└── OLD/
    └── _migrated/             # Originais movidos após migração
```

---

## Fluxo de Execução

### 1. Resolver diretórios

- Ler `$DAILIES_DIR` do ambiente.
- Nome do projeto: argumento do usuário ou repo Git ativo.
- `DIR="$DAILIES_DIR/<Projeto>"`, `OLD_DIR="$DIR/OLD"` (ou `$DIR/old`).

### 2. Verificar guarda (No-Op)

```bash
[ -d "$OLD_DIR" ] && find "$OLD_DIR" -maxdepth 1 -type f | wc -l
```

Se `OLD/` não existir ou tiver 0 arquivos → mensagem e **parar**:
> ℹ️ Nenhum arquivo legado em OLD/. Nada a fazer.

### 3. Ler e classificar conteúdo de OLD/

Para cada arquivo em `OLD/`:
1. Ler o conteúdo completo.
2. Classificar: é daily? notas de IP? tarefas? links? acessos?

### 4. Migrar dailies

1. Extrair data de cada daily legada.
2. Ordenar cronologicamente (mais antiga → mais recente).
3. Sequência: continuar do maior N existente em `Dailies/` + 1 (ou 1 se vazio).
4. Criar cada daily no formato `templates/Projects/daily.base.md`:
   - Linguagem humana, sem ruído de IA.
   - Barra de navegação no topo.
   - Seções: O que fiz / O que vou fazer / Pendências / Detalhamento Técnico.

### 5. Extrair cadernos de apoio (Notes/)

Conteúdo encontrado nos arquivos legados vai para:
- IPs e portas → `Notes/IPS.md`
- Usuários e acessos → `Notes/Users.md`
- Links e URLs → `Notes/Links.md`
- Contas e credenciais → `Notes/Accounts.md`
- Tarefas → `Notes/TODO.md` (Em Progresso / Backlog / Concluído)

### 6. Atualizar project.md e Index.md

- Criar `project.md` se não existir (template `project.base.md`).
- Inserir todas as dailies migradas na tabela de histórico.
- Garantir que o projeto está no `$DAILIES_DIR/Index.md`.

### 7. Arquivar originais

```bash
mkdir -p "$OLD_DIR/_migrated"
mv "$OLD_DIR"/*.* "$OLD_DIR/_migrated/" 2>/dev/null || true
```

---

## Regras

1. **Se OLD/ não existir ou estiver vazia → parar.** Não criar nada.
2. **Linguagem humana** — reescrever conteúdo legado em linguagem clara de standup.
3. **Preservar dados** — ler tudo antes de migrar, não perder informação.
4. **Caminhos entre aspas duplas** — `"$DAILIES_DIR"`.
5. **Não usar Python** — usar `write_to_file`, `replace_file_content`, ou shell nativo.
6. **Arquivar, não deletar** — originais vão para `OLD/_migrated/`.

---

## Como Invocar

```text
/project-daily-refactor MeuProjeto
```
