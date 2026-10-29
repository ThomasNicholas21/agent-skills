---
name: update-agents-workflow
description: >-
  Calibra regras (.agents/rules/), skills e convenções para novos projetos ou projetos existentes.
  Utilize para /update-agents ou /update-agents-workflow.
---

# Workflow de Calibração de Agentes (Update Agents)
Utilize para auditar, formalizar e calibrar as regras (`.agents/rules/`) e convenções do repositório.

## 1. Mapeamento & Detecção
Inspecione o repositório utilizando comandos RTK (`rtk find`, `rtk grep`, `rtk read`):
- Arquivos de configuração (`pyproject.toml`, `settings.py`, `manage.py`, `pytest.ini`, `.env.example`).
- Estrutura de diretórios e apps.
- Padrões observados:
  - Models, QuerySets, Managers.
  - ViewSets vs APIViews, separação de Serializers (read/write).
  - Camada de negócio (`services.py`, `selectors.py`, `models.py`).
  - Suíte de testes (`pytest` vs `unittest`, fixtures, factories).
  - Formatação, linting, docstrings e tipagem (mypy/pyright).
- Regras já existentes em `.agents/rules/`.

## 2. Estratégia de Calibração
Apresente o estado detectado ao usuário e proponha uma das estratégias:
1. **Calibração Baseada no Repositório (Recomendado)**: Formaliza as convenções já praticadas no código existente.
2. **Entrevista de Arquitetura (Grill-Me)**: Conduz uma entrevista estruturada por tópicos para definir padrões onde o repositório for inconsistente ou novo.
3. **Híbrido**: Usa o código como base e debate apenas pontos ambíguos.

## 3. Matriz de Convenções
Antes de gerar regras, consolide os consensos:

| Área | Padrão Observado | Inferência | Confirmado pelo Usuário | Regra |
| :--- | :--- | :--- | :--- | :--- |
| ViewSets | `GenericViewSet` + mixins | Padrão do projeto | Sim | Sim |
| Services | `services.py` | Camada de negócio | Sim | Sim |
| Testes | pytest + mixins | Padrão do projeto | Sim | Sim |

## 4. Geração & Atualização de Regras
Gere ou atualize regras concisas e acionáveis em `.agents/rules/`:
- `anti-drift.md`
- `global.md`
- `rtk.md`
- `django.md`
- `drf.md`
- `project-execution.md` (quando aplicável)

### Estrutura das Regras
- Frontmatter com `trigger: glob:` (quando aplicável).
- Regras diretas, imperativas e sem teorias desnecessárias.
- Referências a arquivos de exemplo no próprio repositório.

## 5. Validação & Relatório Final
Valide:
- Frontmatter YAML válido e Markdown correto.
- Sem contradições entre regras.
- Alinhamento estrito com as tecnologias e práticas reais do projeto.

Apresente um resumo conciso das regras criadas/atualizadas e decisões formalizadas.