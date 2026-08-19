---
name: project-daily-analyse
description: >
  Responde perguntas do usuário sobre o que aconteceu nas dailies de um projeto.
  Lê project.md, dailies, cadernos de apoio e gera respostas baseadas no histórico.
metadata:
  category: workflow
---

# Project Daily Analyse

Responde perguntas sobre o que aconteceu num projeto. Lê as dailies, project.md e cadernos de apoio para dar respostas fundamentadas.

---

## Fluxo de Execução

### 1. Resolver diretórios

- Ler `$DAILIES_DIR` do ambiente.
- Nome do projeto: argumento do usuário ou repo Git ativo.
- `DIR="$DAILIES_DIR/<Projeto>"`.

### 2. Coletar evidências

Ler nesta ordem:

1. **`project.md`** — visão geral, tags, tabela de histórico de dailies.
2. **`Dailies/`** — listar e ler as dailies relevantes para a pergunta:
   ```bash
   ls -1 "$DIR/Dailies/" | sort -V
   ```
3. **`Notes/`** — `TODO.md`, `IPS.md`, `Users.md`, `Links.md`, `Accounts.md` conforme necessário.
4. **Git** (se aplicável) — `git log -n 10` e `git status` para cruzar com as dailies.

### 3. Responder a pergunta

Usar as evidências para responder de forma direta. O formato depende do que o usuário perguntou:

- **"O que aconteceu ontem?"** → resumo da daily do dia.
- **"Qual o status do projeto?"** → resumo executivo + TODO.
- **"Que decisões técnicas foram tomadas?"** → extrair do detalhamento técnico das dailies.
- **"O que está pendente?"** → cruzar pendências das dailies + TODO.md.
- **Perguntas específicas** → buscar nos dailies e cadernos relevantes.

---

## Formato do Relatório (quando pedido overview completo)

```markdown
# 📊 Análise: <Projeto>
**Data:** YYYY-MM-DD | **Dailies:** N | **Período:** de YYYY-MM-DD até YYYY-MM-DD

## Resumo
- Marcos alcançados
- Ritmo de entregas

## Decisões Técnicas
- Padrões adotados e porquês
- Impactos (migrações, configs, APIs)

## Backlog (TODO.md)
| Status | Qtd | Observações |
|---|---|---|
| Em Progresso | X | ... |
| Backlog | Y | ... |
| Concluído | Z | ... |

## Saúde das Notas
- Sequência contínua? Gaps?
- project.md e Index.md sincronizados?
- Cadernos de apoio preenchidos?

## Próximos Passos Sugeridos
1. ...
2. ...
```

---

## Regras

1. **Somente leitura** — não alterar nenhum arquivo a menos que o usuário peça explicitamente.
2. **Resposta direta** — responder o que foi perguntado, sem relatório completo quando não pedido.
3. **Caminhos entre aspas duplas** — `"$DAILIES_DIR"`.
4. **Usar `view_file`** para ler os arquivos.

---

## Como Invocar

```text
/project-daily-analyse MeuProjeto
```
ou em linguagem natural:
```text
O que aconteceu no projeto MeuProjeto essa semana?
```
