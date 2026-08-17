---
name: save-project-brain
description: >
  Sincronizacao exaustiva do repositorio atual com o Obsidian Second Brain no padrao Analyze-Before-Save.
  Executa varredura profunda de ponta a ponta via RTK (projeto completo, todas as URLs e rotas, estado e diff do Git),
  elabora um plano de sincronizacao previo e atualiza o cofre utilizando estritamente as skills oficiais do Obsidian
  (_CLAUDE.md, /obsidian-project, /obsidian-architect com sentinelas, /obsidian-decide, /obsidian-task, /obsidian-reconcile e /obsidian-health).
metadata:
  category: meta
---

# Save Project Brain (Sincronizacao de Projeto no Padrao Analyze-Before-Save)

Esta habilidade executa o escaneamento exaustivo de ponta a ponta do repositorio ativo utilizando o **RTK (Rust Token Killer)**. Antes de qualquer persistencia no **Obsidian Second Brain**, o agente analisa a totalidade do projeto, mapeia todas as URLs e rotas de API, examina as alteracoes do Git e elabora um plano de sincronizacao detalhado. A gravacao no cofre e conduzida estritamente atraves das **skills oficiais do Obsidian**, em total conformidade com o padrao **OKM (Open Knowledge Metabolism)** e a regra **AI-First**.

---

## Diretivas Obrigatorias de Execucao

### 1. Resolucao de Contexto do Cofre e Repositorio
- **Caminho do Cofre**: Resolva a raiz do cofre atraves de `$OBSIDIAN_VAULT_PATH` ou `$OBSIDIAN_VAULT_DIR` / `$SECOND_BRAIN_DIR`. No ambiente Linux, trate caminhos com espacos utilizando aspas duplas (exemplo: `"$OBSIDIAN_VAULT_PATH"`).
- **Manual do Cofre**: Leia o arquivo `_CLAUDE.md` / `AGENTS.md` / `_GEMINI.md` na raiz do cofre antes de realizar escritas para carregar a taxonomia, mapa de pastas e convencoes do usuario.
- **Identificacao do Projeto**: Identifique o repositorio Git ativo, a branch corrente e o nome canonico do projeto.

### 2. Uso Obrigatorio do RTK
Todas as operacoes de terminal no repositorio de codigo **devem utilizar o prefixo `rtk`** para compressao eficiente de contexto:
- Consultas de arquivos e modulos: `rtk find`
- Inspecao de conteudo linha por linha: `rtk read <caminho>`
- Busca textual e de assinaturas: `rtk grep "<padrao>"`
- Estado do versionamento: `rtk git status`, `rtk git diff`, `rtk git log -n 5`

---

## Fluxo em 4 Fases: Analyze-Before-Save

```text
+-----------------------+     +-----------------------+     +-----------------------+     +-----------------------+
|  Fase 1: Analise de   | --> |  Fase 2: Analise de   | --> |  Fase 3: Plano de     | --> |  Fase 4: Gravacao via |
|  Ponta a Ponta (Repo) |     |  Git & Trabalho Feito |     |  Sincronizacao Previo |     |  Skills do Obsidian   |
|                       |     |                       |     |                       |     |                       |
|  - Estrutura completa |     |  - rtk git status     |     |  - Mapeamento notas   |     |  - /obsidian-project  |
|  - Configs/Dep.       |     |  - rtk git diff       |     |  - Mapeamento ADRs    |     |  - /obsidian-architect|
|  - TODAS as URLs      |     |  - rtk git log        |     |  - Mapeamento Kanban  |     |  - /obsidian-decide   |
|  - Models e Services  |     |                       |     |  - Timeline OKM       |     |  - /obsidian-task     |
+-----------------------+     +-----------------------+     +-----------------------+     +-----------------------+
```

---

### Fase 1: Analise de Ponta a Ponta do Projeto (RTK Exaustivo)

Antes de planejar ou escrever qualquer nota, execute uma varredura completa do repositorio:

1. **Estrutura Geral e Modulos**:
   - Execute `rtk find` para listar a arvore completa de arquivos e identificar todos os apps, pacotes e camadas da aplicacao.
   - Execute `rtk read` nos arquivos de configuracao central (`pyproject.toml`, `package.json`, `settings.py`, `docker-compose.yml`, `.env.example`) para mapear stacks, versoes e servicos externos.

2. **Mapeamento Exaustivo de TODAS as URLs e Rotas**:
   - Execute `rtk grep` e `rtk read` para extrair todas as declaracoes de rotas, endpoints e schemas de API do repositorio:
     - Arquivos de URLs e roteadores: `urls.py`, `nested_urls.py`, `routers.py`, `routes/`, `endpoints/`, `api/`.
     - Decoradores e schemas OpenAPI/Swagger: `schemas.py`, `@extend_schema`, `@extend_schema_view`, decorators de rota.
     - Identifique e tabule para cada endpoint:
       - Metodo HTTP (GET, POST, PUT, PATCH, DELETE).
       - Path / URL relativa (ex: `/api/v1/users/`, `/api/v1/orders/{id}/pay/`).
       - View, ViewSet ou Handler responsavel.
       - Politica de autenticacao e permissoes associadas.
       - Parametros principais e payload de entrada/saida.

3. **Modelos de Dados e Persistencia**:
   - Execute `rtk grep "class " -- "models.py"` e `rtk read` nos arquivos de modelos para mapear entidades, relacionamentos (`ForeignKey`, `ManyToManyField`), restricoes de integridade (`UniqueConstraint`, `CheckConstraint`) e custom managers/querysets.

4. **Regras de Negocio e Camada de Servico**:
   - Inspecione `services.py`, handlers de dominio e rotinas de integracao externa para capturar a logica de negocio, fluxos transacionais e invariantes.

---

### Fase 2: Analise do Trabalho Realizado (Git & Delta)

Apos entender a totalidade do projeto, analise precisamente o que mudou no ciclo de desenvolvimento recente:

1. **Estado de Modificacao**:
   - Execute `rtk git status` para classificar arquivos modificados, staged, novos (untracked) e deletados.

2. **Diferencas de Codigo**:
   - Execute `rtk git diff` para capturar as alteracoes exatas, novas assinaturas de metodos, novos campos de models, mudancas em validadores de serializers e novos testes.

3. **Intencao e Historico Recente**:
   - Execute `rtk git log -n 5` para resgatar as mensagens de commit recentes e compreender a intencao declarada do desenvolvedor.

---

### Fase 3: Elaboracao do Plano de Sincronizacao (Plan Before Save)

Com base nas analises das Fases 1 e 2, estruture e apresente o **Plano de Sincronizacao** detalhando exatamente o que sera gravado no cofre:

```markdown
### Plano de Sincronizacao com o Second Brain

1. **Hub do Projeto**:
   - Nota alvo: `wiki/projects/<nome-do-projeto>/index.md` (ou `Projects/<nome>/index.md`)
   - Acao: Atualizar status atual, resumo do progresso e links para novas notas.

2. **Documentacao Arquitetural e URLs**:
   - `Architecture - Overview.md`: Atualizar visao geral e mapa de modulos.
   - `Architecture - Modulos`: Atualizar ou criar notas dos modulos afetados com o catalogo de URLs mapeadas.
   - Sentinelas: Aplicar blocos de protecao `<!-- @generated:start -->` e `<!-- @generated:end -->`.

3. **Registro de Decisoes (ADRs)**:
   - Identificar decisoes de design ou arquitetura presentes nos diffs e registrar via `/obsidian-decide`.

4. **Kanban e Tarefas**:
   - Mover itens concluidos para a secao `[Done]`.
   - Registrar novos itens de TODO/FIXME detectados como pendencias via `/obsidian-task`.

5. **Rastreamento Bi-temporal OKM**:
   - Inserir entradas no array `timeline:` do frontmatter para mudancas de estado ou tecnologias.
```

---

### Fase 4: Execucao da Sincronizacao via Skills Oficiais do Obsidian

Execute a sincronizacao invocando estritamente as skills oficiais do ecossistema Obsidian:

1. **Hub do Projeto (`/obsidian-project [nome]`)**:
   - Crie ou atualize a nota mestre do projeto registrando descricao, stack consolidada, endpoints principais e links `[[wikilinks]]`.

2. **Documentacao de Arquitetura (`/obsidian-architect`)**:
   - Em `<pasta-do-projeto>/Architecture/`:
     - `Architecture - Overview.md` (`type: architecture-overview`): Diagrama Mermaid, topologia de servicos e arvore de modulos.
     - `Architecture - <Modulo>.md` (`type: architecture-module`): Documentacao de cada modulo, contendo a lista completa de URLs/endpoints correspondentes, regras de negocio e modelos.
   - **Sentinelas de Protecao**:
     ```markdown
     <!-- @generated:start -->
     ...conteudo sintetizado automaticamente...
     <!-- @generated:end -->
     ```
     Blocos fora das sentinelas ou delimitados por `<!-- @user:start -->` NUNCA sao sobrescritos.

3. **Decisoes de Arquitetura (`/obsidian-decide`)**:
   - Registre as escolhas tecnicas relevantes identificadas na analise de diffs como registros estruturados de decisao.

4. **Quadro de Tarefas (`/obsidian-task` e `/obsidian-board`)**:
   - Sincronize o estado das tarefas no Kanban do projeto:
     - Itens concluidos no codigo vao para `## [Done]`.
     - Novos itens de debito tecnico ou proximos passos vao para `## [Backlog]` ou `## [Todo]`.

5. **Logs de Operacao (`/obsidian-log`)**:
   - Registre a sessao de trabalho no log diario do cofre com data, commit escaneado e sumario executivo.

6. **Auditoria e Reconciliacao (`/obsidian-reconcile` e `/obsidian-health`)**:
   - Execute `/obsidian-reconcile` para identificar e sanar contradicoes entre notas novas e historicas.
   - Execute `/obsidian-health` para validar que nao ha links quebrados, tags invalidas ou violacoes de esquema AI-First.

---

## Padrao AI-First Mandatorio

Toda nota criada ou modificada DEVE conter:

1. **Preambulo Obrigatorio**:
   ```markdown
   ## For future Claude
   Resumo conciso de 2 a 3 frases explicitando o conteudo da nota, contexto de criacao e marcadores de recencia.
   ```

2. **Frontmatter Estruturado**:
   ```yaml
   ---
   type: project-hub # architecture-overview, architecture-module, adr, dev-log
   date: YYYY-MM-DD
   tags:
     - project
     - ai-first
   ai-first: true
   scanned-commit: "hash-do-commit"
   ---
   ```

3. **Marcadores de Recencia**: Afirmacoes tecnicas devem conter `(as of YYYY-MM-DD, commit: <hash>)`.
4. **Links Internos**: Todo conceito, tecnologia, projeto ou modulo deve ser referenciado via `[[wikilinks]]`.
5. **Anti-Fabricacao**: Documente apenas o que foi comprovado via RTK no codigo-fonte. Hipoteses devem ser marcadas com `confidence: speculation`.

---

## Invocacao

No terminal ou chat do agente:
```text
/save-project-brain
```
ou em linguagem natural:
```text
Analise este repositorio de ponta a ponta com RTK, mapeie todas as URLs e o Git, e salve a sincronizacao no Second Brain.
```
