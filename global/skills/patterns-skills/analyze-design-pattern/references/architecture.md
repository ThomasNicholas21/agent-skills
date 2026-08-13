# Arquitetura e Orquestração: Analyze Design Pattern

## Diagrama de Sequência de Orquestração

```mermaid
sequenceDiagram
    autonumber
    actor User as Usuário / Prompt
    participant Agent as Agente / LLM
    participant Analyzer as analyze-design-pattern
    participant Service as pattern-service-layer
    participant Repo as pattern-repository
    participant Serializer as pattern-serializer-strategy

    User->>Agent: Solicita nova funcionalidade / refatoração
    Agent->>Analyzer: Avalia intenção e aciona a Skill Orquestradora
    Analyzer->>Analyzer: Inspeciona projeto via RTK (rtk find, rtk grep)
    Analyzer->>Analyzer: Consulta Master Index (docs/design-patterns/INDEX.md)
    Analyzer->>Agent: Retorna recomendação arquitetural e plano de execução
    Agent->>Service: Invocação da Camada de Serviço (Lógica de Domínio)
    Agent->>Repo: Invocação do Repositório (Consultas SQL/ORM)
    Agent->>Serializer: Invocação das Estratégias DTO (Entrada/Saída)
    Agent->>User: Código gerado com validação RTK (rtk pytest)
```

## Relação com a Base de Conhecimento (`docs/design-patterns/`)

- [Master Index de Design Patterns]($DOC_DIR/design-patterns/INDEX.md)
- [Resumo GoF de Seleção e Aplicação]($DOC_DIR/design-patterns/design-pattern-references/desgin-patterns.md#9-como-escolher-um-pattern)
- [Service Design Patterns — API Styles & Boundary Layer]($DOC_DIR/design-patterns/service-pattern-references/service-design-patterns.md#6-cap%C3%ADtulo-2--web-service-api-styles)
