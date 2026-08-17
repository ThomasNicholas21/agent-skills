---
name: project-daily
description: >
  Gera e gerencia notas de daily diárias e notas de apoio (IPS, Users, Links, Accounts, TODO) por projeto
  formatadas para leitura humana no diretório configurado em $DAILIES_DIR. Constrói histórico sequencial,
  sucinto e direto, sem preâmbulos de IA e sem persistência no Vault. Ensina como ler, escrever e editar no Linux.
metadata:
  category: workflow
---

# Project Daily (Dailies e Notas de Apoio por Projeto em DAILIES_DIR)

Esta habilidade cria e atualiza notas diárias (**Dailies**) e cadernos de apoio (**Notes**) estruturados por projeto, formatados exclusivamente para **leitura humana direta, sucinta e sequencial**.

Todos os arquivos gerados por esta skill são armazenados no diretório do sistema configurado na variável de ambiente **`$DAILIES_DIR`**, operando de forma independente do cofre do Obsidian.

---

## 1. Setup e Resolução de Diretórios no Linux

Ao invocar `/project-daily`, o agente deve resolver:

1. **Diretório Raiz de Dailies (`$DAILIES_DIR`)**:
   - Ler a variável `$DAILIES_DIR` do ambiente.
   - Se a variável não estiver definida, avisar o usuário para configurá-la em seu `.env` (exemplo: `DAILIES_DIR="$HOME/dailies"` ou `DAILIES_DIR="/mnt/c/Users/thoma/Meus Documentos/Dailies"`).
   - **Regra de Caminho no Linux**: Sempre utilize aspas duplas ao referenciar o caminho para suportar diretórios com espaços (`"$DAILIES_DIR"`).

2. **Identificação do Nome do Projeto**:
   - Se o usuário informar o argumento (exemplo: `/project-daily MeuProjeto`), utilize o nome fornecido.
   - Se não informado, infira o nome canônico a partir do diretório do repositório Git ativo ou do contexto da conversa.

---

## 2. Estrutura de Pastas e Arquivos Gerada

A skill garante a existência da seguinte estrutura dentro de `$DAILIES_DIR`:

```text
$DAILIES_DIR/<Nome do Projeto>/
+-- Dailies/
|   +-- YYYY-MM-DD.md
+-- Notes/
    +-- IPS.md
    +-- Users.md
    +-- Links.md
    +-- Accounts.md
    +-- TODO.md
```

---

## 3. Guia Operacional: Como Ler, Escrever e Editar no Linux

Para manipular as dailies e notas do projeto no Linux (nativo ou WSL), siga rigorosamente os seguintes padrões de operação:

### A) Como Ler (Reading)

1. **Leitura Completa ou Inspeção Estruturada**:
   - **Ferramenta Nativa do Agente**: Utilize `view_file` com o caminho absoluto entre aspas.
   - **Via Terminal Shell**:
     ```bash
     DIR="${DAILIES_DIR}/MeuProjeto"
     cat "$DIR/Dailies/2026-08-17.md"
     cat "$DIR/Notes/TODO.md"
     ```

2. **Leitura Parcial de Cabeçalhos e Finais**:
     ```bash
     head -n 15 "$DIR/Dailies/2026-08-17.md"
     tail -n 20 "$DIR/Notes/TODO.md"
     ```

3. **Descoberta e Ordenação da Daily Anterior**:
   - Para localizar a daily mais recente anterior a hoje:
     ```bash
     ls -1 "$DIR/Dailies/" | grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}\.md$" | sort | tail -n 1
     ```

4. **Busca Textual em Notas**:
     ```bash
     grep -rn "192.168" "$DIR/Notes/IPS.md"
     grep -rn "\[ \]" "$DIR/Notes/TODO.md"
     ```

---

### B) Como Escrever / Criar (Writing / Creating)

1. **Criação da Daily do Dia**:
   - **Ferramenta Nativa do Agente**: Utilize `write_to_file` com caminho absoluto `"$DAILIES_DIR/<Nome do Projeto>/Dailies/YYYY-MM-DD.md"`.
   - **Via Terminal Shell (Heredoc Seguro)**:
     ```bash
     cat <<'EOF' > "$DIR/Dailies/2026-08-17.md"
     # Daily - 2026-08-17

     **Daily anterior:** [[2026-08-16]]

     **O que fiz:**
     - Criado pipeline de CI no GitHub Actions
     - Implementado middleware de autenticacao JWT

     **O que vou fazer:**
     - Escrever testes de integracao para o servico de pagamento
     - Mapear documentacao OpenAPI dos endpoints

     **Pendencias:**
     - Nenhuma
     EOF
     ```

2. **Inicialização das Notas de Apoio (Se Inexistentes)**:
   - Copie ou renderize a partir dos templates base localizados em `templates/Projects/`:
     - `Notes/IPS.md` a partir de `notes.base.md` com cabeçalho `# IPS - <Nome do Projeto>`
     - `Notes/Users.md` a partir de `notes.base.md` com cabeçalho `# Users - <Nome do Projeto>`
     - `Notes/Links.md` a partir de `notes.base.md` com cabeçalho `# Links - <Nome do Projeto>`
     - `Notes/Accounts.md` a partir de `notes.base.md` com cabeçalho `# Accounts - <Nome do Projeto>`
     - `Notes/TODO.md` a partir de `todo.base.md` com cabeçalho `# TODO - <Nome do Projeto>`

---

### C) Como Editar / Modificar (Editing / Modifying)

1. **Edição Estruturada de Blocos (Recomendado)**:
   - **Ferramenta Nativa do Agente**: Utilize `replace_file_content` ou `multi_replace_file_content` especificando com precisão `StartLine`, `EndLine`, `TargetContent` e `ReplacementContent`.

2. **Acréscimo de Linhas e Itens (Append Seguro)**:
   - Para adicionar novas linhas no final de uma nota sem sobrescrever o conteúdo:
     ```bash
     cat <<'EOF' >> "$DIR/Notes/Links.md"
     | Dashboard Grafana | https://grafana.exemplo.com | Metricas de producao |
     EOF
     ```

3. **Movimentação e Atualização de Tarefas no `TODO.md`**:
   - Ao concluir uma tarefa em andamento:
     1. Localize o item `- [ ] Descricao da tarefa` na seção `## [Em Progresso]`.
     2. Mova o item para a seção `## [Concluido]` marcando como `- [x] Descricao da tarefa (YYYY-MM-DD)`.
     3. Promova o próximo item de `## [Backlog]` para `## [Em Progresso]`.
   - Realize essa edição via `replace_file_content` para manter a integridade visual da nota.

4. **Substituições Pontuais via Shell**:
   - Para correções rápidas de texto ou IP:
     ```bash
     sed -i 's/10.0.0.1/10.0.0.2/g' "$DIR/Notes/IPS.md"
     ```

---

### D) Regras Operacionais e Proibições

1. **PROIBIDO USO DE PYTHON PARA PERSISTÊNCIA**:
   - Não utilize scripts Python (`python`, `open()`, `pathlib.Path.write_text()`) para criar ou editar arquivos de daily ou notas.
   - Utilize exclusivamente ferramentas nativas do agente (`write_to_file`, `replace_file_content`) ou utilitários shell padrão (`cat`, `sed`).

2. **Uso Obrigatório de Aspas Duplas**:
   - Todos os caminhos no shell DEVEM estar entre aspas duplas para evitar quebras com espaços no Linux/WSL (`"$DAILIES_DIR"`).

3. **Preservação de Integridade**:
   - Nunca sobrescreva notas de apoio existentes (`IPS.md`, `Users.md`, `Links.md`, `Accounts.md`, `TODO.md`) sem ler seu conteúdo prévio. As atualizações devem ser sempre incrementais.

---

## 4. Fluxo de Execução em 5 Etapas

### Etapa 1: Resolução de Caminhos e Scaffolding
- Verifique se os diretórios `"$DAILIES_DIR/<Nome do Projeto>/Dailies"` e `"$DAILIES_DIR/<Nome do Projeto>/Notes"` existem. Se não existirem, crie-os imediatamente.

### Etapa 2: Inicialização de Notas de Apoio (Se Inexistentes)
Se os arquivos de notas em `Notes/` ainda não existirem, instancie-os a partir dos templates base:
- `IPS.md`: Baseado em `templates/Projects/notes.base.md` com categoria `IPS`.
- `Users.md`: Baseado em `templates/Projects/notes.base.md` com categoria `Users`.
- `Links.md`: Baseado em `templates/Projects/notes.base.md` com categoria `Links`.
- `Accounts.md`: Baseado em `templates/Projects/notes.base.md` com categoria `Accounts`.
- `TODO.md`: Baseado em `templates/Projects/todo.base.md`.

### Etapa 3: Descoberta da Daily Anterior
- Liste os arquivos existentes em `"$DAILIES_DIR/<Nome do Projeto>/Dailies/"`.
- Identifique o arquivo com a data mais recente estritamente anterior à data de hoje (`YYYY-MM-DD.md`).
- Se houver daily anterior (exemplo: `2026-08-16.md`), defina o link como `[[2026-08-16]]` ou `2026-08-16`.
- Se for a primeira daily do projeto, defina como `Nenhuma`.

### Etapa 4: Coleta de Atividades
- Inspecione as alterações recentes no repositório ativo via `rtk git log -n 5` e `rtk git diff` para extrair entregas concluídas, ou utilize as informações fornecidas pelo usuário no prompt.

### Etapa 5: Gravação da Daily de Hoje
- Crie ou atualize o arquivo `"$DAILIES_DIR/<Nome do Projeto>/Dailies/YYYY-MM-DD.md"` utilizando o template `daily.base.md`.
- Aplique rigorosamente as melhores práticas de redação descritas abaixo.

---

## 5. Guia de Melhores Práticas de Escrita e Redação Humana

Para garantir que a daily seja de fácil leitura, rastreabilidade e alto valor para humanos, siga estas diretrizes:

### A) Estrutura Padrão da Daily

```markdown
# Daily - YYYY-MM-DD

**Daily anterior:** [[YYYY-MM-DD]]

**O que fiz:**
- <item conciso 1>
- <item conciso 2>

**O que vou fazer:**
- <item conciso 1>
- <item conciso 2>

**Pendencias:**
- <bloqueio ou impedimento opcional>
```

### B) Padrões de Conteúdo e Gramática

1. **Orientação a Resultados (Sem Rodeios)**:
   - Evite frases genéricas como "trabalhei no backend" ou "estudei o código".
   - Descreva entregas e mudanças concretas: "Implementado validador de CPF no serializer de clientes", "Configurado pool de conexões do PostgreSQL".

2. **Convenção Verbal de Alto Impacto**:
   - **O que fiz**: Utilize verbos no passado/particípio afirmativo:
     - "Criado...", "Implementado...", "Corrigido...", "Refatorado...", "Documentado...", "Configurado...".
   - **O que vou fazer**: Utilize verbos no infinitivo:
     - "Escrever testes unitários para a camada de serviço...", "Configurar rotas no API Gateway...", "Executar migrações em staging...".
   - **Pendencias**: Descreva impedimentos, bloqueios ou dependências externas reais:
     - "Aguardando liberação de credenciais de acesso ao bucket S3 pelo time de DevOps".
     - Se não houver pendências no dia, a seção pode ser omitida ou preenchida com `- Nenhuma`.

3. **Concisão e Sequencialidade**:
   - Cada bullet point deve conter entre 1 e 2 linhas no máximo.
   - Mantenha os tópicos em ordem lógica de prioridade ou execução.

4. **Formato para Humanos (Sem Bloat de IA)**:
   - Não adicione preâmbulos como `## For future Claude`, tags YAML excessivas ou blocos de metadados complexos. O arquivo deve ser legível diretamente em qualquer editor de Markdown.

### C) Padrões de Manutenção das Notas de Apoio (`Notes/`)

1. **IPS.md**:
   - Registrar endereços de IP de infraestrutura, servidores locais, instâncias de banco de dados e containers, associando a porta e o propósito.
2. **Users.md**:
   - Registrar emails de teste, identificadores de papéis (Admin, Operador, Cliente) e responsáveis técnicos, sem nunca expor senhas reais em texto claro.
3. **Links.md**:
   - Centralizar URLs de repositórios, pipelines CI/CD, ambientes de homologação, Swagger/OpenAPI, dashboards de monitoramento e documentações.
4. **Accounts.md**:
   - Mapear identificadores de contas de serviços integrados (AWS Account ID, Stripe Client ID, Sentry Project Key).
5. **TODO.md**:
   - Manter listas atômicas de tarefas distribuídas em `## [Em Progresso]`, `## [Backlog]` e `## [Concluido]`.

---

## 6. Como Invocar

No terminal ou chat:
```text
/project-daily MeuProjeto
```
ou em linguagem natural:
```text
Crie a daily de hoje para o projeto MeuProjeto com o resumo das atividades recentes.
```
