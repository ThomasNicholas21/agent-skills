# Service Design Patterns — Referência completa do PDF

**Arquivo PDF Primário:** [service-pattern.pdf](pdf/service-pattern.pdf)  
**Documento Conceituador:** [service-design-patterns.md](service-design-patterns.md)  
**Autor:** Robert Daigneau  
**Título:** *Service Design Patterns: Fundamental Design Solutions for SOAP/WSDL and RESTful Web Services*  
**ISBN:** 978-0-321-54420-9  
**PDF analisado:** 60 páginas no arquivo enviado.  

> **Nota sobre o arquivo:** o PDF enviado é uma versão compactada/excerto. Ele contém o front matter, o Capítulo 1 completo, o sumário dos capítulos 2–7 e o índice/glossário parcial/final. Os números de página abaixo são, prioritariamente, os **números de página impressos no livro**, porque são os que o próprio PDF usa para localizar os padrões.

---

## Índice Padronizado para Agentes de IA

### Acesso Rápido a Seções Principais

- [1. Mapa rápido do documento](#1-mapa-rápido-do-documento)
- [2. Front Matter](#2-front-matter)
- [3. Capítulo 1 — From Objects to Web Services](#3-capítulo-1--from-objects-to-web-services)
- [4. Capítulo 2 — Web Service API Styles](#4-capítulo-2--web-service-api-styles)
- [5. Capítulo 3 — Client-Service Interactions](#5-capítulo-3--client-service-interactions)
- [6. Capítulo 4 — Request and Response Management](#6-capítulo-4--request-and-response-management)
- [7. Capítulo 5 — Web Service Implementation Styles](#7-capítulo-5--web-service-implementation-styles)
- [8. Capítulo 6 — Web Service Infrastructures](#8-capítulo-6--web-service-infrastructures)
- [9. Capítulo 7 — Web Service Evolution](#9-capítulo-7--web-service-evolution)
- [10. Appendix — External Patterns](#10-appendix--external-patterns)
- [11. Glossary](#11-glossary)
- [12. Bibliography](#12-bibliography)
- [13. Índice — referências centrais por termo](#13-índice--referências-centrais-por-termo)
- [14. Índice de padrões — uma linha por pattern](#14-índice-de-padrões--uma-linha-por-pattern)
- [15. Índice de navegação para estudos](#15-índice-de-navegação-para-estudos)
- [16. Observação sobre páginas ausentes no PDF compactado](#16-observação-sobre-páginas-ausentes-no-pdf-compactado)

### Matriz de Mapeamento Direto — Service Design Patterns

| Padrão | Categoria | Livro (pág.) | Seção no Markdown |
|---|---|---:|---|
| RPC API | Web Service API Style | 18 | [4.3 RPC API](#43-rpc-api) |
| Message API | Web Service API Style | 27 | [4.4 Message API](#44-message-api) |
| Resource API | Web Service API Style | 38 | [4.5 Resource API](#45-resource-api) |
| Request/Response | Client-Service Interaction | 54 | [5.2 Request/Response](#52-requestresponse) |
| Request/Acknowledge | Client-Service Interaction | 59 | [5.3 Request/Acknowledge](#53-requestacknowledge) |
| Media Type Negotiation | Client-Service Interaction | 70 | [5.4 Media Type Negotiation](#54-media-type-negotiation) |
| Linked Service | Client-Service Interaction | 77 | [5.5 Linked Service](#55-linked-service) |
| Service Controller | Request/Response Management | 85 | [6.2 Service Controller](#62-service-controller) |
| Data Transfer Object (DTO) | Request/Response Management | 94 | [6.3 Data Transfer Object (DTO)](#63-data-transfer-object-dto) |
| Request Mapper | Request/Response Management | 109 | [6.4 Request Mapper](#64-request-mapper) |
| Response Mapper | Request/Response Management | 122 | [6.5 Response Mapper](#65-response-mapper) |
| Transaction Script | Implementation Style | 134 | [7.3 Transaction Script](#73-transaction-script) |
| Datasource Adapter | Implementation Style | 137 | [7.4 Datasource Adapter](#74-datasource-adapter) |
| Operation Script | Implementation Style | 144 | [7.5 Operation Script](#75-operation-script) |
| Command Invoker | Implementation Style | 149 | [7.6 Command Invoker](#76-command-invoker) |
| Workflow Connector | Implementation Style | 156 | [7.7 Workflow Connector](#77-workflow-connector) |
| Service Connector | Infrastructure | 168 | [8.2 Service Connector](#82-service-connector) |
| Service Descriptor | Infrastructure | 175 | [8.3 Service Descriptor](#83-service-descriptor) |
| Asynchronous Response Handler | Infrastructure | 184 | [8.4 Asynchronous Response Handler](#84-asynchronous-response-handler) |
| Service Interceptor | Infrastructure | 195 | [8.5 Service Interceptor](#85-service-interceptor) |
| Idempotent Retry | Infrastructure | 206 | [8.6 Idempotent Retry](#86-idempotent-retry) |
| Service Registry | SOA Infrastructure | 220 | [8.7 Quick Review of SOA Infrastructure Patterns](#87-quick-review-of-soa-infrastructure-patterns) |
| Enterprise Service Bus (ESB) | SOA Infrastructure | 221 | [8.7 Quick Review of SOA Infrastructure Patterns](#87-quick-review-of-soa-infrastructure-patterns) |
| Orchestration Engine | SOA Infrastructure | 224 | [8.7 Quick Review of SOA Infrastructure Patterns](#87-quick-review-of-soa-infrastructure-patterns) |
| Single-Message Argument | Evolution | 234 | [9.6 Single-Message Argument](#96-single-message-argument) |
| Dataset Amendment | Evolution | 237 | [9.7 Dataset Amendment](#97-dataset-amendment) |
| Tolerant Reader | Evolution | 243 | [9.8 Tolerant Reader](#98-tolerant-reader) |
| Consumer-Driven Contracts | Evolution | 250 | [9.9 Consumer-Driven Contracts](#99-consumer-driven-contracts) |

---

## 1. Mapa rápido do documento

| Área | Página impressa | Local no PDF |
|---|---:|---:|
| Capa | — | PDF p. 1 |
| Sumário — Capítulo 1 | 1–11 | PDF pp. 9–11 |
| Sumário — Capítulo 2 | 13–49 | PDF p. 9 |
| Sumário — Capítulo 3 | 51–80 | PDF pp. 9–10 |
| Sumário — Capítulo 4 | 83–126 | PDF pp. 10 |
| Sumário — Capítulo 5 | 131–163 | PDF pp. 10 |
| Sumário — Capítulo 6 | 165–225 | PDF pp. 10–11 |
| Sumário — Capítulo 7 | 227–268 | PDF p. 11 |
| Apêndice | 269–275 | PDF p. 11 |
| Glossário | 277–295 | PDF p. 11 |
| Bibliografia | 297–300 | PDF p. 11 |
| Índice | 303–320 | PDF pp. 40–60 |

A organização do livro é explicitamente dividida em seis capítulos de padrões após a introdução: API styles, client-service interactions, request/response management, implementation styles, infrastructures e evolution. O sumário do arquivo confirma essa estrutura. 

---

# 2. Front Matter

## Capa

- **PDF p. 1**
- Título: *Service Design Patterns*
- Subtítulo: *Fundamental Design Solutions for SOAP/WSDL and RESTful Web Services*
- Autor: Robert Daigneau.

## Foreword — Martin Fowler

- **PDF pp. 13–14**
- **Livro: pp. xi–xii**
- Tema central: aplicações corporativas precisam se comunicar com sistemas externos; o desafio não é apenas conectar, mas decidir **como** os serviços devem se comunicar e como evoluir sem quebrar clientes.

## Foreword — Ian Robinson

- **PDF pp. 15–16**
- **Livro: pp. xiii–xiv**
- Tema central: cautela ao distribuir sistemas; diferencia serviços que apenas usam a Web como transporte daqueles que realmente adotam os princípios da Web.

## Prefácio

- **PDF pp. 17–22**
- **Livro: pp. xv–xx**
- Contém:
  - objetivo do livro;
  - definição de Web Service usada pela obra;
  - público-alvo;
  - pré-requisitos;
  - organização dos capítulos;
  - formato usado para descrever cada pattern;
  - categorias deliberadamente cobertas apenas superficialmente.

### Estrutura de um Pattern no livro

Cada padrão é descrito usando:

1. Pattern name
2. Context
3. Problem
4. Forces
5. Solution summary
6. Solution detail
7. Considerations
8. Examples

**Local:** PDF p. 21–22 / Livro pp. xix–xx.  

---

# 3. Capítulo 1 — From Objects to Web Services

**Livro:** pp. 1–11  
**PDF:** pp. 29–39

## 3.1 What Are Web Services?

- **Livro p. 2**
- **PDF p. 30**
- Definição de service.
- Web Services como forma de compartilhar funções de negócio entre aplicações e plataformas distintas.
- HTTP como transporte ou como protocolo de aplicação.

## 3.2 From Local Objects to Distributed Objects

- **Livro pp. 3–6**
- **PDF pp. 31–34**
- Objetos locais.
- Fine-grained objects.
- White-box reuse.
- Componentes.
- Black-box reuse.
- Distributed objects.
- Remote Proxy / Stub.
- CORBA, DCOM, RMI e .NET Remoting.
- Serialização/desserialização.
- Problemas de firewall.
- Estado remoto.
- Uso de memória.
- Load balancing.
- Perda de estado em crashes.

### Figura 1.1 — Components
- **PDF p. 32**
- Mostra a ideia de componentes como unidades reutilizáveis, com interface específica de plataforma.

### Figura 1.2 — Distributed Objects
- **PDF p. 33**
- Mostra:
  - Client Process
  - Proxy
  - Network
  - Stub
  - Server Process
  - Customer Object.

## 3.3 Why Use Web Services?

- **Livro p. 6**
- **PDF p. 34**
- Reuso entre clientes web, desktop e mobile.
- Interoperabilidade.
- HTTP.
- XML/JSON.
- Service composition.
- Layer of indirection.

### Figura 1.3 — Web Service Layer of Indirection

- **Livro p. 7**
- **PDF p. 35**
- Mostra o isolamento entre:
  - Client Applications
  - Service Layer
  - Domain Layer
  - Data Sources.

## 3.4 Web Service Considerations and Alternatives

- **Livro pp. 7–9**
- **PDF pp. 35–37**

### Temas

- custo de chamadas remotas;
- serialização;
- desserialização;
- latência;
- partial failures;
- timeouts;
- disponibilidade;
- service libraries;
- Message-Oriented Middleware;
- UDP como alternativa em cenários específicos;
- streaming de grandes documentos;
- protocolos especializados para multimídia.

## 3.5 Services and the Promise of Loose Coupling

- **Livro pp. 9–10**
- **PDF pp. 37–38**

### Tipos de coupling apresentados

- **Function Coupling** — Livro p. 9.
- **Data Structure Coupling** — Livro p. 10.
- **Temporal Coupling** — Livro p. 10.
- **URI Coupling** — Livro p. 10.

### Patterns relacionados

- Temporal coupling:
  - Request/Acknowledge — p. 59
  - Asynchronous Response Handler — p. 184
- URI coupling:
  - Linked Service — p. 77
  - Service Connector — p. 168
  - Service Registry — p. 220
  - Virtual Service — p. 222

## 3.6 What about SOA?

- **Livro pp. 10–11**
- **PDF pp. 38–39**
- Definições de SOA.
- SOA como paradigma de organização e utilização de capacidades distribuídas.
- Serviços organizados em domínios e gerenciados ao longo do ciclo de vida.

---

# 4. Capítulo 2 — Web Service API Styles

**Livro:** pp. 13–49  
**Localização no PDF:** sumário em PDF p. 9; conteúdo integral não está presente no arquivo compactado enviado.

## 4.1 Introduction

- Livro p. 13

## 4.2 Design Considerations for Web Service APIs

- Livro pp. 14–17
- Temas associados pelo índice:
  - autonomy;
  - encapsulation;
  - latency;
  - partial failures;
  - service contracts;
  - top-down design;
  - bottom-up design.

## 4.3 RPC API

- **Livro pp. 18–26**
- Pattern localizado pelo sumário.

### Subtemas indexados

- overview — pp. 18–20
- creating flat APIs — pp. 20–21
- proxies / Service Proxies — pp. 21–22
- Location Transparency — p. 22
- Request/Acknowledge — relacionado na p. 22
- Asynchronous Response Handler — relacionado na p. 22
- binary coding — p. 23
- service contracts — p. 20
- service descriptors / WSDL — pp. 21–22

## 4.4 Message API

- **Livro pp. 27–37**

### Subtemas indexados

- overview — pp. 27–29
- message types — p. 29
- Command Messages — p. 29
- Document Messages — p. 29
- Event Messages — p. 29
- Service Connector — pp. 29–30
- Service Contract — pp. 29–30
- Service Descriptor — p. 29
- asynchronous behavior — p. 30
- delegation of work — p. 30
- late binding — p. 30
- blocking avoidance — p. 30
- binary encoding — pp. 30–31
- Request/Acknowledge — p. 30
- Workflow Connector — p. 30

### Exemplos

- SOAP + WSDL — pp. 31–33
- sem WSDL — pp. 33–37

## 4.5 Resource API

- **Livro pp. 38–49**

### Subtemas indexados

- CRUD — pp. 38–39
- RESTful Resource API — p. 39
- REST — p. 40
- GET — pp. 41–42
- POST — pp. 41–42
- PUT — pp. 41–42
- DELETE — pp. 41–42
- HEAD — pp. 41–42
- OPTIONS — pp. 41–42
- HTTP status codes — p. 42
- media types — pp. 42–43
- safe operations — pp. 42–43
- idempotent operations — pp. 42–43
- Post-Once-Exactly — p. 42
- addressability — pp. 43–44
- blocking/asynchrony — p. 44
- late binding — p. 45
- caching — p. 45
- layered systems — p. 46
- uniform interface — p. 46
- Lost Update Problem — p. 49

### Exemplos

- implementação em Java/JAX-RS — p. 47
- procedure invocation — p. 48
- conditional queries/updates — pp. 48–49

---

# 5. Capítulo 3 — Client-Service Interactions

**Livro:** pp. 51–80  
**Localização no PDF:** sumário em PDF pp. 9–10; conteúdo integral não está presente no arquivo compactado enviado.

## 5.1 Introduction

- Livro p. 51

## 5.2 Request/Response

- **Livro pp. 54–58**

### Subtemas

- overview — pp. 54–55
- Request/Response em RPC API — exemplo na p. 58
- temporal coupling — pp. 56–57
- client-side blocking — p. 57
- availability — p. 56
- scalability — p. 56
- intermediaries — p. 57
- proxy servers — p. 57
- firewalls — p. 57

## 5.3 Request/Acknowledge

- **Livro pp. 59–69**

### Subtemas

- asynchronous processing — pp. 59–60
- queues — p. 60
- common steps — p. 61
- error handling — p. 61
- NAck — p. 61
- URI generation — p. 61
- polling — pp. 62–63
- callbacks — pp. 63–65
- Publish/Subscribe — pp. 63–65
- relays — pp. 63–65
- Request/Acknowledge/Callback — pp. 63–65
- Request/Acknowledge/Relay — pp. 63–65
- Request/Acknowledge/Poll — p. 67
- WS-Addressing — pp. 68–69

## 5.4 Media Type Negotiation

- **Livro pp. 70–76**

### Subtemas

- media preferences — p. 70
- content negotiation — pp. 71–73
- Request Handler selection — pp. 71–72
- client-driven negotiation — pp. 72–73
- server-driven negotiation — p. 73
- HTTP Accept — p. 74
- Service Connector — p. 74
- Service Controller — p. 73

### Exemplos

- client-driven — pp. 75–76
- server-driven — pp. 74–75

## 5.5 Linked Service

- **Livro pp. 77–82**

### Subtemas

- discovering related services — p. 77
- workflow guidance — pp. 78–79
- address formatting — p. 79
- adding/removing services — p. 79
- URI coupling — p. 79
- hyperlinks — p. 80
- security — p. 80
- Resource APIs — pp. 79–80

### Exemplos

- Livro pp. 80–82

---

# 6. Capítulo 4 — Request and Response Management

**Livro:** pp. 83–130  
**Localização no PDF:** sumário em PDF p. 10; conteúdo integral não está presente no arquivo compactado enviado.

## 6.1 Introduction

- Livro p. 83

## 6.2 Service Controller

- **Livro pp. 85–93**

### Subtemas

- Front Controller — pp. 85–86
- parsing URIs — p. 87
- URI segments — p. 87
- URI templates — p. 87
- routing expressions — pp. 86, 88–89
- Request Handlers — p. 86
- Request Method Designators — pp. 88–89
- Web Methods — p. 86
- data binding technologies — pp. 86–87
- interface classes — p. 89
- Contract-First vs Code-First — p. 90
- enumerating Service Controllers — p. 90

### Exemplos

- Resource Controller — pp. 91–92
- RPC Controller — p. 93

## 6.3 Data Transfer Object (DTO)

- **Livro pp. 94–108**

### Subtemas

- serialization/deserialization — pp. 94–95
- parsing request data — pp. 95–96
- circular references — p. 95
- data binding instructions — p. 95
- data mapping — p. 97
- Contract-First vs Code-First — pp. 98–99
- schema validation — p. 99
- proprietary formats — p. 99
- strong coupling to messages — p. 98
- client-specific DTOs — p. 100
- collections — pp. 100–101
- chunky data transfers — pp. 100–101
- Tolerant Reader — p. 101

### Exemplos

- using common code — pp. 101–103
- JSON requests with data binding — pp. 103–105
- abstract DTO — pp. 105–108

## 6.4 Request Mapper

- **Livro pp. 109–121**

### Subtemas

- structural differences with equivalent semantics — p. 109
- integration patterns — p. 113
- XSL example — pp. 113–121
- JSON — p. 112
- latency — p. 113
- response time — p. 113
- web server resources — p. 113
- Command Invoker integration — p. 152

## 6.5 Response Mapper

- **Livro pp. 122–130**

### Subtemas

- overview — pp. 122–124
- adoption criteria — pp. 124–125
- client dependencies — p. 125
- integration patterns — pp. 125–126
- linked services — pp. 125–126
- scope of responsibility — p. 125
- work effort — p. 125

### Exemplos

- pp. 126–130

---

# 7. Capítulo 5 — Web Service Implementation Styles

**Livro:** pp. 131–163  
**Localização no PDF:** sumário em PDF p. 10; conteúdo integral não está presente no arquivo compactado enviado.

## 7.1 Introduction

- Livro p. 131

## 7.2 Design Considerations for Web Service Implementation

- Livro pp. 132–133
- Temas:
  - atomicity;
  - state management;
  - service composition.

## 7.3 Transaction Script

- **Livro pp. 134–136**

### Temas

- simplicidade;
- code complexity;
- long methods;
- tight coupling;
- padrões alternativos.

### Exemplo

- Livro p. 136

## 7.4 Datasource Adapter

- **Livro pp. 137–143**

### Problema abordado

Acesso a recursos internos como:

- database tables;
- stored procedures;
- domain objects;
- files.

### Temas

- provider assumptions — p. 139
- access privileges — p. 140
- coupling — p. 140
- custom code — p. 140
- ease of use — p. 140
- latency — pp. 140–141
- service API styles — p. 140
- Domain Models — p. 141

### Exemplo

- Livro pp. 141–143

## 7.5 Operation Script

- **Livro pp. 144–148**

### Temas

- reutilização de domain logic;
- duplicação de application logic;
- IoC;
- local vs distributed transactions;
- application gateways.

### Exemplos

- Livro pp. 146–148

## 7.6 Command Invoker

- **Livro pp. 149–155**

### Temas

- Command pattern;
- reutilização de domínio;
- synchronous/asynchronous processing;
- encaminhamento para background processes;
- integração com Request Mapper.

### Exemplos

- Livro pp. 153–155

## 7.7 Workflow Connector

- **Livro pp. 156–163**

### Temas

- complex/long-running processes;
- control flow;
- compensation;
- correlation;
- callback service;
- Business Activity Monitoring (BAM);
- process complexity;
- maintenance.

### Exemplo

- Livro p. 163

---

# 8. Capítulo 6 — Web Service Infrastructures

**Livro:** pp. 165–225  
**Localização no PDF:** sumário em PDF pp. 10–11; conteúdo integral não está presente no arquivo compactado enviado.

## 8.1 Introduction

- Livro p. 165

## 8.2 Service Connector

- **Livro pp. 168–174**

### Temas

- service address discovery — p. 170
- URI management — pp. 171–172
- connection management — p. 170
- request dispatch — p. 170
- response receipt — p. 170
- converting input data — p. 171
- deserializing response streams — p. 171
- selecting HTTP methods — p. 171
- encapsulating remote access — p. 172
- Service Gateway — p. 172
- unit testing — pp. 172–173
- client-service coupling — p. 173
- connector coupling — p. 173
- location transparency — pp. 173–174

### Exemplos

- Livro pp. 173–174

## 8.3 Service Descriptor

- **Livro pp. 175–183**

### Temas

- service documentation — pp. 175–176
- code generation — pp. 176–177
- service contract — pp. 177–178
- chatty contracts — pp. 177–178
- chunky contracts — pp. 177–178
- coarse-grained contracts — pp. 177–178
- network efficiency — pp. 177–178
- coupling — pp. 178–179
- Contract-First vs Code-First — pp. 179–181
- Consumer-Driven Contracts — p. 178
- documentation — p. 181

### Exemplos

- WSDL — pp. 181–182
- WADL — pp. 182–183

## 8.4 Asynchronous Response Handler

- **Livro pp. 184–194**

### Subtemas

- Polling Method — pp. 185–188
- Client-Side Callback — pp. 185–188
- long-running operations — p. 188
- concurrent requests — p. 188
- temporal coupling — p. 189

### Exemplos

- Polling + RPC — pp. 189
- Polling + Resource API — pp. 190–191
- Callback + RPC — pp. 192–193
- Callback + Resource API — pp. 193–194

## 8.5 Service Interceptor

- **Livro pp. 195–205**

### Temas

- interceptor;
- Pipes and Filters;
- Template Method;
- service frameworks;
- configuration files.

### Exemplos

- validators — pp. 199–200
- loggers — p. 201
- exception handlers — pp. 204–205

## 8.6 Idempotent Retry

- **Livro pp. 206–219**

### Temas

- temporary network/server failures;
- retry;
- delay time;
- race conditions;
- client-side crashes;
- failed retries;
- retry manager;
- reliable messaging.

### Exemplos

- Retry Manager — pp. 212–217
- message delivery assurance — pp. 217–219
- WS-RM — pp. 217–219
- RM Source — pp. 217–219
- RM Destination — pp. 217–219

## 8.7 Quick Review of SOA Infrastructure Patterns

- **Livro pp. 220–225**

### Service Registry

- Livro pp. 220–221

### Enterprise Service Bus (ESB)

- Livro pp. 221–224

### Orchestration Engine

- Livro pp. 224–225

---

# 9. Capítulo 7 — Web Service Evolution

**Livro:** pp. 227–268  
**Localização no PDF:** sumário em PDF p. 11; conteúdo integral não está presente no arquivo compactado enviado.

## 9.1 Introduction

- Livro p. 227

## 9.2 What Causes Breaking Changes?

- **Livro pp. 228–231**

### Causas

- mudanças estruturais em mensagens;
- mudanças estruturais em media types;
- mudanças no Service Descriptor.

## 9.3 Structural Changes to Media Types or Messages

- Livro pp. 229–230

## 9.4 Service Descriptor Changes

- Livro pp. 230–231

## 9.5 Common Versioning Strategies

- **Livro pp. 232–233**

## 9.6 Single-Message Argument

- **Livro pp. 234–236**

### Objetivo

Tornar RPC menos frágil e permitir adição de parâmetros ao longo do tempo.

## 9.7 Dataset Amendment

- **Livro pp. 237–242**

### Temas

- optional data — p. 240
- client-specific structures — p. 240
- abstract types — p. 241
- cluttered data structures — pp. 240–241
- data binding — p. 240

### Exemplos

- DTO + Dataset Amendment — pp. 241–242

## 9.8 Tolerant Reader

- **Livro pp. 243–249**

### Temas

- unknown content;
- varying data structures;
- Postel's Law;
- Robustness Principle;
- DTOs;
- preservation of unknown content;
- ignoring XML namespaces.

### Exemplos

- Livro pp. 246–249

## 9.9 Consumer-Driven Contracts

- **Livro pp. 250–263**

### Temas

- backward compatibility — pp. 250–253
- forward compatibility — pp. 250–253
- documentation — pp. 251–252
- integration tests — pp. 252–253
- test strategies — pp. 254–255
- versioning contracts — p. 254
- exchanging tests — p. 254
- stub implementation — p. 254
- real service implementation — p. 254
- modifying contracts — p. 254
- platform dependencies — p. 255
- long-running asynchronous services — p. 255
- reasonable expectations — p. 255
- complexity — p. 255

### Exemplos

- C# / NUnit — pp. 256–260
- ISO Schematron — pp. 260–263

## 9.10 How the Patterns Promote or Hinder Service Evolution

- **Livro p. 264–268**

### Efeitos indexados

- RPC API — p. 264
- Message API — p. 264
- Resource API — p. 264
- Request/Acknowledge — p. 265
- DTO — p. 265
- Linked Service — p. 265
- Request Mapper — p. 266
- Operation Script — p. 266
- Command Invoker — p. 266
- Datasource Adapter — p. 266
- Workflow Connector — p. 266
- Response Mapper — p. 266
- Service Connector — p. 267
- Service Descriptor — p. 267
- Service Interceptor — p. 267
- Service Registry — p. 267
- ESB — p. 268
- Consumer-Driven Contract — p. 268
- Tolerant Reader — p. 268

---

# 10. Appendix — External Patterns

**Livro:** pp. 269–275  
**Localização no PDF:** sumário em PDF p. 11; conteúdo integral não está presente no arquivo compactado enviado.

A obra aponta para os seguintes patterns externos:

- Adapter [GoF] — p. 269
- Command [GoF] — p. 269
- Command Message [EIP] — p. 269
- Content-Based Router [EIP] — p. 270
- Correlation Identifier [EIP] — p. 270
- Data Transfer Object [POEAA] — p. 270
- Dependency Injection — p. 270
- Document Message [EIP] — p. 271
- Document-Literal-Wrapped — p. 270
- Domain Layer [DDD] — p. 271
- Domain Model [POEAA] — p. 271
- Error Message [EIP] — p. 271
- Façade [GoF] — p. 271
- Factory Method [GoF] — p. 271
- Front Controller [POEAA] — p. 271
- Gateway [POEAA] — p. 272
- Interceptor [POSA2] — p. 272
- Mapper [POEAA] — p. 272
- Mediator [GoF] — p. 272
- Message Bus [EIP] — p. 272
- Message [EIP] — p. 272
- Message Router [EIP] — p. 272
- Message Store [EIP] — p. 273
- Normalizer [EIP] — p. 273
- One-Way Message Exchange — p. 273
- Operation Script [POEAA] — p. 273
- Pipes and Filters [EIP] — p. 273
- Post Once Exactly — p. 273
- Prototype [GoF] — p. 273
- Proxy [GoF] — p. 274
- Record Set [POEAA] — p. 274
- Remote Proxy [GoF] — p. 274
- Service Layer [POEAA] — p. 274
- Singleton [GoF] — p. 274
- Table Module [GoF] — p. 274
- Template Method [GoF] — p. 275
- Transaction Script [POEAA] — p. 275

---

# 11. Glossary

**Livro:** pp. 277–295  
**Localização no PDF:** índice/glossário no final do arquivo.

Termos importantes encontrados no índice/glossário:

- Asynchronous Response Handler — p. 184
- Backward compatibility — referência cruzada para Web Service Evolution
- Binary message encoding
- Client-Service Interaction
- Data Binding
- Dataset
- Deadlock
- Distributed objects
- DoS
- HTTP
- Idempotent operations
- Latency
- Loose coupling
- Media Type
- REST
- RPC
- Service Contract
- Service Connector
- Service Descriptor
- Service Interceptor
- Service Registry
- SOA
- Temporal Coupling
- URI
- Version control
- WSDL
- XML

---

# 12. Bibliography

- **Livro:** pp. 297–300
- **PDF:** final do documento antes do índice.

---

# 13. Índice — referências centrais por termo

## A

- **Addressability** — Resource API, pp. 43–44
- **Asynchronous Response Handler** — p. 184
- **Authentication** — Service Interceptor, Service Descriptor, Resource API, Message API
- **Autonomy** — Web Service API Styles, pp. 15–16

## B

- **Breaking Changes** — pp. 228–231
- **Backward Compatibility** — Web Service Evolution
- **Business Activity Monitoring (BAM)** — Workflow Connector, p. 162

## C

- **Caching** — Resource API, p. 45; Service Interceptor, p. 195
- **Client-Side Callback** — Asynchronous Response Handler, pp. 185–188
- **Client-Service Coupling** — Service Connector, p. 173
- **Coarse-Grained Service Contracts** — Service Descriptor, pp. 177–178
- **Code-First** — DTO, Service Controller, Service Descriptor, Single-Message Argument
- **Command Invoker** — p. 149
- **Consumer-Driven Contracts** — p. 250
- **Contract-First** — DTO, Service Controller, Service Descriptor
- **Correlation Identifier** — Workflow Connector

## D

- **Data Transfer Object** — pp. 94–101
- **Dataset Amendment** — pp. 237–242
- **Datasource Adapter** — p. 137
- **Data binding** — DTO, Request Mapper, Response Mapper, Service Controller
- **Distributed Objects** — pp. 3–6

## I

- **Idempotent Retry** — p. 206
- **Idempotent Operations** — Resource API, pp. 42–43
- **Interception** — Service Interceptor, p. 195

## L

- **Late Binding** — Message API, p. 30; Resource API, p. 45
- **Latency** — API design p. 16; Datasource Adapter pp. 140–141; Request Mapper p. 113
- **Linked Service** — p. 77
- **Loose Coupling** — pp. 9–10

## M

- **Media Type Negotiation** — p. 70
- **Message API** — p. 27
- **Message Bus** — Appendix / EIP reference
- **Message Router** — ESB reference
- **Message Store** — ESB reference

## O

- **Operation Script** — p. 144
- **Orchestration Engine** — pp. 224–225

## R

- **Request/Acknowledge** — p. 59
- **Request/Response** — p. 54
- **Request Mapper** — p. 109
- **Resource API** — p. 38
- **Response Mapper** — p. 122
- **Retry Manager** — pp. 212–217
- **RPC API** — p. 18

## S

- **Service Connector** — p. 168
- **Service Controller** — p. 85
- **Service Descriptor** — p. 175
- **Service Interceptor** — p. 195
- **Service Registry** — p. 220
- **Single-Message Argument** — p. 234
- **SOA** — pp. 10–11

## T

- **Tolerant Reader** — p. 243
- **Transaction Script** — p. 134
- **Temporal Coupling** — p. 10

## W

- **Workflow Connector** — p. 156
- **WSDL** — Service Descriptor, Message API, RPC API
- **WS-Addressing** — pp. 68–69
- **WS-RM** — pp. 217–219

---

# 14. Índice de padrões — uma linha por pattern

| Pattern | Categoria | Livro | PDF/localização disponível |
|---|---|---:|---|
| RPC API | Web Service API Style | 18 | Sumário PDF p. 9 |
| Message API | Web Service API Style | 27 | Sumário PDF p. 9 |
| Resource API | Web Service API Style | 38 | Sumário PDF p. 9 |
| Request/Response | Client-Service Interaction | 54 | Sumário PDF p. 10 |
| Request/Acknowledge | Client-Service Interaction | 59 | Sumário PDF p. 10 |
| Media Type Negotiation | Client-Service Interaction | 70 | Sumário PDF p. 10 |
| Linked Service | Client-Service Interaction | 77 | Sumário PDF p. 10 |
| Service Controller | Request/Response Management | 85 | Sumário PDF p. 10 |
| Data Transfer Object | Request/Response Management | 94 | Sumário PDF p. 10 |
| Request Mapper | Request/Response Management | 109 | Sumário PDF p. 10 |
| Response Mapper | Request/Response Management | 122 | Sumário PDF p. 10 |
| Transaction Script | Implementation Style | 134 | Sumário PDF p. 10 |
| Datasource Adapter | Implementation Style | 137 | Sumário PDF p. 10 |
| Operation Script | Implementation Style | 144 | Sumário PDF p. 10 |
| Command Invoker | Implementation Style | 149 | Sumário PDF p. 10 |
| Workflow Connector | Implementation Style | 156 | Sumário PDF p. 10 |
| Service Connector | Infrastructure | 168 | Sumário PDF p. 10 |
| Service Descriptor | Infrastructure | 175 | Sumário PDF p. 10 |
| Asynchronous Response Handler | Infrastructure | 184 | Sumário PDF p. 11 |
| Service Interceptor | Infrastructure | 195 | Sumário PDF p. 11 |
| Idempotent Retry | Infrastructure | 206 | Sumário PDF p. 11 |
| Service Registry | SOA Infrastructure | 220 | Sumário PDF p. 11 |
| Enterprise Service Bus | SOA Infrastructure | 221 | Sumário PDF p. 11 |
| Orchestration Engine | SOA Infrastructure | 224 | Sumário PDF p. 11 |
| Single-Message Argument | Evolution | 234 | Sumário PDF p. 11 |
| Dataset Amendment | Evolution | 237 | Sumário PDF p. 11 |
| Tolerant Reader | Evolution | 243 | Sumário PDF p. 11 |
| Consumer-Driven Contracts | Evolution | 250 | Sumário PDF p. 11 |

---

# 15. Índice de navegação para estudos

## Fundamentos

1. From Objects to Web Services — Livro p. 1
2. Web Services — Livro p. 2
3. Distributed Objects — Livro pp. 3–6
4. Why Web Services — Livro p. 6
5. Alternatives — Livro pp. 7–9
6. Loose Coupling — Livro pp. 9–10
7. SOA — Livro pp. 10–11

## Design da API

1. API Design Considerations — Livro pp. 14–17
2. RPC API — Livro p. 18
3. Message API — Livro p. 27
4. Resource API — Livro p. 38

## Conversação

1. Request/Response — Livro p. 54
2. Request/Acknowledge — Livro p. 59
3. Media Type Negotiation — Livro p. 70
4. Linked Service — Livro p. 77

## Boundary / Transport Layer

1. Service Controller — Livro p. 85
2. DTO — Livro p. 94
3. Request Mapper — Livro p. 109
4. Response Mapper — Livro p. 122

## Implementação

1. Transaction Script — Livro p. 134
2. Datasource Adapter — Livro p. 137
3. Operation Script — Livro p. 144
4. Command Invoker — Livro p. 149
5. Workflow Connector — Livro p. 156

## Infraestrutura

1. Service Connector — Livro p. 168
2. Service Descriptor — Livro p. 175
3. Asynchronous Response Handler — Livro p. 184
4. Service Interceptor — Livro p. 195
5. Idempotent Retry — Livro p. 206
6. Service Registry — Livro p. 220
7. ESB — Livro p. 221
8. Orchestration Engine — Livro p. 224

## Evolução

1. Breaking Changes — Livro p. 228
2. Versioning — Livro p. 232
3. Single-Message Argument — Livro p. 234
4. Dataset Amendment — Livro p. 237
5. Tolerant Reader — Livro p. 243
6. Consumer-Driven Contracts — Livro p. 250
7. Pattern Effects on Evolution — Livro p. 264

---

# 16. Observação sobre páginas ausentes no PDF compactado

O arquivo enviado informa, no sumário, páginas de **13 a 300** para os capítulos e materiais posteriores, mas o conteúdo efetivamente disponível no PDF compactado salta do Capítulo 1 para o índice final. Portanto, os números acima são **referências bibliográficas/páginas do livro extraídas do próprio PDF**, e não afirmação de que essas páginas físicas estejam disponíveis como páginas legíveis dentro deste arquivo compacto.

Para uma versão em Markdown com **links internos para cada trecho efetivamente disponível do PDF** e citações de linha/página do arquivo, deve-se usar o arquivo completo da obra ou uma versão sem a remoção dos capítulos intermediários.

---

## Fonte primária

`032154420X(1).pdf` — arquivo fornecido nesta conversa.
