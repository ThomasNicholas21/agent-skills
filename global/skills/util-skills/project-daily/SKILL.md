---
name: project-daily
description: >
  Gera e gerencia notas de daily sequenciais (1 - Daily - {{date}}) e cadernos de apoio por projeto em $DAILIES_DIR.
  Inicializa projetos inexistentes automaticamente (Scaffolding com Index.md e Notes/), organiza tags e índices
  para busca no Obsidian, aplica linguagem simples com detalhamento técnico (motivos/raciocínio) e integra com /second-brain.
metadata:
  category: workflow
---

# Project Daily (Dailies Sequenciais, Index e Notas de Apoio por Projeto)

Esta habilidade gerencia o ciclo completo de documentação diária de desenvolvimento por projeto: inicialização automática de novos projetos (scaffolding), geração de **Dailies Sequenciais** (`1 - Daily - YYYY-MM-DD`, `2 - Daily - YYYY-MM-DD`, ...), manutenção do **Índice Mestre (`Index.md`)**, cadernos de apoio (**Notes/**), indexação via tags no Obsidian, redação em **dupla camada (linguagem simples + detalhamento técnico com motivos)** e sincronização com o cofre do **/second-brain**.

Todos os arquivos são armazenados no diretório do sistema configurado em **`$DAILIES_DIR`**, com estrutura otimizada para leitura humana direta e navegação fluida dentro do Obsidian.

---

## 1. Setup e Resolução de Diretórios no Linux

Ao invocar `/project-daily`, o agente deve resolver:

1. **Diretório Raiz de Dailies (`$DAILIES_DIR`)**:
   - Ler a variável `$DAILIES_DIR` do ambiente.
   - Se a variável não estiver definida, avisar o usuário para configurá-la em seu `.env` (exemplo: `DAILIES_DIR="$HOME/dailies"` ou `DAILIES_DIR="/mnt/c/Users/thoma/Meus Documentos/Dailies"`).
   - **Regra de Caminho no Linux**: Sempre utilize aspas duplas ao referenciar o caminho para suportar diretórios com espaços (`"$DAILIES_DIR"`).

2. **Identificação do Nome e Slug do Projeto**:
   - Se o usuário informar o argumento (exemplo: `/project-daily MeuProjeto`), utilize o nome fornecido.
   - Se não informado, infira o nome canônico a partir do diretório do repositório Git ativo ou do contexto da conversa.
   - Gere a versão slug para tags (exemplo: `MeuProjeto` -> `meu-projeto`).

---

## 2. Estrutura Completa de Pastas e Arquivos do Projeto

A skill garante a existência da seguinte estrutura padronizada dentro de `$DAILIES_DIR`:

```text
$DAILIES_DIR/<Nome do Projeto>/
+-- Index.md                    # Hub mestre de navegação, resumo do projeto e índice de dailies
+-- Dailies/
|   +-- 1 - Daily - YYYY-MM-DD.md
|   +-- 2 - Daily - YYYY-MM-DD.md
|   +-- N - Daily - YYYY-MM-DD.md
+-- Notes/
    +-- IPS.md                  # IPs, portas, hosts e infraestrutura
    +-- Users.md                # Usuários de teste, papéis e permissões
    +-- Links.md                # Repositórios, pipelines, Swagger, dashboards
    +-- Accounts.md             # IDs de contas de serviços integrados
    +-- TODO.md                 # Quadro atômico de tarefas (Em Progresso / Backlog / Concluido)
```

---

## 3. Bootstrapping & Scaffolding Automático de Projetos

Caso a pasta do projeto `"$DAILIES_DIR/<Nome do Projeto>"` não exista ao executar a skill, o agente **DEVE inicializá-la automaticamente**:

1. **Criação dos Diretórios**:
   ```bash
   DIR="${DAILIES_DIR}/<Nome do Projeto>"
   mkdir -p "$DIR/Dailies" "$DIR/Notes"
   ```

2. **Criação do `Index.md` Inicial**:
   - Instancie a partir do template `templates/Projects/index.base.md`.
   - Preencha o nome do projeto, slug, data de criação e uma descrição inicial do projeto.

3. **Criação dos Cadernos de Apoio (`Notes/`)**:
   - `Notes/IPS.md`: a partir de `templates/Projects/notes.base.md` com categoria `IPS`.
   - `Notes/Users.md`: a partir de `templates/Projects/notes.base.md` com categoria `Users`.
   - `Notes/Links.md`: a partir de `templates/Projects/notes.base.md` com categoria `Links`.
   - `Notes/Accounts.md`: a partir de `templates/Projects/notes.base.md` com categoria `Accounts`.
   - `Notes/TODO.md`: a partir de `templates/Projects/todo.base.md`.

---

## 4. Sistema de Numeração Sequencial de Dailies (`N - Daily - YYYY-MM-DD`)

Toda daily possui uma **numeração sequencial contínua** (`1`, `2`, `3`, ..., `N`), facilitando a ordenação cronológica e a rastreabilidade histórica.

### A) Nomenclatura e Título
- **Nome do Arquivo**: `"$DIR/Dailies/<N> - Daily - <YYYY-MM-DD>.md"` (Exemplo: `1 - Daily - 2026-08-17.md`, `2 - Daily - 2026-08-18.md`).
- **Título do Documento**: `# <N> - Daily - <YYYY-MM-DD>`.

### B) Algoritmo para Determinar a Sequência e Daily Anterior

1. **Verificar se já existe Daily hoje**:
   - Liste os arquivos em `"$DIR/Dailies/"` que terminam com `{{DATE}}.md` (ex: `* - Daily - 2026-08-17.md`).
   - Se já existir uma daily para a data de hoje, **atualize o arquivo existente**, mantendo a mesma numeração sequencial.

2. **Calcular Próximo Número Sequencial (Nova Daily)**:
   - Liste todas as dailies existentes:
     ```bash
     ls -1 "$DIR/Dailies/" | grep -E "^[0-9]+ - Daily - [0-9]{4}-[0-9]{2}-[0-9]{2}\.md$"
     ```
   - Extraia o maior número no prefixo (exemplo: se o último for `5 - Daily - 2026-08-16.md`, o maior é `5`).
   - A nova daily terá sequência `N = maior + 1` (exemplo: `6`).
   - Se não houver nenhuma daily anterior, `N = 1`.

3. **Link da Daily Anterior**:
   - Se houver daily anterior (ex: `5 - Daily - 2026-08-16.md`), defina o link como `[[5 - Daily - 2026-08-16]]`.
   - Se for a primeira daily (`N = 1`), defina como `Nenhuma`.

4. **Atualização do `Index.md`**:
   - Após salvar a nova daily, adicione uma linha na tabela de histórico do `Index.md`:
     `| <N> | [[<N> - Daily - <YYYY-MM-DD>]] | <YYYY-MM-DD> | <Destaques em 1 frase> |`

---

## 5. Dupla Camada de Linguagem: Simples + Detalhamento Técnico

Para atender tanto a consultas rápidas/gerenciais quanto a necessidades profundas de engenharia, a Daily adota uma **dupla camada de redação**:

```markdown
---
tags:
  - project
  - project/meu-projeto
  - daily
  - daily/2026
date: 2026-08-17
sequence: 1
project: MeuProjeto
---

# 1 - Daily - 2026-08-17

**Projeto:** [[Index|MeuProjeto]] | **Daily anterior:** Nenhuma | **TODO:** [[Notes/TODO|TODO]]

**O que fiz:**
- Criado sistema de autenticacao de usuarios com JWT e rotas de login
- Adicionada validacao de dados de entrada no cadastro de clientes

**O que vou fazer:**
- Implementar fluxo de recuperacao de senha por email
- Escrever testes automatizados para as rotas de autenticacao

**Pendencias:**
- Nenhuma

---

## Detalhamento Técnico & Decisões

### Motivação & Raciocínio (Por que)
- Adotado padrão JWT stateless para permitir escalabilidade horizontal dos nós de API sem necessidade de sessão compartilhada no Redis neste estágio inicial.
- A validação foi desacoplada no nível do Serializer para garantir falha rápida (fail-fast) antes de atingir o banco de dados.

### Implementação & Arquitetura (Como)
- Configurado `djangorestframework-simplejwt` com tokens de acesso de 15 minutos e refresh token de 7 dias com rotação ativada.
- Criada classe base `BaseCustomSerializer` com métodos customizados para formatação de erros em formato RFC 7807.

### Impactos & Mudanças Técnicas
- Novas tabelas de blacklist de tokens migradas via migração `0002_jwt_blacklist.py`.
- Adicionadas variáveis `JWT_SIGNING_KEY` e `JWT_LIFETIME` no `.env.example`.
```

### Diretrizes para a Camada de Linguagem Simples
- **Acessibilidade**: Frases simples, fáceis de explicar para qualquer membro do time ou stakeholder.
- **Verbos de Ação**:
  - *O que fiz*: "Criado...", "Implementado...", "Corrigido...", "Configurado...".
  - *O que vou fazer*: "Escrever...", "Configurar...", "Executar...", "Testar...".
- **Sem Jargões Desnecessários**: Foco no resultado e entrega tangível.

### Diretrizes para a Camada Técnica
- **Motivação e Porquê**: Explicar a razão técnica da decisão, causas raízes de bugs ou critérios de escolha entre alternativas.
- **Como e Arquitetura**: Detalhar bibliotecas, patterns (Service Layer, Factory, etc.), fluxos de dados e contratos de interface.
- **Impactos**: Migrações de banco, quebras de compatibilidade, segurança, performance e novas variáveis de ambiente.

---

## 6. Integração com `/second-brain` (Vault do Obsidian)

Quando a daily envolver **decisões arquiteturais duráveis, lições aprendidas ou mudanças de modelo de domínio**, o agente deve ativar o ecossistema `/second-brain`:

1. **Decisões Arquiteturais Formais (ADR)**:
   - Se uma decisão durável foi registrada no detalhamento técnico da daily, invoque `/obsidian-decide --formal` para criar ou atualizar o registro de decisão no cofre em `$OBSIDIAN_VAULT_PATH/wiki/decisions/`.
2. **Sincronização de Repositório**:
   - Invoque `/save-project-brain` ou `/obsidian-project` para sincronizar novas rotas, URLs, arquitetura e estado do Git com a nota do projeto no cofre.
3. **Tarefas de Longo Prazo**:
   - Caso surjam impedimentos ou débitos técnicos duráveis, utilize `/obsidian-task` para registrar a pendência no quadro geral do Second Brain.

---

## 7. Indexação, Tags e Busca no Obsidian

Para garantir que o cofre do Obsidian localize rapidamente qualquer daily ou projeto:

### A) Frontmatter Obrigatório em Todas as Dailies
```yaml
---
tags:
  - project
  - project/<slug-do-projeto>
  - daily
  - daily/<ano>
date: YYYY-MM-DD
sequence: <N>
project: <Nome do Projeto>
---
```

### B) Tags Recomendadas no `Index.md`
```yaml
---
tags:
  - project
  - project/<slug-do-projeto>
  - daily-index
date_created: YYYY-MM-DD
project: <Nome do Projeto>
---
```

### C) Facilidades de Busca no Obsidian
- **Busca por Projeto**: `tag:#project/<slug-do-projeto>` retorna todas as dailies e o índice do projeto.
- **Busca por Daily Específica**: `file:"1 - Daily"` ou `tag:#daily`.
- **Busca por Índices**: `tag:#daily-index`.
- **Compatibilidade Dataview**: O frontmatter padronizado permite que queries Dataview no Obsidian agrupem facilmente o histórico de dailies por projeto.

---

## 8. Guia Operacional: Como Ler, Escrever e Editar no Linux

Para manipular os arquivos no Linux (nativo ou WSL), siga rigorosamente os padrões de terminal e ferramentas nativas:

### A) Como Ler (Reading)
- **Ferramenta do Agente**: `view_file` com caminho absoluto entre aspas.
- **Via Shell**:
  ```bash
  DIR="${DAILIES_DIR}/MeuProjeto"
  cat "$DIR/Index.md"
  cat "$DIR/Dailies/1 - Daily-2026-08-17.md"
  ```

### B) Como Escrever / Criar (Writing / Creating)
- **Ferramenta do Agente**: `write_to_file` com caminho absoluto.
- **Via Shell**: Heredoc seguro com aspas simples para proteger variáveis:
  ```bash
  cat <<'EOF' > "$DIR/Dailies/1 - Daily-2026-08-17.md"
  ...
  EOF
  ```

### C) Como Editar / Modificar (Editing / Modifying)
- **Ferramenta do Agente**: `replace_file_content` para substituição de blocos específicos.
- **Adicionar Linha ao `Index.md` (Append na Tabela)**:
  ```bash
  cat <<'EOF' >> "$DIR/Index.md"
  | 2 | [[2 - Daily - 2026-08-18]] | 2026-08-18 | Implementado fluxo de recuperacao de senha |
  EOF
  ```

### D) Regras Operacionais e Proibições
1. **PROIBIDO USO DE PYTHON PARA PERSISTÊNCIA**: Não utilize scripts Python para criar ou editar notas de daily ou índices. Utilize exclusivamente ferramentas nativas (`write_to_file`, `replace_file_content`) ou utilitários shell (`cat`, `sed`, `mkdir`).
2. **Uso Obrigatório de Aspas Duplas**: Todos os caminhos no shell DEVEM estar entre aspas duplas (`"$DAILIES_DIR"`).
3. **Preservação Incremental**: Nunca sobrescreva notas existentes sem ler seu conteúdo prévio.

---

## 9. Fluxo de Execução em 6 Etapas

### Etapa 1: Resolução de Variáveis e Nome do Projeto
- Resolva `$DAILIES_DIR` e o nome canônico do projeto.

### Etapa 2: Bootstrapping do Projeto (Se Inexistente)
- Se `"$DAILIES_DIR/<Nome do Projeto>"` não existir, crie as pastas `Dailies/` e `Notes/`, instancie o `Index.md` e as notas de apoio (`IPS.md`, `Users.md`, `Links.md`, `Accounts.md`, `TODO.md`).

### Etapa 3: Determinação da Sequência e Daily Anterior
- Liste as dailies em `"$DAILIES_DIR/<Nome do Projeto>/Dailies/"`.
- Calcule o número sequencial `N` e obtenha o link da daily anterior `[[<N-1> - Daily - <Data>]]` (ou `Nenhuma`).

### Etapa 4: Coleta de Atividades e Contexto Técnico
- Inspecione alterações recentes no repositório (`rtk git log -n 5`, `rtk git diff`) e/ou utilize as informações fornecidas no prompt para extrair tanto as entregas simples quanto as decisões técnicas e motivos.

### Etapa 5: Gravação da Daily Sequencial
- Crie ou atualize o arquivo `"$DAILIES_DIR/<Nome do Projeto>/Dailies/<N> - Daily - <YYYY-MM-DD>.md"` preenchendo as duas camadas (Simples + Técnica).
- Atualize a tabela de histórico no `Index.md`.

### Etapa 6: Sincronização com Second Brain (Se Aplicável)
- Se houver decisões arquiteturais duráveis, invoque `/second-brain` (`/obsidian-decide`, `/obsidian-project` ou `/save-project-brain`) para registrar no cofre central do Obsidian.

---

## 10. Como Invocar

No terminal ou chat:
```text
/project-daily MeuProjeto
```
ou em linguagem natural:
```text
Crie a daily de hoje para o projeto MeuProjeto detalhando o que foi feito de forma simples e técnica.
```
