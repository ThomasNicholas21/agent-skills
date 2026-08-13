# Catálogo e Índice Central de Design Patterns para Agentes de IA

Este documento é o ponto de entrada primário para Agentes de IA e LLMs navegando pela base de conhecimento de Padrões de Projeto (Design Patterns). Ele centraliza a matriz tridirecional entre o **PDF Primário**, o **Mapa de Páginas de Referência** e o **Guia Conceitual de Resumo Rápido** utilizando caminhos relativos portáveis.

---

## Matriz Tridirecional do Acervo

| Suíte / Coleção | PDF Primário (Físico) | Mapa de Páginas do Livro | Guia Conceitual de Resumo Rápido |
|---|---|---|---|
| Padrões de Projeto GoF (Gamma et al.) | [design-patterns.pdf](design-pattern-references/pdf/design-patterns.pdf) | [references-design-patterns.md](design-pattern-references/references-design-patterns.md) | [desgin-patterns.md](design-pattern-references/desgin-patterns.md) |
| Refactoring Guru (Alexander Shvets) | [design-pattern-refactoring-guru.pdf](guru-references/pdf/design-pattern-refactoring-guru.pdf) | [references-design-pattern-refactoring-guru.md](guru-references/references-design-pattern-refactoring-guru.md) | [desing-pattern-refactoring-guru.md](guru-references/desing-pattern-refactoring-guru.md) |
| Service Design Patterns (Robert Daigneau) | [service-pattern.pdf](service-pattern-references/pdf/service-pattern.pdf) | [references-service-design-patterns.md](service-pattern-references/references-service-design-patterns.md) | [service-design-patterns.md](service-pattern-references/service-design-patterns.md) |

---

## Diagnóstico Rápido e Roteamento por Intenção de Agente

### 1. Padrões Criacionais (Instanciação e Criação de Objetos)

| Sintoma de Design | Padrão | Guia Resumo GoF | Guia Resumo Guru | Mapa de Páginas |
|---|---|---|---|---|
| Criar famílias de objetos compatíveis | Abstract Factory | [GoF desgin-patterns.md #3.1](design-pattern-references/desgin-patterns.md#31-abstract-factory) | [Guru desing-pattern #10](guru-references/desing-pattern-refactoring-guru.md#10-abstract-factory) | [Pág. 95 / Ref. GoF](design-pattern-references/references-design-patterns.md#52-abstract-factory--p-95) |
| Construir objetos complexos em etapas | Builder | [GoF desgin-patterns.md #3.2](design-pattern-references/desgin-patterns.md#32-builder) | [Guru desing-pattern #11](guru-references/desing-pattern-refactoring-guru.md#11-builder) | [Pág. 104 / Ref. GoF](design-pattern-references/references-design-patterns.md#53-builder--p-104) |
| Delegar criação para subclasses | Factory Method | [GoF desgin-patterns.md #3.3](design-pattern-references/desgin-patterns.md#33-factory-method) | [Guru desing-pattern #9.1](guru-references/desing-pattern-refactoring-guru.md#91-factory-method) | [Pág. 112 / Ref. GoF](design-pattern-references/references-design-patterns.md#54-factory-method--p-112) |
| Clonar objetos pré-configurados | Prototype | [GoF desgin-patterns.md #3.4](design-pattern-references/desgin-patterns.md#34-prototype) | [Guru desing-pattern #12](guru-references/desing-pattern-refactoring-guru.md#12-prototype) | [Pág. 121 / Ref. GoF](design-pattern-references/references-design-patterns.md#55-prototype--p-121) |
| Restrição estrita de instância única | Singleton | [GoF desgin-patterns.md #3.5](design-pattern-references/desgin-patterns.md#35-singleton) | [Guru desing-pattern #13](guru-references/desing-pattern-refactoring-guru.md#13-singleton) | [Pág. 130 / Ref. GoF](design-pattern-references/references-design-patterns.md#56-singleton--p-130) |

### 2. Padrões Estruturais (Composição de Classes e Objetos)

| Sintoma de Design | Padrão | Guia Resumo GoF | Guia Resumo Guru | Mapa de Páginas |
|---|---|---|---|---|
| Incompatibilidade entre interfaces | Adapter | [GoF desgin-patterns.md #4.1](design-pattern-references/desgin-patterns.md#41-adapter) | [Guru desing-pattern #15](guru-references/desing-pattern-refactoring-guru.md#15-adapter) | [Pág. 140 / Ref. GoF](design-pattern-references/references-design-patterns.md#62-adapter--p-140) |
| Abstração vs implementação em variação | Bridge | [GoF desgin-patterns.md #4.2](design-pattern-references/desgin-patterns.md#42-bridge) | [Guru desing-pattern #16](guru-references/desing-pattern-refactoring-guru.md#16-bridge) | [Pág. 151 / Ref. GoF](design-pattern-references/references-design-patterns.md#63-bridge--p-151) |
| Hierarquia de árvore (partes/todo) | Composite | [GoF desgin-patterns.md #4.3](design-pattern-references/desgin-patterns.md#43-composite) | [Guru desing-pattern #17](guru-references/desing-pattern-refactoring-guru.md#17-composite) | [Pág. 160 / Ref. GoF](design-pattern-references/references-design-patterns.md#64-composite--p-160) |
| Adicionar responsabilidades sem subclasses | Decorator | [GoF desgin-patterns.md #4.4](design-pattern-references/desgin-patterns.md#44-decorator) | [Guru desing-pattern #18](guru-references/desing-pattern-refactoring-guru.md#18-decorator) | [Pág. 170 / Ref. GoF](design-pattern-references/references-design-patterns.md#65-decorator--p-170) |
| Simplificar interface de subsistema | Façade | [GoF desgin-patterns.md #4.5](design-pattern-references/desgin-patterns.md#45-façade) | [Guru desing-pattern #19](guru-references/desing-pattern-refactoring-guru.md#19-facade) | [Pág. 179 / Ref. GoF](design-pattern-references/references-design-patterns.md#66-façade--p-179) |
| Economizar memória compartilhando estado | Flyweight | [GoF desgin-patterns.md #4.6](design-pattern-references/desgin-patterns.md#46-flyweight) | [Guru desing-pattern #20](guru-references/desing-pattern-refactoring-guru.md#20-flyweight) | [Pág. 187 / Ref. GoF](design-pattern-references/references-design-patterns.md#67-flyweight--p-187) |
| Intermediar/controlar acesso a objeto | Proxy | [GoF desgin-patterns.md #4.7](design-pattern-references/desgin-patterns.md#47-proxy) | [Guru desing-pattern #21](guru-references/desing-pattern-refactoring-guru.md#21-proxy) | [Pág. 198 / Ref. GoF](design-pattern-references/references-design-patterns.md#68-proxy--p-198) |

### 3. Padrões Comportamentais (Comunicação e Algoritmos)

| Sintoma de Design | Padrão | Guia Resumo GoF | Guia Resumo Guru | Mapa de Páginas |
|---|---|---|---|---|
| Cadeia de tratadores de requisição | Chain of Resp. | [GoF desgin-patterns.md #5.1](design-pattern-references/desgin-patterns.md#51-chain-of-responsibility) | [Guru desing-pattern #23](guru-references/desing-pattern-refactoring-guru.md#23-chain-of-responsibility) | [Pág. 212 / Ref. GoF](design-pattern-references/references-design-patterns.md#72-chain-of-responsibility--p-212) |
| Encapsular ação em objeto (undo/redo) | Command | [GoF desgin-patterns.md #5.2](design-pattern-references/desgin-patterns.md#52-command) | [Guru desing-pattern #24](guru-references/desing-pattern-refactoring-guru.md#24-command) | [Pág. 222 / Ref. GoF](design-pattern-references/references-design-patterns.md#73-command--p-222) |
| Percorrer coleção mantendo encapsulamento | Iterator | [GoF desgin-patterns.md #5.4](design-pattern-references/desgin-patterns.md#54-iterator) | [Guru desing-pattern #25](guru-references/desing-pattern-refactoring-guru.md#25-iterator) | [Pág. 244 / Ref. GoF](design-pattern-references/references-design-patterns.md#75-iterator--p-244) |
| Reduzir acoplamento direto entre N classes | Mediator | [GoF desgin-patterns.md #5.5](design-pattern-references/desgin-patterns.md#55-mediator) | [Guru desing-pattern #26](guru-references/desing-pattern-refactoring-guru.md#26-mediator) | [Pág. 257 / Ref. GoF](design-pattern-references/references-design-patterns.md#76-mediator--p-257) |
| Salvar e restaurar snapshot de estado | Memento | [GoF desgin-patterns.md #5.6](design-pattern-references/desgin-patterns.md#56-memento) | [Guru desing-pattern #27](guru-references/desing-pattern-refactoring-guru.md#27-memento) | [Pág. 266 / Ref. GoF](design-pattern-references/references-design-patterns.md#77-memento--p-266) |
| Notificar observadores sobre eventos | Observer | [GoF desgin-patterns.md #5.7](design-pattern-references/desgin-patterns.md#57-observer) | [Guru desing-pattern #28](guru-references/desing-pattern-refactoring-guru.md#28-observer) | [Pág. 274 / Ref. GoF](design-pattern-references/references-design-patterns.md#78-observer--p-274) |
| Alterar comportamento conforme estado | State | [GoF desgin-patterns.md #5.8](design-pattern-references/desgin-patterns.md#58-state) | [Guru desing-pattern #29](guru-references/desing-pattern-refactoring-guru.md#29-state) | [Pág. 284 / Ref. GoF](design-pattern-references/references-design-patterns.md#79-state--p-284) |
| Encapsular e trocar algoritmos | Strategy | [GoF desgin-patterns.md #5.9](design-pattern-references/desgin-patterns.md#59-strategy) | [Guru desing-pattern #30](guru-references/desing-pattern-refactoring-guru.md#30-strategy) | [Pág. 292 / Ref. GoF](design-pattern-references/references-design-patterns.md#710-strategy--p-292) |
| Esqueleto fixo com etapas variáveis | Template Method | [GoF desgin-patterns.md #5.10](design-pattern-references/desgin-patterns.md#510-template-method) | [Guru desing-pattern #31](guru-references/desing-pattern-refactoring-guru.md#31-template-method) | [Pág. 301 / Ref. GoF](design-pattern-references/references-design-patterns.md#711-template-method--p-301) |
| Adicionar operações sobre estrutura estável | Visitor | [GoF desgin-patterns.md #5.11](design-pattern-references/desgin-patterns.md#511-visitor) | [Guru desing-pattern #32](guru-references/desing-pattern-refactoring-guru.md#32-visitor) | [Pág. 305 / Ref. GoF](design-pattern-references/references-design-patterns.md#712-visitor--p-305) |

### 4. Padrões de Arquitetura e Web Services (Service Design Patterns)

| Área de Serviço | Padrões | Guia Resumo Service Patterns | Mapa de Páginas Service Patterns |
|---|---|---|---|
| Estilos de API | RPC API, Message API, Resource API | [Service Resumo #7, #8, #9](service-pattern-references/service-design-patterns.md#7-rpc-api) | [Service Ref. Cap. 2](service-pattern-references/references-service-design-patterns.md#4-capítulo-2--web-service-api-styles) |
| Conversação | Request/Response, Request/Ack, Media Type | [Service Resumo #12, #13, #14](service-pattern-references/service-design-patterns.md#12-requestresponse) | [Service Ref. Cap. 3](service-pattern-references/references-service-design-patterns.md#5-capítulo-3--client-service-interactions) |
| Gerenciamento | Service Controller, DTO, Mappers | [Service Resumo #17, #18, #19, #20](service-pattern-references/service-design-patterns.md#17-service-controller) | [Service Ref. Cap. 4](service-pattern-references/references-service-design-patterns.md#6-capítulo-4--request-and-response-management) |
| Implementação | Transaction Script, Datasource Adapter | [Service Resumo #22, #23, #24, #25](service-pattern-references/service-design-patterns.md#22-transaction-script) | [Service Ref. Cap. 5](service-pattern-references/references-service-design-patterns.md#7-capítulo-5--web-service-implementation-styles) |
| Infraestrutura | Service Connector, Interceptor, Retry | [Service Resumo #28, #30, #31, #32](service-pattern-references/service-design-patterns.md#28-service-connector) | [Service Ref. Cap. 6](service-pattern-references/references-service-design-patterns.md#8-capítulo-6--web-service-infrastructures) |
| Evolução | Tolerant Reader, Consumer Contracts | [Service Resumo #34, #36, #37](service-pattern-references/service-design-patterns.md#36-tolerant-reader) | [Service Ref. Cap. 7](service-pattern-references/references-service-design-patterns.md#9-capítulo-7--web-service-evolution) |

---

## Diretrizes de Navegação para Agentes de IA

1. **Uso de Resumos para Resolução Rápida**: Para entender o *modelo mental*, *trade-offs* e *como raciocinar*, navegue diretamente até o arquivo `*.md` da coleção desejada.
2. **Uso de Referências para Verificação de Páginas/UML**: Para checar o livro impresso ou encontrar diagramas no PDF físico, acesse a coluna "Mapa de Páginas" (`references-*.md`).
3. **Portabilidade e Links Relativos**: Todos os links utilizam caminhos relativos estándar de Markdown, permitindo resolução automática no GitHub, IDEs e ferramentas CLI (`rtk grep`, `view_file`).
