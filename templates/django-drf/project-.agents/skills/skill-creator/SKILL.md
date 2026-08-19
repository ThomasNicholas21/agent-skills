---
name: skill-creator
description: >-
  Guia conciso e determinístico para planejar, desenhar e criar novas Skills, Rules e Workflows no padrão oficial Antigravity.
---

# Criador de Customizações Antigravity
Guia de criação de primitivas Antigravity (**Skills**, **Rules** e **Workflows**) otimizado para leitura e execução por agentes de IA.

## 1. Matriz de Primitivas
| Primitiva | Localização | Acionamento | Propósito |
| :--- | :--- | :--- | :--- |
| **Rule** | `.agents/rules/<name>.md` | `Always On` ou `trigger: glob:` | Estilo de código, restrições e convenções de arquitetura. |
| **Skill** | `.agents/skills/<name>/SKILL.md` | Progressive Disclosure (`description`) | Procedimentos, runbooks, manuais e scripts executáveis. |
| **Workflow** | `.agents/workflows/<name>.md` | Comando explícito (`/nome-do-workflow`) | Sequências determinísticas orquestradas ponta a ponta. |

## 2. Padrão de Criação de Skills
### Estrutura
```text
skills/<skill-name>/
├── SKILL.md          # Obrigatório: Instruções principais + YAML frontmatter
├── scripts/          # Opcional: Scripts executáveis
├── knowledge/        # Opcional: Documentação de referência (Progressive Disclosure)
└── examples/         # Opcional: Exemplos práticos de código
```

### Regras do `SKILL.md`
1. **Frontmatter YAML**: `name` (kebab-case) e `description` (3ª pessoa, indicando o que faz e quando acionar).
2. **Progressive Disclosure**: Mantenha o `SKILL.md` enxuto (< 60 linhas). Conhecimento detalhado fica em `knowledge/` ou `references/`.
3. **Verificação**: Todo procedimento deve terminar com validação empírica (`rtk pytest`, `rtk read`, etc.).

## 3. Padrão de Criação de Rules
```markdown
---
trigger:
  glob: "**/models.py"
---

# Regras: <Domínio>
1. Restrições diretas e imperativas.
2. Convenções arquiteturais sem teoria desnecessária.
```

## 4. Padrão de Criação de Workflows
```markdown
---
name: nome-do-workflow
description: Descrição em 3ª pessoa do workflow.
---

# Workflow: <Nome>

## 1. Analisar
- Inspeção com comandos RTK.

## 2. Debate & Aprovação
- Alinhamento de escopo e gate de aprovação explícita.

## 3. Planejamento & Execução
- Geração de plano atômico e execução no escopo restrito.
```

## 5. Checklist
- [ ] Frontmatter YAML válido.
- [ ] `description` em 3ª pessoa com gatilho claro.
- [ ] Comandos de terminal utilizam RTK (`rtk read`, `rtk grep`, `rtk pytest`).
- [ ] Primitiva salva no diretório correto (`skills/`, `rules/` ou `workflows/`).