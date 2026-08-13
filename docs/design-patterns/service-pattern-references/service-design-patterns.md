# Service Design Patterns — Guia de Conhecimento Rápido para Agentes de IA

**Arquivo PDF Primário:** [service-pattern.pdf](pdf/service-pattern.pdf)  
**Mapa de Referência de Páginas:** [references-service-design-patterns.md](references-service-design-patterns.md)  
**Obra de Origem:** *Service Design Patterns: Fundamental Design Solutions for SOAP/WSDL and RESTful Web Services* (Robert Daigneau)  

---

## Índice Padronizado para Agentes de IA

### Resolução Rápida por Problema / Sintoma de Serviços Web

| Sintoma de Design | Padrão Recomendado | Seção no Markdown |
|---|---|---|
| Invocação remota no estilo de funções procedurais | RPC API | [7. RPC API](#7-rpc-api) |
| Troca de mensagens assíncronas / comandos | Message API | [8. Message API](#8-message-api) |
| APIs uniformes orientadas a recursos e métodos HTTP | Resource API | [9. Resource API](#9-resource-api) |
| Bloqueio síncrono simples do cliente esperando resposta | Request/Response | [12. Request/Response](#12-requestresponse) |
| Processamento assíncrono longo / desacoplamento temporal | Request/Acknowledge | [13. Request/Acknowledge](#13-requestacknowledge) |
| Suporte a múltiplos formatos (JSON, XML) no mesmo recurso | Media Type Negotiation | [14. Media Type Negotiation](#14-media-type-negotiation) |
| Navegação dinâmica de fluxos via links/HATEOAS | Linked Service | [15. Linked Service](#15-linked-service) |
| Roteamento centralizado de requisições de serviço | Service Controller | [17. Service Controller](#17-service-controller) |
| Transferência otimizada de dados na borda da rede | Data Transfer Object (DTO) | [18. Data Transfer Object (DTO)](#18-data-transfer-object-dto) |
| Mapeamento estrutural do payload de entrada | Request Mapper | [19. Request Mapper](#19-request-mapper) |
| Mapeamento estrutural do payload de saída | Response Mapper | [20. Response Mapper](#20-response-mapper) |
| Lógica simples de serviço agrupada em script | Transaction Script | [22. Transaction Script](#22-transaction-script) |
| Adaptação de tabelas, arquivos ou procedures legadas | Datasource Adapter | [23. Datasource Adapter](#23-datasource-adapter) |
| Delegação da execução de serviço para a camada de domínio | Operation Script | [24. Operation Script](#24-operation-script) |
| Execução desacoplada via objetos Command | Command Invoker | [25. Command Invoker](#25-command-invoker) |
| Orquestração de processos complexos de longa duração | Workflow Connector | [26. Workflow Connector](#26-workflow-connector) |
| Encapsulamento do acesso cliente ao serviço | Service Connector | [28. Service Connector](#28-service-connector) |
| Descrição formal e documentação de contrato (WSDL/OpenAPI) | Service Descriptor | [29. Service Descriptor](#29-service-descriptor) |
| Tratamento de respostas assíncronas (Poll/Callback) | Async Response Handler | [30. Asynchronous Response Handler](#30-asynchronous-response-handler) |
| Processamento transversal (logs, validação, auth) | Service Interceptor | [31. Service Interceptor](#31-service-interceptor) |
| Tolerância a falhas temporárias na rede via retentativa | Idempotent Retry | [32. Idempotent Retry](#32-idempotent-retry) |
| Adição de parâmetros sem quebrar clientes existentes | Single-Message Argument | [34. Single-Message Argument](#34-single-message-argument) |
| Leitura flexível que ignora campos desconhecidos | Tolerant Reader | [36. Tolerant Reader](#36-tolerant-reader) |
| Contratos orientados e validados pelas expectativas dos clientes | Consumer-Driven Contracts | [37. Consumer-Driven Contracts](#37-consumer-driven-contracts) |

---

Estudei o PDF enviado. Há, porém, uma limitação importante: o arquivo é uma versão comprimida/excerto. Ele contém o material introdutório e o **Capítulo 1 completo**, além do sumário e do índice que listam os demais capítulos/padrões, mas o texto integral dos capítulos 2–7 não está presente no arquivo disponível. Por isso, abaixo separo claramente o que está efetivamente explicado no PDF do que é uma interpretação didática baseada na estrutura e no índice da obra. O livro se organiza em sete capítulos, cobrindo estilos de API, interações cliente-serviço, gerenciamento de request/response, implementação, infraestrutura e evolução de serviços. 

# Conhecimento para LLM/Agente — Service Design Patterns

## 0. Identidade do conhecimento

**Fonte:** *Service Design Patterns — Fundamental Design Solutions for SOAP/WSDL and RESTful Web Services*, Robert Daigneau.

**Objetivo do material:**

Ensinar uma LLM, agente de software, desenvolvedor ou arquiteto a **raciocinar sobre design de Web Services através de padrões**, e não apenas decorar frameworks ou sintaxe.

A ideia central da obra é:

> Um padrão não é uma receita fixa. Ele representa uma solução recorrente para determinado problema de design, devendo ser adaptado ao contexto.

O próprio livro enfatiza que os padrões são soluções generalizáveis e não devem ser implementados de maneira mecânica ou idêntica em todos os projetos. 

---

# 1. Modelo mental fundamental

Antes de ensinar qualquer padrão, o agente deve entender:

```text
Cliente
   |
   | HTTP / mensagens
   v
Web Service
   |
   v
Service Layer
   |
   v
Domain / Workflow / ORM / Legacy API
   |
   v
Data Sources
```

O Web Service existe como uma **camada de indirection** entre o cliente e os mecanismos internos responsáveis por executar a operação.

Esse isolamento permite que o serviço altere sua implementação interna sem necessariamente exigir alterações nos clientes, desde que sua interface pública não sofra mudanças incompatíveis. O diagrama da página 7 mostra justamente essa ideia: clientes ficam separados da lógica de domínio, workflows, módulos, bibliotecas, aplicações legadas, bancos e outras fontes internas. 

### Regra para o agente

Nunca raciocine:

```text
"Qual classe do banco o cliente precisa chamar?"
```

Raciocine:

```text
"Qual capacidade de negócio o cliente precisa acessar
e qual contrato deve existir entre cliente e serviço?"
```

---

# 2. O problema fundamental da distribuição

Um sistema distribuído não é simplesmente um sistema local com uma API HTTP.

Uma chamada remota possui custos adicionais:

```text
Objeto local:

cliente -> função()

Sistema distribuído:

cliente
   |
   | serialize
   v
rede
   |
   | transmitir
   v
serviço
   |
   | deserialize
   v
execução
   |
   | serialize
   v
rede
   |
   | deserialize
   v
cliente
```

O PDF destaca que chamadas remotas envolvem serialização, transmissão, desserialização e, eventualmente, serialização/desserialização da resposta, aumentando a latência em comparação com chamadas dentro do mesmo processo. 

Mais importante ainda:

**a rede pode falhar parcialmente.**

Por exemplo:

```text
Cliente ----X---- Serviço

Cliente continua funcionando.
Serviço continua funcionando.
A rede falhou.
```

Ou:

```text
Cliente -----> Serviço
                  |
                  X crash
```

O cliente pode receber timeout e não saber se:

```text
1. o serviço nunca recebeu a requisição;
2. recebeu e ainda está processando;
3. processou e a resposta foi perdida;
4. processou e depois sofreu falha.
```

O PDF chama atenção justamente para essas **partial failures**. 

### Conhecimento operacional do agente

Sempre que uma decisão envolver chamada remota, analisar:

```text
latência
+
timeout
+
falha parcial
+
estado
+
retries
+
duplicação
+
versionamento
+
acoplamento
```

---

# 3. Web Services

Um Web Service é apresentado como uma função/capacidade de software que pode realizar uma tarefa de negócio, fornecer acesso a dados/arquivos ou oferecer uma função genérica, como autenticação ou logging.

A característica relevante para a obra é que o serviço fica fora do processo do cliente e utiliza HTTP para transportar dados ou para definir as próprias semânticas da aplicação. 

O livro distingue dois usos conceituais de HTTP:

```text
HTTP como transporte
    SOAP/WSDL

HTTP como protocolo de aplicação
    RESTful
```

Isso é importante porque:

```text
"usar HTTP"
```

não significa automaticamente:

```text
"usar REST".
```

---

# 4. Evolução histórica: objetos → componentes → objetos distribuídos → Web Services

O livro começa por mostrar por que arquiteturas distribuídas evoluíram.

## Objetos locais

Um objeto tradicional:

```python
customer = Customer()
customer.get_address()
```

Possui:

* dados;
* comportamento;
* métodos;
* estado.

São estruturas normalmente fine-grained e favorecem reutilização dentro do processo. 

## Componentes

Componentes introduzem uma forma de **black-box reuse**.

O consumidor não precisa conhecer a implementação interna:

```text
Consumer
   |
   v
Component
   |
   +--> internal objects
   +--> internal behavior
```

Mas componentes históricos continuavam bastante ligados às plataformas onde eram executados. 

## Objetos distribuídos

A próxima evolução foi mover objetos para outro processo/máquina:

```text
Client
  |
Proxy
  |
Network
  |
Stub
  |
Remote Object
```

A figura 1.2 do PDF apresenta exatamente esse modelo de proxy/stub. 

Mas surgiram problemas:

```text
serialização não padronizada
+
protocolos específicos
+
firewalls
+
estado remoto
+
maior consumo de memória
+
dificuldade de load balancing
```

Objetos distribuídos frequentemente mantinham estado entre chamadas, dificultando escalabilidade e balanceamento de carga. 

---

# 5. Loose Coupling

**Loose coupling não significa ausência de acoplamento.**

O PDF é explícito:

```text
Cliente e serviço nunca são completamente desacoplados.
```

Eles continuam possuindo dependências.

A obra destaca quatro formas importantes:

```text
1. Function Coupling
2. Data Structure Coupling
3. Temporal Coupling
4. URI Coupling
```



## Function Coupling

O cliente depende do comportamento do serviço.

Exemplo:

```text
POST /payments

esperado:
payment.status = "approved"
```

Se o serviço muda sua semântica:

```text
"approved" -> "completed"
```

o cliente pode quebrar mesmo que o endpoint continue existindo.

---

## Data Structure Coupling

Cliente e serviço precisam concordar sobre:

```text
campos
tipos
estrutura
encoding
status HTTP
links
```

O PDF recomenda cuidado com tipos excessivamente dependentes da plataforma. 

Exemplo ruim:

```json
{
  "javaBigDecimalInternalRepresentation": ...
}
```

Melhor:

```json
{
  "amount": 125.90
}
```

---

## Temporal Coupling

Existe forte temporal coupling quando:

```text
requisição precisa ser processada imediatamente
```

ou:

```text
cliente precisa ficar bloqueado esperando resposta.
```

O livro aponta dois padrões para reduzir isso:

```text
Request/Acknowledge
Asynchronous Response Handler
```



---

## URI Coupling

O cliente pode ficar preso à localização física/estrutura dos serviços.

Exemplo:

```text
https://api.example.com/customer-service/v1/customer
```

Se o cliente constrói URLs diretamente em várias partes do código, uma mudança pode quebrá-lo.

A obra relaciona esse problema aos padrões:

```text
Linked Service
Service Connector
Registry
Virtual Service
```



---

# 6. Capítulo 2 — Web Service API Styles

O livro divide os principais estilos em:

```text
RPC API
Message API
Resource API
```

Essa escolha é importante porque o estilo de API influencia fortemente o restante da arquitetura e pode ser difícil mudar posteriormente. 

---

# 7. RPC API

## Ideia

O cliente pensa em:

```text
"Execute esta operação."
```

Exemplo conceitual:

```http
POST /PaymentService/charge
```

ou:

```text
chargeCustomer(customerId, amount)
```

O modelo mental é:

```text
CLIENT
  |
  | call procedure
  v
SERVICE
  |
  | execute procedure
  v
RESULT
```

O índice do livro associa RPC API a:

```text
location transparency
proxies
service contracts
service descriptors
async response
Request/Acknowledge
```



### Quando pensar em RPC

Use esse modelo quando o domínio é naturalmente:

```text
"faça uma operação"
```

Exemplos:

```text
calculateQuote()
sendEmail()
capturePayment()
generateInvoice()
```

---

# 8. Message API

Aqui o cliente não precisa ficar diretamente acoplado a uma função remota.

Em vez de:

```text
call calculatePayment()
```

o cliente envia uma mensagem:

```json
{
  "type": "CalculatePayment",
  "payload": {
    "customer_id": 10
  }
}
```

O foco passa de:

```text
qual método remoto executar?
```

para:

```text
qual mensagem estou enviando?
```

O livro destaca três categorias:

```text
Command Message
Document Message
Event Message
```

Também relaciona Message API com:

```text
asynchrony
delegation
late binding
Request/Acknowledge
Service Connector
Workflow Connector
```



### Modelo mental

```text
Client
   |
   | Message
   v
Messaging boundary
   |
   +--> Command
   +--> Document
   +--> Event
```

Isso reduz dependência direta de procedimentos remotos.

---

# 9. Resource API

Resource API muda o foco:

```text
não:
"execute esta função"

mas:
"interaja com este recurso"
```

Exemplo:

```http
GET    /orders/123
POST   /orders
PUT    /orders/123
DELETE /orders/123
```

O índice do livro relaciona Resource API diretamente com:

```text
CRUD
REST
HTTP methods
URI
status codes
idempotency
safe operations
cacheability
addressability
uniform interface
```



### Modelo mental

```text
Resource
   |
   +--> identify with URI
   |
   +--> manipulate with HTTP semantics
```

O objetivo é reduzir a dependência de APIs específicas de domínio por meio de uma interface mais uniforme.

---

# 10. Comparando os três estilos

```text
RPC
"Execute uma operação."

Message
"Receba/interprete esta mensagem."

Resource
"Manipule este recurso."
```

Exemplo: pagamento.

### RPC

```http
POST /payments/charge
```

### Message

```json
{
  "type": "ChargePayment",
  "payment_id": "123"
}
```

### Resource

```http
POST /payments
```

ou:

```http
PUT /payments/123
```

A decisão deve ser orientada pelo domínio e pelas forças do sistema, não por preferência pessoal.

---

# 11. Capítulo 3 — Client-Service Interactions

Os padrões dessa parte tratam **como cliente e serviço conversam**, independentemente do estilo geral da API.

Os principais padrões são:

```text
Request/Response
Request/Acknowledge
Media Type Negotiation
Linked Service
```



---

# 12. Request/Response

É o modelo mais simples:

```text
Client
  |
  | request
  v
Service
  |
  | response
  v
Client
```

O cliente espera o resultado.

O livro descreve esse padrão como a forma mais simples de um serviço processar uma requisição e fornecer seu resultado. 

### Problema

Existe coupling temporal:

```text
cliente precisa esperar
```

E surgem preocupações como:

```text
availability
scalability
blocking
intermediaries
proxy
firewalls
```



### Exemplo

```python
response = requests.post("/payments")

# aplicação bloqueada esperando
payment = response.json()
```

---

# 13. Request/Acknowledge

Aqui a mensagem é recebida e o serviço confirma:

```text
Client
  |
  | Request
  v
Service
  |
  | ACK
  v
Client

      ...processing later...
```

A ideia é separar:

```text
"recebi sua requisição"
```

de:

```text
"terminei de processá-la".
```

O padrão reduz **temporal coupling** e pode utilizar filas. O índice também mostra variantes como:

```text
Polling
Callback
Relay
Publish/Subscribe
```



### Exemplo moderno

```http
POST /reports

202 Accepted

{
  "job_id": "abc-123",
  "status": "processing"
}
```

Depois:

```http
GET /reports/jobs/abc-123
```

---

# 14. Media Type Negotiation

Problema:

```text
mesmo recurso
+
múltiplas representações
```

Por exemplo:

```text
JSON
XML
```

O livro descreve content negotiation como a capacidade de fornecer múltiplas representações da mesma informação sem criar uma URI diferente para cada representação. 

O cliente pode declarar preferência:

```http
Accept: application/json
```

ou:

```http
Accept: application/xml
```

Existem duas abordagens discutidas:

```text
Client-driven
Server-driven
```



---

# 15. Linked Service

Problema:

```text
cliente precisa descobrir quais serviços pode chamar depois.
```

Em vez de conhecer todos os endpoints previamente, a representação pode fornecer links.

Modelo:

```json
{
  "id": 123,
  "status": "pending",
  "links": {
    "self": "...",
    "cancel": "...",
    "payment": "..."
  }
}
```

O livro relaciona Linked Service a:

```text
hyperlinks
workflow guidance
URI coupling
adding/removing services
breaking clients
```



### Ideia central

O serviço informa:

```text
"essas são as próximas capacidades disponíveis."
```

em vez de o cliente precisar conhecer toda a topologia do sistema.

---

# 16. Capítulo 4 — Request and Response Management

O objetivo desse capítulo é criar uma camada que **isole o cliente do sistema interno**.

Os padrões são:

```text
Service Controller
Data Transfer Object
Request Mapper
Response Mapper
```



---

# 17. Service Controller

É responsável por receber a requisição e direcioná-la para o serviço correto.

Modelo:

```text
HTTP Request
     |
     v
Service Controller
     |
     +--> URI parsing
     +--> method resolution
     +--> request handler
     +--> routing
     |
     v
Service
```

O índice destaca:

```text
routing expressions
URI templates
URI segments
request handlers
request method designators
web methods
```



### Analogia no Django/DRF

```text
URL router
    ↓
ViewSet / View
    ↓
Service logic
```

O conceito é muito próximo do **Front Controller**.

---

# 18. Data Transfer Object — DTO

Um DTO representa os dados que atravessam a fronteira do serviço.

A ideia é evitar expor diretamente entidades internas.

```text
Domain Model
      |
      | mapping
      v
     DTO
      |
      v
 HTTP
```

O índice relaciona DTOs com:

```text
serialization
deserialization
data binding
data mapping
client-specific DTOs
collections
message format
Tolerant Reader
```



### Exemplo

Não necessariamente:

```python
return UserModel(...)
```

Mas:

```python
UserResponse(
    id=user.id,
    name=user.name,
    email=user.email,
)
```

Assim:

```text
Database Model != Public API Model
```

---

# 19. Data Binding

Data binding automatiza a conversão:

```text
JSON/XML
   ↕
Object
```

Mas existe uma troca:

```text
menos código manual
        VS
mais acoplamento ao formato
```

O PDF destaca preocupações como:

```text
Contract-First vs Code-First
schema validation
proprietary formats
strong coupling to messages
```



---

# 20. Request Mapper

Resolve o problema:

```text
duas entradas diferentes
        ↓
mesmo significado semântico
```

Exemplo:

```json
{
  "customer_id": 10
}
```

vs.

```json
{
  "customer": {
    "id": 10
  }
}
```

Ambas podem significar:

```text
customer = 10
```

O Request Mapper normaliza isso:

```text
External Request
       |
       v
Request Mapper
       |
       v
Internal Request
       |
       v
Domain Logic
```

O livro associa o padrão a:

```text
XSL
JSON
latency
response time
client dependencies
integration
Command Invoker
```



---

# 21. Response Mapper

É o inverso:

```text
Internal Representation
       |
       v
Response Mapper
       |
       v
External Response
```

Pode ser utilizado para permitir que diferentes serviços reutilizem a lógica de construção de respostas.

O índice destaca como preocupações:

```text
client dependencies
integration patterns
linked services
scope of responsibility
work effort
```



---

# 22. Capítulo 5 — Web Service Implementation Styles

O objetivo agora muda:

```text
"Como implementar a lógica do serviço?"
```

Os principais padrões são:

```text
Transaction Script
Datasource Adapter
Operation Script
Command Invoker
Workflow Connector
```



---

# 23. Transaction Script

Modelo simples:

```text
Request
  |
  v
Transaction Script
  |
  +--> validate
  +--> read DB
  +--> modify
  +--> save
  +--> return
```

É uma abordagem rápida para implementar lógica.

O índice mostra que o padrão tem como preocupações:

```text
simplicity
code complexity
long methods
tight coupling
alternative patterns
```



### Quando usar

Quando a operação é relativamente simples e a duplicação de regras ainda não justifica uma arquitetura de domínio mais sofisticada.

---

# 24. Datasource Adapter

Problema:

```text
serviço
   |
   ? como acessar
   |
database
legacy API
file
stored procedure
domain object
```

O Datasource Adapter funciona como adaptador:

```text
Service
  |
  v
Datasource Adapter
  |
  +--> Database
  +--> Legacy API
  +--> File
  +--> Other source
```

A ideia é minimizar o código específico necessário para acessar recursos internos.

O índice relaciona o padrão a:

```text
access privileges
coupling
custom code
domain models
provider assumptions
latency
```



---

# 25. Operation Script

Serve para **reutilizar lógica comum de domínio entre diferentes operações de serviço**.

Modelo:

```text
Endpoint A ----\
                \
Endpoint B ------> Operation Script
                /
Endpoint C ----/
```

Em vez de:

```text
A -> duplicated logic
B -> duplicated logic
C -> duplicated logic
```

temos:

```text
A \
B ---> shared operation logic
C /
```

O índice aponta como problemas importantes:

```text
application logic duplication
IoC
local vs distributed transactions
application gateways
```



---

# 26. Command Invoker

Transforma uma requisição em um comando explícito:

```text
Request
  |
  v
Request Mapper
  |
  v
Command
  |
  v
Command Invoker
  |
  v
Command Handler
```

A principal vantagem é separar:

```text
API
```

de:

```text
execução da ação.
```

O padrão também permite encaminhar comandos para processos em background e reutilizar lógica de domínio entre diferentes APIs. 

### Pense assim

```python
class CreatePaymentCommand: ...


class CreatePaymentHandler:
    def handle(self, command): ...
```

Pode existir:

```text
REST API
Message API
CLI
Background worker
```

todos chamando o mesmo comando.

---

# 27. Workflow Connector

É utilizado quando temos processos:

```text
long-running
complexos
com múltiplas etapas
```

Exemplo:

```text
Create Order
    ↓
Reserve Stock
    ↓
Charge Payment
    ↓
Generate Invoice
    ↓
Send Notification
```

O padrão introduz preocupações como:

```text
control flow
correlation
callback
compensation
long-running process
```



### Ideia importante

Uma workflow não deveria ser vista apenas como:

```text
função gigante
```

Mas como um processo composto por atividades coordenadas.

---

# 28. Capítulo 6 — Web Service Infrastructure

Esse capítulo trata de capacidades reutilizáveis de infraestrutura.

Os padrões são:

```text
Service Connector
Service Descriptor
Asynchronous Response Handler
Service Interceptor
Idempotent Retry
```



---

# 29. Service Connector

É um encapsulador para consumir um serviço remoto.

Sem connector:

```text
Controller
   |
   +--> URL construction
   +--> authentication
   +--> serialization
   +--> HTTP
   +--> timeout
   +--> retry
   +--> deserialization
```

Com connector:

```text
Controller
   |
   v
PaymentServiceConnector
   |
   v
Remote Service
```

O connector abstrai:

```text
URI
connection management
request dispatch
serialization
response handling
service discovery
HTTP methods
retry
```



---

# 30. Service Descriptor

Descreve formalmente como um serviço pode ser utilizado.

Pode conter:

```text
operações
mensagens
tipos
endpoints
contratos
interações
```

É utilizado também para:

```text
documentation
code generation
Service Connector generation
```

O livro cita:

```text
WSDL
WADL
```

como exemplos. 

### Relação

```text
Service Descriptor
       |
       +----> documentação
       |
       +----> tooling
       |
       +----> code generation
       |
       +----> Service Connector
```

---

# 31. Asynchronous Response Handler

Problema:

```text
requisição demora
+
cliente não deveria ficar bloqueado
```

Então:

```text
Client
  |
  | request
  v
Service
  |
  | immediate response / async mechanism
  v
Client continua trabalhando
```

Duas abordagens destacadas no índice:

```text
Polling
Client-Side Callback
```



Exemplo polling:

```text
POST /exports
      ↓
job=123
      ↓
GET /exports/123
      ↓
processing
      ↓
GET /exports/123
      ↓
completed
```

---

# 32. Service Interceptor

Resolve comportamento transversal:

```text
authentication
validation
logging
caching
exception handling
```

Sem interceptor:

```text
Endpoint A -> logging
Endpoint B -> logging
Endpoint C -> logging
```

Com interceptor:

```text
             +--> authentication
Request ---> +--> validation
             +--> logging
             +--> exception handling
             +--> handler
```

O índice mostra exemplos específicos de:

```text
validator interceptor
logger interceptor
exception handler interceptor
```



### Analogia no Django

Pode lembrar:

```text
middleware
decorators
permission classes
exception handlers
```

dependendo da responsabilidade.

---

# 33. Idempotent Retry

Esse é um dos padrões mais importantes para sistemas distribuídos.

Problema:

```text
request
   |
   v
service
   |
   | response lost
   X
client timeout
```

O cliente pensa:

```text
"devo tentar novamente?"
```

Se o retry for feito:

```text
request
request
```

o serviço pode executar duas vezes.

O padrão **Idempotent Retry** trata justamente da entrega/repetição de requisições diante de falhas temporárias. O livro relaciona o padrão a delay, race conditions, crashes e mecanismos de retry management/reliable messaging. 

### Exemplo perigoso

```http
POST /payments
```

retry:

```text
POST /payments
POST /payments
```

Resultado:

```text
2 pagamentos
```

### Necessidade

A operação precisa ser desenhada para tolerar repetição ou possuir alguma forma de deduplicação.

---

# 34. Capítulo 6 — SOA Infrastructure

O PDF ainda lista três componentes clássicos:

```text
Service Registry
Enterprise Service Bus
Orchestration Engine
```



## Service Registry

Resolve:

```text
"onde está o serviço?"
```

## Enterprise Service Bus

Centraliza capacidades como:

```text
routing
message translation
canonical data model
transport mapping
message storage
guaranteed delivery
```

O índice relaciona o ESB exatamente a essas responsabilidades. 

## Orchestration Engine

Executa/controla workflows compostos.

```text
Workflow
   |
   +--> Service A
   |
   +--> Service B
   |
   +--> Service C
```

---

# 35. Capítulo 7 — Web Service Evolution

O problema central:

```text
cliente A
cliente B
cliente C
```

podem evoluir em velocidades diferentes.

O serviço precisa mudar sem quebrar consumidores existentes.

O capítulo trata de:

```text
Breaking Changes
Versioning
Single-Message Argument
Dataset Amendment
Tolerant Reader
Consumer-Driven Contracts
```



---

# 36. Breaking Changes

Segundo o índice, duas categorias são especialmente relevantes:

```text
Structural Changes to Messages/Media Types
Service Descriptor Changes
```



Exemplos:

```json
{
  "name": "Thomas"
}
```

mudar para:

```json
{
  "full_name": "Thomas"
}
```

pode quebrar consumidores.

Outro exemplo:

```text
GET /users/{id}
```

passar a exigir:

```text
GET /users/{uuid}
```

também pode ser incompatível.

---

# 37. Single-Message Argument

Problema:

RPC tradicional:

```text
createUser(name, email, phone, address)
```

A interface possui vários argumentos.

Adicionar:

```text
country
```

pode exigir alteração do contrato.

Single-Message Argument muda para:

```text
createUser(UserRequest)
```

onde:

```json
{
  "name": "...",
  "email": "...",
  "phone": "...",
  "address": "..."
}
```

Agora novos campos podem ser adicionados com mais flexibilidade.

O livro explicitamente descreve esse padrão como uma forma de tornar RPC menos frágil e permitir novos parâmetros ao longo do tempo. 

---

# 38. Dataset Amendment

A ideia é permitir que uma estrutura de dados seja ampliada sem obrigatoriamente quebrar consumidores.

Exemplo:

Versão inicial:

```json
{
  "id": 10,
  "name": "Thomas"
}
```

Depois:

```json
{
  "id": 10,
  "name": "Thomas",
  "phone": "...",
  "address": "..."
}
```

O padrão trata:

```text
optional data
client-specific structures
abstract types
cluttered structures
data binding
```



---

# 39. Tolerant Reader

Esse padrão é extremamente importante para evolução.

O consumidor não precisa quebrar quando recebe informação que não conhece.

Exemplo:

Servidor:

```json
{
  "id": 10,
  "name": "Thomas",
  "phone": "...",
  "nickname": "Tom"
}
```

Cliente antigo conhece apenas:

```text
id
name
```

Um Tolerant Reader interpreta apenas o que entende.

```text
known fields
   ↓
process

unknown fields
   ↓
ignore/preserve as appropriate
```

O índice relaciona o padrão a:

```text
Postel's Law
Robustness Principle
unknown content
DTOs
data access
XML namespaces
forward compatibility
```



---

# 40. Consumer-Driven Contracts

Aqui o contrato não é definido apenas pelo que o fornecedor deseja expor.

Os consumidores ajudam a definir o que realmente precisam.

Modelo:

```text
Consumer
   |
   | expectations/tests
   v
Contract
   ^
   |
Provider
```

O índice destaca:

```text
backward compatibility
forward compatibility
integration tests
documentation
contract versioning
real implementation
stub implementation
```



### Ideia central

Em vez de perguntar:

```text
"Minha API está tecnicamente válida?"
```

pergunte:

```text
"Minha API continua satisfazendo as expectativas reais dos consumidores?"
```

---

# 41. Mapa mental completo

```text
SERVICE DESIGN
│
├── 1. Distributed Systems
│   ├── latency
│   ├── serialization
│   ├── partial failures
│   └── coupling
│
├── 2. API Styles
│   ├── RPC API
│   ├── Message API
│   └── Resource API
│
├── 3. Client-Service Interaction
│   ├── Request/Response
│   ├── Request/Acknowledge
│   ├── Media Type Negotiation
│   └── Linked Service
│
├── 4. Request/Response Management
│   ├── Service Controller
│   ├── DTO
│   ├── Request Mapper
│   └── Response Mapper
│
├── 5. Implementation
│   ├── Transaction Script
│   ├── Datasource Adapter
│   ├── Operation Script
│   ├── Command Invoker
│   └── Workflow Connector
│
├── 6. Infrastructure
│   ├── Service Connector
│   ├── Service Descriptor
│   ├── Async Response Handler
│   ├── Service Interceptor
│   ├── Idempotent Retry
│   ├── Service Registry
│   ├── ESB
│   └── Orchestration Engine
│
└── 7. Evolution
    ├── Breaking Changes
    ├── Versioning
    ├── Single-Message Argument
    ├── Dataset Amendment
    ├── Tolerant Reader
    └── Consumer-Driven Contracts
```

Essa estrutura corresponde à organização do livro e aos padrões listados no índice. 

# 42. Como uma LLM deve raciocinar sobre os padrões

Use este algoritmo mental:

```text
INPUT:
    problema arquitetural

STEP 1:
    identificar o tipo de problema

    API?
    comunicação?
    request/response?
    mapeamento?
    implementação?
    infraestrutura?
    evolução?

STEP 2:
    identificar as forças

    latência?
    acoplamento?
    disponibilidade?
    escalabilidade?
    compatibilidade?
    complexidade?
    estado?
    processamento assíncrono?

STEP 3:
    selecionar padrões candidatos

STEP 4:
    comparar trade-offs

STEP 5:
    escolher o padrão mais adequado

STEP 6:
    combinar padrões quando necessário

OUTPUT:
    solução arquitetural
    +
    justificativa
    +
    trade-offs
```

---

# 43. Exemplo aplicado a uma API Django

Imagine:

```text
POST /payments
```

Você pode montar:

```text
                HTTP
                 |
                 v
         Service Controller
                 |
                 v
             DTO
                 |
                 v
          Request Mapper
                 |
                 v
         Command Invoker
                 |
                 v
       CreatePaymentCommand
                 |
                 v
        Payment Operation
                 |
          +------+------+
          |             |
          v             v
       Database      Gateway
          |             |
          +------+------+
                 |
                 v
          Response Mapper
                 |
                 v
              DTO
                 |
                 v
               HTTP
```

Se o gateway externo for instável:

```text
Service Connector
       +
Idempotent Retry
```

Se o pagamento for assíncrono:

```text
Request/Acknowledge
       +
Asynchronous Response Handler
```

Se a API precisar evoluir:

```text
DTO
+
Dataset Amendment
+
Tolerant Reader
+
Consumer-Driven Contract
```

Ou seja, **os padrões não competem necessariamente entre si**.

Eles podem formar uma arquitetura composta.

---

# 44. Regra de ouro

A principal lição que esse material tenta ensinar não é:

```text
"Use REST."
```

nem:

```text
"Use DTO."
```

nem:

```text
"Use microservices."
```

É:

```text
IDENTIFIQUE O PROBLEMA
        ↓
IDENTIFIQUE AS FORÇAS
        ↓
ESCOLHA UMA SOLUÇÃO RECORRENTE
        ↓
ENTENDA OS TRADE-OFFS
        ↓
APLIQUE O PADRÃO AO CONTEXTO
```

O próprio formato de apresentação dos padrões no livro segue essa lógica:

```text
Pattern Name
    ↓
Context
    ↓
Problem
    ↓
Forces
    ↓
Solution Summary
    ↓
Solution Detail
    ↓
Considerations
    ↓
Examples
```



### Estado do estudo do PDF

O material fornecido sustenta de forma detalhada principalmente o **Capítulo 1**, incluindo Web Services, objetos distribuídos, custos de distribuição, loose coupling e SOA. 

Os demais capítulos e padrões estão claramente identificados no sumário e no índice, mas o arquivo disponível não contém o corpo completo desses capítulos. Portanto, a explicação dos padrões acima é uma **síntese didática baseada no que o PDF efetivamente lista/descreve**, e não uma reprodução integral dos capítulos ausentes. 

Para transformar isso em um material realmente completo, com **Context → Problem → Forces → Solution → Trade-offs → quando usar → quando evitar → exemplo Django/DRF → exemplo de arquitetura**, será necessário o PDF completo da obra.
