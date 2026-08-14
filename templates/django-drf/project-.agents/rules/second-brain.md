---
trigger: always_on
---

# Regras de Integração com o Obsidian Second Brain

Esta regra ensina como acessar, ler, buscar e escrever notas no cofre do Obsidian Second Brain usando RTK e a skill `/second-brain`.

---

## 1. Finalidade e Momento de Acesso ao Vault

Acesse o Vault nas seguintes situações:
- **Consulta de Contexto e ADRs**: Antes de propor decisões de arquitetura ou novos módulos — verificar decisões históricas.
- **Mapeamento de Projeto**: Ao iniciar trabalho num repositório — carregar contexto de negócio da nota mestre.
- **Persistência de Sessão**: Ao finalizar sessão com marcos significativos, refatorações ou bugs complexos resolvidos.

---

## 2. Resolução do Vault Root (Obrigatório antes de qualquer operação)

### A. Proibição de Varredura no Disco
NUNCA execute `find`, `ls` ou pesquisas genéricas pelo sistema de arquivos para localizar o cofre.

### B. Resolução por Variável de Ambiente
```bash
# Resolver o caminho exato do cofre — a ordem de prioridade:
VAULT="$OBSIDIAN_VAULT_PATH"          # Primeira opção
VAULT="${VAULT:-$SECOND_BRAIN_DIR}"   # Fallback 1
VAULT="${VAULT:-$OBSIDIAN_VAULT_DIR}" # Fallback 2

# Se nenhuma variável estiver definida, PARE e pergunte ao usuário.
```

| Variável | Descrição |
|---|---|
| `$OBSIDIAN_VAULT_PATH` / `$SECOND_BRAIN_DIR` | Raiz do cofre central do Obsidian |
| `$AGENT_SKILLS_DIR` | Raiz do repositório hub de skills |

### C. Primeiro Contato com o Vault
Na primeira operação de cada sessão, leia `_CLAUDE.md` na raiz do cofre:
```bash
rtk read "$VAULT/_CLAUDE.md"
```
Esse arquivo contém convenções, schemas de frontmatter e mapa de pastas do usuário.

---

## 3. Operações com RTK — Leitura e Escrita no Vault

### A. Leitura e Busca (Search-Before-Create)

Sempre busque ANTES de criar uma nota, para evitar duplicatas:

```bash
# Buscar notas por conteúdo (grep otimizado, agrupado por arquivo)
rtk grep "termo de busca" "$VAULT"

# Buscar notas por nome de arquivo
rtk find "*.md" "$VAULT" | rtk pipe

# Ler uma nota específica (sem linhas em branco e comentários redundantes)
rtk read "$VAULT/wiki/projects/Meu Projeto.md"

# Listar estrutura de pastas do cofre
rtk tree "$VAULT"

# Ler frontmatter/schema de um JSON
rtk json "$VAULT/algum-arquivo.json" --keys-only
```

### B. Escrita de Notas

Para escrever no vault, use a ferramenta `write_to_file` ou `replace_file_content` com o caminho resolvido. Toda nota DEVE seguir as regras AI-First (seção 5).

```bash
# Verificar se a nota já existe antes de criar
rtk grep "Meu Projeto" "$VAULT/wiki/projects/"

# Após escrever, verificar que o arquivo foi criado
rtk read "$VAULT/wiki/projects/2026-08-14 - Nova Nota.md"
```

### C. Verificação pós-escrita

```bash
# Confirmar que a nota existe e está bem formada
rtk read "$VAULT/caminho/da/nota.md"

# Verificar links internos (se disponível)
rtk grep "\\[\\[Nome Da Nota\\]\\]" "$VAULT"
```

---

## 4. Delegação de Intenções via `/second-brain`

Para operações de alto nível, **invoque a skill `/second-brain`** — ela é o roteador inteligente que classifica sua intenção e executa o comando ideal com menor custo de tokens.

### A. Leitura e Busca
| Intenção | Comando/Skill |
|---|---|
| Buscar nota, conceito, pessoa | `/obsidian-find <termo>` |
| Carregar contexto do projeto | `/obsidian-project [nome]` |
| Carregar identidade e estado | `/obsidian-world` |
| Criar/atualizar nota diária | `/obsidian-daily` |

### B. Escrita e Persistência
| Intenção | Comando/Skill |
|---|---|
| Salvar resumo da sessão | `/obsidian-save` |
| Registrar decisão de arquitetura | `/obsidian-decide [--formal]` |
| Sincronizar repo com o vault | `/save-project-brain` |
| Capturar ideia rápida | `/obsidian-capture <texto>` |
| Registrar sessão de dev | `/obsidian-log` |
| Adicionar tarefa ao kanban | `/obsidian-task [descrição]` |

### C. Pesquisa e Raciocínio
| Intenção | Comando/Skill |
|---|---|
| Pesquisa web com citações | `/research <tópico>` |
| Pesquisa vault-first + web | `/research-deep <tópico>` |
| Pesquisa restrita ao vault | `/notebooklm <tópico>` |
| Brainstorm socrático | `/obsidian-brainstorm` |
| Crítica da ideia (red-team) | `/obsidian-challenge` |

### D. Manutenção do Cofre
| Intenção | Comando/Skill |
|---|---|
| Saúde do vault (links, contradições) | `/obsidian-health` |
| Reconciliar contradições | `/obsidian-reconcile` |
| Mapear arquitetura do repo | `/obsidian-architect` |

**Na dúvida sobre qual comando usar, invoque `/second-brain` com a intenção em linguagem natural** — o roteador resolve automaticamente.

---

## 5. Revisão Pós-Persistência e Padrão de Idioma

### A. Check de Cobertura de Salvamento
Ao concluir uma ação de persistência ou finalizar uma sessão no Vault, o agente DEVE fazer uma varredura para garantir que salvou e atualizou todos os artefatos necessários:
- **`logs` / `dev-logs`**: Registros de dev log da sessão com detalhes do trabalho executado.
- **`index` / `index.md`**: Novos índices atualizados refletindo notas e conceitos recém-criados.
- **`projects` / Nota do Projeto**: Nota mestre do projeto atualizada com marcos atingidos, novas ADRs ou mudanças de estado.

### B. Padrão Obrigatório de Idioma no Pensamento (Thinking Process)
- **Pensamento Interno estritamente em Inglês**: Todo o raciocínio interno (`<thought>`) do agente DEVE ser conduzido exclusivamente em **Inglês** (`English`). Essa diretriz é inegociável para prevenir desvios de contexto, alucinações de regras e desalinhamento de instruções (*instruction drift*).


---

## 6. Regra de Limpeza de Memória (Zero Ruído)

| Salvar | NUNCA Salvar |
|---|---|
| Decisões de arquitetura | Logs brutos de terminal |
| Contratos de API | Correções triviais de sintaxe |
| Causa raiz de bugs complexos | Arquivos temporários |
| Marcos do projeto | Código inacabado ou experimental |
| Pessoas e interações relevantes | Saída de testes que passaram |
