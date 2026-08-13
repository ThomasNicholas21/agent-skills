---
name: analyze-design-pattern
description: >-
  Analisa requisitos de software, arquitetura e prompts de tarefas para orquestrar
  e recomendar a combinação ideal de Padrões de Projeto (Service Layer, Repository,
  Factory, Serializer Strategy, OpenAPI) e invocar as skills correspondentes.
metadata:
  category: meta-architecture
  pattern-type: orchestrator
---

# Skill Orquestradora: Analyze Design Pattern

Esta habilidade atua como um consultor de arquitetura para o agente local/global. Ao receber um prompt pedindo a criação ou refatoração de uma funcionalidade, ela avalia o contexto do projeto e aciona/combina as habilidades de design pattern adequadas.

---

## Configuração de Caminhos & Variáveis de Ambiente

Ao executar buscas ou referenciar documentação, a habilidade deve respeitar a resolução das variáveis de ambiente parametrizadas em `.env.example`:
- `$AGENT_SKILLS_DIR`: Raiz do repositório hub de código (`~/projects/agent-skills`).
- `$DOC_DIR`: Diretório da base de conhecimento no repositório (`$AGENT_SKILLS_DIR/docs`).
- `$GEMINI_DIR` / `$CLAUDE_DIR`: Diretórios globais de configuração dos agentes (`~/.gemini`, `~/.claude`).
- `$OBSIDIAN_VAULT_DIR` / `$SECOND_BRAIN_DIR` / `$OBSIDIAN_VAULT_PATH`: Cofre central do Obsidian Second Brain (`~/obsidian/obsidian-second-brain` ou `/mnt/c/Users/thoma/Meus Documentos/obsidian-second-brain-vault`), localizado fora do repositório de código.

---

## Fluxo de Análise e Orquestração

1. **Inspeção de Contexto**:
   - Analisar o repositório utilizando comandos RTK (`rtk find`, `rtk grep`).
   - Identificar a stack (Python/Django, TypeScript/Node, Java, C#) e a arquitetura atual.

2. **Matriz de Decisão Arquitetural**:
   - Consultar a matriz de decisão completa em [references/architecture.md](./references/architecture.md).
   - Verificar no [Master Index]($DOC_DIR/design-patterns/INDEX.md) a fundamentação teórica GoF/Guru/Service Patterns.

3. **Plano de Execução**:
   - Apresentar ao usuário a justificativa arquitetural e os arquivos propostos (`services.py`, `repositories.py`, `serializers.py`, etc.).
   - Aguardar confirmação para efetuar modificações.

---

## Matriz Resumida de Recomendação

| Requisito / Indicador | Padrão Recomendado | Habilidade a Invocar |
|---|---|---|
| Regra de negócio complexa / transações | Service Layer | [pattern-service-layer](../pattern-service-layer/SKILL.md) |
| Consultas ORM pesadas / Prevenção N+1 | Repository | [pattern-repository](../pattern-repository/SKILL.md) |
| Separação de DTOs Read vs Write | Serializer Strategy | [pattern-serializer-strategy](../pattern-serializer-strategy/SKILL.md) |
| Criação parametrizada de instâncias / Mocks | Factory Method | `pattern-factory-method` |

---

## Referências e Validação

- [Arquitetura e Diagramas de Orquestração](./references/architecture.md)
- [Diretrizes de Validação com RTK](./references/rtk-validation.md)
- [Master Index de Design Patterns]($DOC_DIR/design-patterns/INDEX.md)
