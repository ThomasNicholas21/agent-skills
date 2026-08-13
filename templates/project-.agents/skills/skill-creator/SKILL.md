---
name: skill-creator
description: >-
  Guia conciso e determinístico para planejar, desenhar e criar novas Skills, Rules e Workflows no padrão
  oficial Antigravity. Use sempre que for criar ou atualizar customizações do agente.
---

# Antigravity Customization Creator

Guia de criação de primitivas Antigravity (**Skills**, **Rules** e **Workflows**) otimizado para leitura e execução por agentes de IA.

---

## 1. Matriz de Decisão de Primitivas

Escolha a primitiva correta antes de criar o arquivo:

| Primitiva | Localização Exclusiva / Preferencial | Acionamento | Propósito |
| :--- | :--- | :--- | :--- |
| **Rule** | `.agents/rules/<name>.md` ou `templates/project-.agents/rules/` | `Always On` ou `trigger: glob: "<pattern>"` | Estilo de código, restrições de segurança e convenções de arquitetura por tecnologia/arquivo. |
| **Skill** | `.agents/skills/<name>/SKILL.md` ou `~/.gemini/config/skills/<name>/` | Progressive Disclosure (Casamento semântico de `description`) | Runbooks, procedimentos com passos efêmeros e ferramentas executáveis (`scripts/`). |
| **Workflow** | `.agents/workflows/<name>.md` ou `templates/project-.agents/workflows/` | Comando explícito (`/nome-do-workflow`) | Sequências determinísticas de etapas orquestradas ponta a ponta. |

---

## 2. Padrão de Criação de Skills

### Estrutura de Diretórios
```text
skills/<skill-name>/
├── SKILL.md          # Obrigatório: Instruções principais + YAML frontmatter
├── scripts/          # Opcional: Scripts auxiliares executáveis
├── references/       # Opcional: Documentação extensa (Progressive Disclosure)
└── examples/         # Opcional: Exemplos sintáticos ou de payloads
```

### Regras do `SKILL.md`
1. **Frontmatter YAML (Obrigatório)**:
   - `name`: Nome da skill em `kebab-case`.
   - `description`: 3ª pessoa. Descreve **O QUE** faz e **QUANDO** o agente deve ativá-la.
2. **Progressive Disclosure**:
   - Mantenha o `SKILL.md` enxuto (< 100 linhas).
   - Documentação extensa deve ser colocada em `references/` e referenciada via link relativo markdown `[ref](./references/doc.md)`.
3. **Uso de Scripts**:
   - Isole comandos de terminal complexos em arquivos dentro de `scripts/`.
4. **Verificação**:
   - Todo procedimento deve terminar com instruções empíricas de validação (`rtk pytest`, `rtk read`, etc.).

---

## 3. Padrão de Criação de Rules

### Estrutura do Arquivo (`.agents/rules/<name>.md` ou `templates/project-.agents/rules/<name>.md`)
```markdown
---
trigger:
  glob: "**/models.py"  # Gatilho automático por caminho de arquivo
---

# Regras de Desenvolvimento: <Tecnologia / Domínio>

1. Restrições diretas e objetivas (ex: "PROIBIDO X", "OBRIGATÓRIO Y").
2. Exemplos de código antes/depois mostrando a sintaxe aprovada.
```

#### Convenções Específicas de Tecnologias:
- **Django Models**: Separar `models.QuerySet` e `models.Manager` com delegação via `get_queryset()` e declarar `objects = CustomManager()` no modelo.
- **Django REST Framework**: Separar `ViewSet` (HTTP/Permissões) $\rightarrow$ `Serializer` (Validação) $\rightarrow$ `Service Layer` (`services.py`). Nunca reusar o mesmo serializer para leitura e escrita.

---

## 4. Padrão de Criação de Workflows

### Estrutura do Arquivo (`.agents/workflows/<name>.md`)
```markdown
# Workflow: <Nome do Workflow>

Comando de ativação: `/nome-do-workflow`

## Passos

1. **Mapeamento & Inspeção**:
   - `rtk read path/to/file`
2. **Execução Atômica**:
   - Executar alterações incrementais e atômicas.
3. **Validação e Regressão**:
   - `rtk pytest path/to/tests`
```

---

## 5. Checklist de Validação da Customização

Antes de concluir a criação de uma customização, valide:
- [ ] O Frontmatter YAML possui sintaxe válida (sem aspas soltas, recuo correto).
- [ ] A `description` da skill está em 3ª pessoa e especifica a intenção de disparo.
- [ ] Todos os comandos de terminal utilizam o prefixo `rtk` (`rtk read`, `rtk grep`, `rtk pytest`).
- [ ] O documento não duplica conhecimento geral de código (foco exclusivo no workflow do projeto).
- [ ] A primitiva foi colocada na pasta correta (`skills/`, `rules/` ou `workflows/`).
