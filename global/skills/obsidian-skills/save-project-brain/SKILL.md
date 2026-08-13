---
name: save-project-brain
description: >
  Sincronização exaustiva do repositório atual com o Obsidian Second Brain.
  Executa varredura profunda linha por linha via RTK (rtk git status, rtk git diff, rtk git log, rtk find, rtk grep, rtk read),
  classifica alterações no modelo OKM (Open Knowledge Metabolism), registra fatos bi-temporais e atualiza o cofre
  usando o padrão AI-First (_CLAUDE.md, /obsidian-project, /obsidian-architect com sentinelas, /obsidian-decide, /obsidian-task e /obsidian-health).
metadata:
  category: meta
---

# Save Project Brain (Sincronização Total de Projeto via Git e RTK)

Esta habilidade executa o escaneamento exaustivo do repositório ativo, inspecionando o código-fonte linha por linha e o estado do Git através do **RTK (Rust Token Killer)**. Em seguida, sincroniza todas as descobertas com o **Obsidian Second Brain**, garantindo conformidade total com o padrão **OKM (Open Knowledge Metabolism)** e a regra **AI-First Vault Rule**.

---

## Directivas Obrigatórias de Execução

### 1. Resolução de Contexto do Cofre e Repositório
- **Caminho do Cofre**: Resolva o caminho raiz do cofre Obsidian a partir da variável de ambiente `$OBSIDIAN_VAULT_PATH` ou do diretório atual.
- **Manual do Cofre**: Leia o arquivo `_CLAUDE.md` / `AGENTS.md` / `_GEMINI.md` na raiz do cofre (se existir) antes de realizar escritas para respeitar a estrutura de pastas e regras específicas do usuário.
- **Caminho do Projeto**: Identifique o repositório Git ativo e o nome mestre do projeto.

### 2. Inspeção Exaustiva de Código e Git via RTK (Mandatório)
Todas as operações de terminal **devem utilizar o prefixo `rtk`** para compressão eficiente de contexto:

1. **Estado de Versionamento**:
   - Executar `rtk git status` para listar arquivos modificados, staged, novos (*untracked*) e removidos.
   - Executar `rtk git diff` para extrair as alterações compactas com assinaturas de funções, tipos e rotas alteradas.
   - Executar `rtk git log -n 5` para capturar a intenção dos commits recentes.

2. **Exploração e Inspeção Linha por Linha**:
   - Executar `rtk find` para obter a árvore de diretórios e a estrutura de módulos do projeto.
   - Para cada arquivo modificado ou em varredura completa de arquitetura, executar `rtk read <file>` para inspecionar o código linha por linha, capturando assinaturas de métodos, modelos de dados, schemas de banco de dados, endpoints de API e dependências.
   - Usar `rtk grep "<pattern>"` para buscar padrões específicos ou declarações críticas no código-fonte.

---

## Fluxo de Sincronização em 5 Etapas

### Etapa 1: Resolução de Contexto e Mapeamento
Identifique o hub do projeto no cofre. A pasta de projetos é resolvida conforme `references/folder-map.md` (padrão `wiki/projects/<nome>/` ou `Projects/<nome>/`). Se a nota mestre do projeto não existir, execute a lógica do `/obsidian-project` para criá-la.

### Etapa 2: Análise Semântica e Metabolismo OKM
Categorize as mudanças encontradas na inspeção RTK:
- **Alterações de Arquitetura**: Mudanças em schemas de banco de dados, arquivos de configuração (`pyproject.toml`, `package.json`), dependências ou camadas de serviço.
- **Novas Funcionalidades**: Criação de novas rotas de API, módulos, classes ou interfaces.
- **Refatorações e Correções**: Ajustes de lógica, melhorias de desempenho e correções de testes.
- **Decisões Técnicas**: Opções de design e refatorações relevantes.

**Regra Bi-temporal OKM**: Quando um fato ou estado do projeto mudar (ex: versão de framework, status de módulo), NUNCA sobrescreva o histórico. Adicione ao array `timeline:` no frontmatter:
```yaml
timeline:
  - fact: "Banco de dados SQLite"
    from: 2024-01-01
    until: 2026-08-13
    learned: 2026-08-13
    source: "[[2026-08-13 - Migração PostgreSQL]]"
  - fact: "Banco de dados PostgreSQL"
    from: 2026-08-13
    until: present
    learned: 2026-08-13
    source: "[[2026-08-13 - Migração PostgreSQL]]"
```

### Etapa 3: Sincronização no Cofre Obsidian (AI-First & Obsidian Core)

1. **Nota Mestre do Projeto (`wiki/projects/<nome>/index.md` ou `Projects/<nome>/index.md`)**:
   - Atualize a seção de estado atual, metas e atividades recentes com links `[[wikilinks]]`.

2. **Documentação Arquitetural (`/obsidian-architect` com Sentinelas)**:
   - Em `<pasta do projeto>/Architecture/`, crie ou atualize as notas:
     - `Architecture - Overview.md` (`type: architecture-overview`): Visão geral do repositório, módulos e diagrama Mermaid da arquitetura.
     - `Architecture - <Modulo>.md` (`type: architecture-module`): Para cada módulo `core` inspecionado via `rtk read`.
   - **Escrita Protegida por Sentinelas**: Todo conteúdo gerado por máquina DEVE ser delimitado por:
     ```markdown
     <!-- @generated:start -->
     ...conteúdo sintetizado...
     <!-- @generated:end -->
     ```
     Conteúdo fora das sentinelas ou em blocos `<!-- @user:start -->` NUNCA deve ser alterado em atualizações futuras.

3. **Registro de Decisões de Arquitetura (ADRs - `/obsidian-decide`)**:
   - Registre decisões técnicas relevantes encontradas nos commits/diffs como registros ADR em `Architecture - Key decisions.md` ou notas individuais de decisão.

4. **Quadro Kanban & Tarefas (`/obsidian-task` / `/obsidian-board`)**:
   - Mova tarefas marcadas como concluídas no código para a coluna `## ✅ Done` do Kanban do projeto.
   - Adicione novos itens de TODO/FIXME encontrados via `rtk grep` como tarefas no backlog.

5. **Logs de Operação**:
   - Registre a operação no log diário (`Logs/YYYY-MM-DD.md` se existir, ou `log.md` na raiz do cofre) com o timestamp da sincronização.
   - Atualize os dados de estatísticas em `index.md`.

### Etapa 4: Reconciliação e Auditoria pós-Sincronização
Após a gravação de todas as notas:
- Execute a lógica de `/obsidian-reconcile` para identificar e resolver contradições entre a nova documentação e notas antigas.
- Execute a auditoria do `/obsidian-health` para garantir zero links quebrados, zero notas órfãs e conformidade total com a política de recência OKM.

---

## Regra AI-First Incorporada (Obrigatória)

Cada nota criada ou atualizada por esta skill DEVE seguir as diretrizes AI-First:

1. **Contexto Autocontido**: A nota deve ser compreensível isoladamente por uma IA futura.
2. **Preâmbulo `## For future Claude`**: Resumo de 2 a 3 frases no topo da nota explicitando o que ela contém, por que foi salva e ressalvas de recência.
3. **Frontmatter Rico**:
   ```yaml
   ---
   type: project-hub # ou architecture-overview, architecture-module, adr, dev-log
   date: YYYY-MM-DD
   tags:
     - project
     - ai-first
   ai-first: true
   scanned-commit: "hash-do-commit"
   ---
   ```
4. **Marcadores de Recência por Afirmação**: Toda afirmação técnica externa ou estado deve conter marcador `(as of YYYY-MM-DD, commit: hash)`.
5. **Links Mandatórios**: Toda pessoa, projeto, tecnologia ou conceito mencionado deve usar `[[wikilinks]]`.
6. **Anti-Fabricação**: Documente estritamente o que foi verificado via RTK no código-fonte. Raciocínios ou intenções inferidas devem ser marcadas com `confidence: speculation`.

---

## Como Invocar

No chat do Antigravity estando no diretório do seu projeto:
```text
/save-project-brain
```
ou solicitando em linguagem natural:
```text
Sincronize exaustivamente as alterações e o código do meu projeto no Second Brain.
```
