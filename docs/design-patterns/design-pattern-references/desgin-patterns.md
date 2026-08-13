# Design Patterns — Guia de Conhecimento Rápido para Agentes de IA

**Arquivo PDF Primário:** [design-patterns.pdf](pdf/design-patterns.pdf)  
**Mapa de Referência de Páginas:** [references-design-patterns.md](references-design-patterns.md)  
**Obra de Origem:** *Padrões de Projeto — Soluções reutilizáveis de software orientado a objetos* (Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides)  

---

## Índice Padronizado para Agentes de IA

### Resolução Rápida por Problema / Sintoma

| Sintoma de Design | Padrão Recomendado | Seção no Markdown |
|---|---|---|
| Incompatibilidade entre interfaces | Adapter | [4.1 Adapter](#41-adapter) |
| Algoritmo ou lógica de cálculo variável | Strategy | [5.9 Strategy](#59-strategy) |
| Objetos criados em múltiplas plataformas/variantes | Abstract Factory | [3.1 Abstract Factory](#31-abstract-factory) |
| Construção de objeto complexo passo a passo | Builder | [3.2 Builder](#32-builder) |
| Tipo concreto decidido por especialização/subclasse | Factory Method | [3.3 Factory Method](#33-factory-method) |
| Objeto configurado de alto custo para criar do zero | Prototype | [3.4 Prototype](#34-prototype) |
| Restrição estrita de instância única | Singleton | [3.5 Singleton](#35-singleton) |
| Duas dimensões independentes (abstração vs implementação) | Bridge | [4.2 Bridge](#42-bridge) |
| Hierarquia de árvore (folhas e contêineres uniformes) | Composite | [4.3 Composite](#43-composite) |
| Adicionar responsabilidades sem criar subclasses | Decorator | [4.4 Decorator](#44-decorator) |
| Simplificar interface para subsistema complexo | Façade | [4.5 Façade](#45-façade) |
| Muitos objetos semelhantes (economia de memória) | Flyweight | [4.6 Flyweight](#46-flyweight) |
| Intermediar ou controlar acesso a objeto | Proxy | [4.7 Proxy](#47-proxy) |
| Encadear múltiplos tratadores de requisição | Chain of Resp. | [5.1 Chain of Responsibility](#51-chain-of-responsibility) |
| Encapsular requisição/operação como objeto (undo/redo) | Command | [5.2 Command](#52-command) |
| Interpretar sintaxe ou gramática simples | Interpreter | [5.3 Interpreter](#53-interpreter) |
| Percorrer coleção sem expor a estrutura interna | Iterator | [5.4 Iterator](#54-iterator) |
| Centralizar comunicação entre muitos objetos | Mediator | [5.5 Mediator](#55-mediator) |
| Salvar e restaurar estado interno (snapshot) | Memento | [5.6 Memento](#56-memento) |
| Notificar múltiplos observadores sobre alterações | Observer | [5.7 Observer](#57-observer) |
| Alterar comportamento dinamicamente conforme estado | State | [5.8 State](#58-state) |
| Esqueleto fixo de algoritmo com etapas abstratas | Template Method | [5.10 Template Method](#510-template-method) |
| Adicionar novas operações sobre estrutura estável | Visitor | [5.11 Visitor](#511-visitor) |

---

Estudei o PDF **Padrões de Projeto — Soluções reutilizáveis de software orientado a objetos**, de Gamma, Helm, Johnson e Vlissides. O livro apresenta **23 padrões**, organizados em criação, estruturais e comportamentais, além de uma introdução aos princípios, um estudo de caso completo com o editor de documentos **Lexi**, critérios para selecionar padrões e uma discussão sobre os trade-offs envolvidos. 

Abaixo está a versão em **linguagem de LLM/Agente**: isto é, não apenas “o que o padrão é”, mas **como reconhecer o problema, como pensar, quando aplicar, quando evitar e com quais padrões relacionar**.

---

# Design Patterns — conhecimento para LLM/Agente

## 0. Modelo mental central

Um agente deve entender primeiro:

> **Design Pattern não é um pedaço de código pronto. É um nome para uma solução recorrente de projeto, contextualizada por um problema, uma estrutura de solução e seus trade-offs.**

O livro define quatro elementos fundamentais:

```text
Pattern
├── Nome
├── Problema
├── Solução
└── Consequências
```

O **nome** cria vocabulário compartilhado; o **problema** define quando a solução é necessária; a **solução** descreve responsabilidades e colaborações de forma abstrata; e as **consequências** apresentam custos, benefícios e trade-offs. 

Para raciocinar como um agente:

```text
Dado um problema de design:

1. Qual mudança provavelmente ocorrerá?
2. O que está fortemente acoplado?
3. Qual responsabilidade está espalhada?
4. Qual algoritmo varia?
5. Qual objeto está sendo criado de forma rígida?
6. Qual interface é incompatível?
7. Qual comportamento precisa ser encapsulado?
8. Qual parte da estrutura precisa permanecer estável?
9. Qual parte precisa variar independentemente?
10. Qual é o custo de introduzir o pattern?
```

A ideia central do livro é **encapsular aquilo que varia**, permitindo que uma parte do sistema mude sem obrigar outras partes a mudar.

---

# 1. Fundamentos que o agente precisa dominar

## 1.1 Programar para interfaces, não implementações

Um objeto deve ser conhecido principalmente por sua **interface**, e não pelos detalhes de implementação.

Isso permite:

```text
Cliente
   ↓
Interface
   ↓
Implementação A
```

ou:

```text
Cliente
   ↓
Interface
   ↓
Implementação B
```

O cliente não precisa saber qual implementação concreta recebeu.

O livro relaciona isso diretamente a **binding dinâmico** e **polimorfismo**: objetos que possuem interfaces compatíveis podem ser substituídos durante a execução. 

### Regra para o agente

Quando encontrar:

```python
if gateway == "pagarme":
    ...
elif gateway == "asaas":
    ...
elif gateway == "stripe":
    ...
```

pergunte:

> “Estou codificando uma implementação específica onde deveria depender de uma abstração?”

Nem todo `if` precisa de Strategy ou Factory. O pattern só faz sentido quando a variação é relevante para o design.

---

# 2. As três famílias

O livro classifica os patterns segundo **finalidade** e **escopo**.

### Por finalidade

```text
Criação
    ↓
Como objetos são criados

Estrutural
    ↓
Como classes/objetos são compostos

Comportamental
    ↓
Como objetos interagem e distribuem responsabilidades
```

### Os 23 patterns

**Criação**

```text
Abstract Factory
Builder
Factory Method
Prototype
Singleton
```

**Estruturais**

```text
Adapter
Bridge
Composite
Decorator
Façade
Flyweight
Proxy
```

**Comportamentais**

```text
Chain of Responsibility
Command
Interpreter
Iterator
Mediator
Memento
Observer
State
Strategy
Template Method
Visitor
```

O catálogo completo e suas páginas aparecem no sumário do livro. 

---

# 3. Padrões de criação

Os patterns de criação abstraem a instanciação. O objetivo é reduzir a dependência direta do sistema em relação às classes concretas que ele cria. 

A pergunta principal é:

> **“Como posso criar objetos sem deixar o restante do sistema preso à implementação concreta?”**

---

## 3.1 Abstract Factory

**Intenção**

Criar **famílias de objetos relacionados ou dependentes**, sem especificar diretamente suas classes concretas. 

### Problema

Imagine:

```text
Sistema
 ├── Button
 ├── Checkbox
 ├── Window
```

Agora existem diferentes plataformas:

```text
Windows
Mac
Linux
```

Você não quer:

```python
if os == "windows":
    WindowsButton()
elif os == "mac":
    MacButton()
```

espalhado pela aplicação.

### Modelo mental

```text
AbstractFactory
      │
      ├── create_button()
      ├── create_checkbox()
      └── create_window()

WindowsFactory
MacFactory
LinuxFactory
```

O cliente conhece apenas a fábrica abstrata.

### Quando pensar nisso

Use quando:

```text
Existe uma família de produtos
+
os produtos precisam ser compatíveis entre si
+
a família pode variar
```

### Exemplo conceitual

```python
class UIFactory:
    def create_button(self): ...

    def create_checkbox(self): ...


class WindowsFactory(UIFactory):
    def create_button(self):
        return WindowsButton()

    def create_checkbox(self):
        return WindowsCheckbox()
```

### Trade-off

Vantagem:

```text
Trocar a família inteira fica fácil.
```

Custo:

```text
Adicionar um novo tipo de produto
pode exigir alterações em todas as factories.
```

O livro destaca que Abstract Factory, Builder e Prototype encapsulam conhecimento sobre classes concretas e escondem como os produtos são criados. 

---

# 3.2 Builder

**Intenção**

Separar a **construção de um objeto complexo** da sua representação. 

### Sinal de alerta

Um objeto precisa de:

```python
User(name, email, phone, address, cpf, ...)
```

e sua construção possui muitos passos ou combinações.

### Modelo mental

```text
Director
   ↓
Builder
   ↓
Produto complexo
```

O Builder permite construir progressivamente:

```python
builder = UserBuilder()

user = builder.name("Thomas").email("...").phone("...").build()
```

### Use quando

```text
Objeto complexo
+
múltiplas etapas
+
diferentes representações
```

### Não confundir com Factory

Factory:

> “Qual objeto devo criar?”

Builder:

> “Como devo construir este objeto?”

No catálogo do livro, Builder é especificamente tratado como um objeto que constrói incrementalmente um produto complexo. 

---

# 3.3 Factory Method

**Intenção**

Definir uma interface para criação de um objeto, mas deixar a decisão da classe concreta para subclasses. 

### Modelo

```text
Creator
   │
   └── create_product()

ConcreteCreatorA → ProductA
ConcreteCreatorB → ProductB
```

Exemplo:

```python
class NotificationService:
    def create_sender(self):
        raise NotImplementedError

    def send(self, message):
        sender = self.create_sender()
        sender.send(message)


class EmailNotification(NotificationService):
    def create_sender(self):
        return EmailSender()


class SmsNotification(NotificationService):
    def create_sender(self):
        return SmsSender()
```

### Pergunta do agente

> “A classe sabe como executar o processo, mas precisa deixar a decisão do objeto concreto para uma especialização?”

Então Factory Method é candidato.

---

# 3.4 Prototype

**Intenção**

Criar novos objetos copiando uma instância prototípica. 

Modelo:

```text
Prototype
   │
   └── clone()
```

O cliente faz:

```python
new_object = prototype.clone()
```

### Quando usar

Particularmente interessante quando:

```text
a configuração do objeto é cara
+
os objetos são altamente configuráveis
+
novos tipos podem ser registrados dinamicamente
```

O livro destaca que Prototype pode permitir adicionar e remover protótipos em tempo de execução. 

### Relação

Prototype e Abstract Factory podem competir entre si.

O próprio livro explica:

```text
Factory Method
→ usa subclasses

Abstract Factory
→ usa uma fábrica de objetos

Prototype
→ usa um objeto protótipo
```



---

# 3.5 Singleton

**Intenção**

Garantir que exista uma única instância de uma classe e fornecer acesso a ela. 

Modelo:

```text
Client
  ↓
Singleton
  ↓
única instância
```

### Pergunta correta

Não:

> “Posso usar global?”

Mas:

> “O domínio realmente exige uma única instância?”

O pattern existe para representar uma restrição arquitetural de unicidade, não simplesmente como substituto de variáveis globais.

O livro observa também que vários outros patterns podem ser implementados usando Singleton. 

---

# 4. Padrões estruturais

Pense:

> **“Como posso combinar objetos/classes sem criar dependências rígidas?”**

---

# 4.1 Adapter

**Intenção**

Converter a interface de uma classe para a interface esperada pelo cliente. 

### Problema

Você possui:

```python
PagarmeClient.create_payment()
```

mas sua aplicação espera:

```python
PaymentGateway.pay()
```

Adapter:

```text
Application
     ↓
PaymentGateway
     ↓
PagarmeAdapter
     ↓
PagarmeClient
```

### Quando pensar

> “Tenho duas coisas que deveriam trabalhar juntas, mas suas interfaces são incompatíveis.”

### Adapter vs Bridge

Essa distinção é importante:

```text
Adapter
→ adapta algo que já existe.

Bridge
→ é projetado desde o início para separar abstração e implementação.
```

O livro enfatiza exatamente essa diferença. 

---

# 4.2 Bridge

**Intenção**

Separar uma abstração da sua implementação para que ambas possam variar independentemente. 

Modelo:

```text
Abstraction
     ↓
Implementation
```

Exemplo conceitual:

```text
Notification
├── Email
├── SMS
└── Push

Transport
├── Twilio
├── AWS
└── Firebase
```

Em vez de criar:

```text
EmailTwilio
EmailAWS
EmailFirebase
SmsTwilio
SmsAWS
SmsFirebase
...
```

separa-se:

```text
Notification
      ↓
Transport
```

O estudo do Lexi usa exatamente essa ideia para separar a abstração `Window` da implementação `WindowImp`, permitindo múltiplos sistemas de janelas. 

---

# 4.3 Composite

**Intenção**

Representar estruturas de árvore e permitir que o cliente trate objetos individuais e composições uniformemente. 

Modelo:

```text
Component
 ├── Leaf
 └── Composite
       ├── Leaf
       ├── Leaf
       └── Composite
```

Exemplo:

```text
Folder
├── File
├── File
└── Folder
    ├── File
    └── File
```

O cliente pode fazer:

```python
component.render()
```

sem precisar saber se é:

```text
File
```

ou:

```text
Folder
```

O livro destaca que essa uniformização simplifica o cliente, embora possa deixar a estrutura excessivamente genérica. 

### Sinal

Se você vê:

```text
objeto
  └── objeto
       └── objeto
            └── objeto
```

pense:

> Composite.

---

# 4.4 Decorator

**Intenção**

Adicionar responsabilidades a um objeto dinamicamente, fornecendo uma alternativa flexível a subclasses. 

Modelo:

```text
Component
   ↑
Decorator
   ↑
ConcreteDecorator
```

Exemplo:

```python
service = LoggingService(MetricsService(PaymentService()))
```

Cada decorator pode adicionar comportamento.

### Pergunta

> “Quero adicionar capacidades sem criar dezenas de subclasses?”

Pense em Decorator.

---

# 4.5 Façade

**Intenção**

Fornecer uma interface simples para um subsistema complexo. 

Exemplo:

```python
checkout.process_order(order)
```

por trás:

```text
validate_order()
reserve_stock()
calculate_tax()
charge_payment()
generate_invoice()
send_email()
```

O cliente não precisa conhecer o subsistema inteiro.

### Regra

Façade:

```text
complexidade interna
        ↓
interface simples
```

Não necessariamente adiciona comportamento; ele **simplifica acesso**.

---

# 4.6 Flyweight

**Intenção**

Compartilhar objetos de granularidade fina para suportar grandes quantidades deles de maneira eficiente. 

O conceito central:

```text
Estado intrínseco
→ compartilhável

Estado extrínseco
→ fornecido pelo contexto
```

Exemplo:

```text
1.000.000 caracteres
```

não significa necessariamente:

```text
1.000.000 objetos independentes
```

O livro relata um caso em que um documento com **180 mil caracteres** utilizou apenas **480 objetos-caractere** através do compartilhamento. 

### Use quando

```text
muitos objetos
+
alto custo de memória
+
grande parte do estado pode ser compartilhada
```

---

# 4.7 Proxy

**Intenção**

Fornecer um substituto para outro objeto e controlar seu acesso. 

Tipos conceituais:

```text
Proxy
├── Virtual Proxy
├── Protection Proxy
├── Remote Proxy
├── Smart Proxy
...
```

Exemplo:

```text
Client
  ↓
ImageProxy
  ↓
HeavyImage
```

O Proxy pode atrasar:

```python
HeavyImage.load()
```

até que realmente seja necessário.

### Pergunta

> “Preciso controlar o acesso a um objeto sem mudar o código de quem o usa?”

Proxy é candidato.

---

# 5. Padrões comportamentais

Aqui a pergunta muda:

> **“Como responsabilidades e comportamentos são distribuídos entre objetos?”**

O livro enfatiza que muitos desses patterns encapsulam **variações de comportamento**. Strategy encapsula algoritmos; State encapsula comportamento dependente de estado; Mediator encapsula protocolos de interação; Iterator encapsula a forma de percorrer um agregado. 

---

# 5.1 Chain of Responsibility

**Intenção**

Passar uma solicitação por uma cadeia de objetos até que algum objeto possa tratá-la. 

Modelo:

```text
Request
  ↓
Handler A
  ↓
Handler B
  ↓
Handler C
```

Exemplo:

```text
Middleware 1
    ↓
Middleware 2
    ↓
Middleware 3
    ↓
View
```

### Benefício

Reduz acoplamento:

```text
sender
não precisa conhecer
receiver específico
```

Mas há um trade-off importante:

> **A solicitação pode não ser tratada.**

O livro destaca isso explicitamente. 

---

# 5.2 Command

**Intenção**

Transformar uma solicitação em um objeto. 

Isso permite:

```text
request
→ armazenar
→ enfileirar
→ executar
→ registrar
→ desfazer
→ refazer
```

Modelo:

```text
Invoker
   ↓
Command
   ↓
Receiver
```

Exemplo:

```python
class DeleteUserCommand:
    def execute(self): ...
```

Você pode colocar o command em:

```python
history.append(command)
```

e depois:

```python
command.undo()
```

O estudo de caso do Lexi utiliza Command exatamente para desacoplar a interface do usuário da funcionalidade espalhada pela aplicação e permitir undo/redo. 

---

# 5.3 Interpreter

**Intenção**

Representar uma gramática e definir um interpretador para suas sentenças. 

Modelo:

```text
Expression
├── TerminalExpression
└── NonTerminalExpression
```

Exemplo:

```text
"idade > 18 AND ativo == true"
```

poderia ser transformado em uma árvore:

```text
AND
├── idade > 18
└── ativo == true
```

### Use quando

```text
Existe uma linguagem pequena
+
gramática relativamente simples
+
precisa interpretar expressões
```

Não é a solução genérica para todo parser.

---

# 5.4 Iterator

**Intenção**

Acessar sequencialmente elementos de uma coleção sem expor sua representação interna. 

Em Python:

```python
for item in collection:
    ...
```

é extremamente natural pensar nesse conceito.

O cliente precisa saber:

```text
next()
has_next()
```

mas não precisa saber se o agregado é:

```text
array
list
tree
graph
database cursor
```

---

# 5.5 Mediator

**Intenção**

Encapsular a forma como diversos objetos interagem. 

Sem Mediator:

```text
A ↔ B
A ↔ C
A ↔ D
B ↔ C
B ↔ D
C ↔ D
```

O acoplamento cresce muito.

Com Mediator:

```text
A ─┐
B ─┤
C ─┼── Mediator
D ─┘
```

Os objetos deixam de conhecer diretamente uns aos outros.

### Sinal

> “Tenho muitas classes conversando diretamente umas com as outras?”

Pense Mediator.

---

# 5.6 Memento

**Intenção**

Capturar e externalizar um estado interno sem violar encapsulamento, permitindo restaurá-lo depois. 

Modelo:

```text
Originator
   ↓
 Memento
   ↓
restore()
```

Exemplo:

```text
Editor
  ↓ save()
Memento
  ↓
Editor.restore(memento)
```

É muito útil para:

```text
undo
snapshots
rollback
checkpoint
```

---

# 5.7 Observer

**Intenção**

Estabelecer uma dependência um-para-muitos: quando o objeto observado muda, seus dependentes são notificados. 

Modelo:

```text
Subject
 ├── Observer A
 ├── Observer B
 └── Observer C
```

Exemplo:

```text
Order
 ├── EmailNotifier
 ├── Analytics
 └── Inventory
```

Quando:

```python
order.confirm()
```

os observadores recebem a alteração.

O livro mostra esse padrão dentro do MVC: várias Views dependem do mesmo Model e são atualizadas quando o Model muda. 

---

# 5.8 State

**Intenção**

Permitir que um objeto altere seu comportamento quando seu estado interno muda, parecendo mudar de classe. 

Sem State:

```python
if status == "pending":
    ...
elif status == "paid":
    ...
elif status == "cancelled":
    ...
```

Com State:

```text
Order
  ↓
OrderState
├── PendingState
├── PaidState
└── CancelledState
```

O comportamento passa para objetos de estado.

### Pergunta

> “O objeto possui muitos comportamentos condicionados ao estado atual?”

State é candidato.

---

# 5.9 Strategy

**Intenção**

Definir uma família de algoritmos, encapsulá-los e torná-los intercambiáveis. 

Modelo:

```text
Context
   ↓
Strategy
├── StrategyA
├── StrategyB
└── StrategyC
```

Exemplo muito próximo do mundo backend:

```python
class PaymentStrategy:
    def pay(self, amount): ...


class PagarmeStrategy(PaymentStrategy): ...


class AsaasStrategy(PaymentStrategy): ...


class StripeStrategy(PaymentStrategy): ...
```

O contexto não precisa saber como cada algoritmo funciona.

O estudo de caso do Lexi utiliza Strategy para permitir que algoritmos diferentes de formatação sejam substituídos sem alterar a estrutura dos documentos. 

### Strategy vs State

São parecidos estruturalmente:

```text
Context
   ↓
objeto delegado
```

Mas a intenção muda:

```text
Strategy
→ escolhe algoritmo

State
→ representa estado atual
```

---

# 5.10 Template Method

**Intenção**

Definir o esqueleto de um algoritmo e deixar determinados passos para subclasses. 

Modelo:

```python
class Importer:
    def import_data(self):
        self.open()
        self.parse()
        self.close()

    def open(self): ...

    def parse(self): ...

    def close(self): ...
```

A estrutura permanece:

```text
open
→ parse
→ close
```

mas subclasses redefinem etapas.

### Strategy vs Template Method

```text
Template Method
→ usa herança

Strategy
→ usa composição/delegação
```

Essa diferença é fundamental.

---

# 5.11 Visitor

**Intenção**

Representar uma operação que deve ser executada sobre elementos de uma estrutura, permitindo adicionar operações sem modificar as classes desses elementos. 

Imagine:

```text
Document
├── Paragraph
├── Image
├── Table
└── Text
```

Hoje você quer:

```text
spell_check
```

Amanhã:

```text
word_count
export_pdf
export_html
statistics
```

Em vez de colocar tudo em cada classe:

```text
Paragraph
Image
Table
Text
```

cria-se:

```text
Visitor
├── SpellCheckVisitor
├── HtmlVisitor
├── PdfVisitor
└── StatisticsVisitor
```

### Visitor vs Iterator

```text
Iterator
→ como percorrer

Visitor
→ o que fazer nos elementos
```

O livro destaca que Visitor combina naturalmente com Composite para operar sobre estruturas hierárquicas. 

---

# 6. O estudo de caso Lexi

Esse é um dos pontos mais importantes do livro porque mostra que patterns surgem de **problemas de design**, não da vontade de “usar patterns”.

O editor Lexi precisa resolver problemas como:

```text
1. Estrutura do documento
2. Formatação
3. Adornos da interface
4. Diferentes look-and-feel
5. Diferentes sistemas de janelas
6. Operações do usuário
7. Undo/redo
8. Spell-check e hifenização
```



O estudo usa oito patterns importantes:

```text
Composite
Strategy
Decorator
Abstract Factory
Bridge
Command
Iterator
Visitor
```

O próprio livro resume esses usos. 

### Mapeamento mental

```text
Estrutura hierárquica
        ↓
    Composite

Algoritmo de formatação
        ↓
     Strategy

Adornos da UI
        ↓
    Decorator

Look-and-feel
        ↓
 Abstract Factory

Sistemas de janelas
        ↓
      Bridge

Operações do usuário
        ↓
     Command

Percorrer documento
        ↓
     Iterator

Novas análises
        ↓
     Visitor
```

Esse é um excelente exemplo de como **um sistema real utiliza vários patterns simultaneamente**.

---

# 7. Como identificar patterns pelo problema

Um agente deve fazer o diagnóstico inverso.

## “Quero criar objetos sem depender de classes concretas”

Considere:

```text
Factory Method
Abstract Factory
Prototype
```

O livro associa explicitamente esses patterns ao problema de criar objetos indiretamente. 

---

## “Tenho algoritmos que variam”

Considere:

```text
Strategy
Template Method
Builder
Iterator
Visitor
```

O livro associa dependências algorítmicas exatamente a esse grupo. 

---

## “Tenho plataforma/implementação que varia”

Considere:

```text
Abstract Factory
Bridge
```



---

## “Tenho objeto complexo demais para o cliente conhecer”

Considere:

```text
Façade
```

---

## “Tenho interfaces incompatíveis”

Considere:

```text
Adapter
```

---

## “Tenho estrutura árvore”

Considere:

```text
Composite
```

---

## “Quero adicionar funcionalidades sem subclasses”

Considere:

```text
Decorator
```

---

## “Tenho objetos demais e memória demais”

Considere:

```text
Flyweight
```

---

## “Preciso controlar acesso”

Considere:

```text
Proxy
```

---

## “Muitos objetos precisam reagir a mudanças”

Considere:

```text
Observer
```

---

## “Muitas classes estão conversando diretamente”

Considere:

```text
Mediator
```

---

## “Preciso transformar uma solicitação em objeto”

Considere:

```text
Command
```

---

## “Preciso desfazer estado”

Considere:

```text
Memento
```

ou:

```text
Command + Memento
```

Dependendo do problema.

---

## “O comportamento muda conforme o estado”

Considere:

```text
State
```

---

## “Existe uma cadeia de possíveis responsáveis”

Considere:

```text
Chain of Responsibility
```

---

## “Existe uma pequena linguagem”

Considere:

```text
Interpreter
```

---

## “Preciso aplicar operações diferentes sobre uma estrutura”

Considere:

```text
Visitor
```

---

# 8. Uma regra extremamente importante do livro

O livro não recomenda perguntar:

> “Qual pattern eu posso colocar aqui?”

A pergunta correta é:

> **“Qual aspecto do projeto precisa variar?”**

O capítulo de seleção recomenda justamente partir das causas de redesign ou dos aspectos que você deseja alterar sem redesenhar o restante do sistema. 

Esse conceito pode ser transformado em algoritmo mental:

```text
PROBLEMA
   ↓
O que muda?
   ↓
Isole a variação
   ↓
Defina uma abstração
   ↓
Escolha uma colaboração
   ↓
Avalie trade-offs
```

---

# 9. Como escolher um pattern

O livro propõe várias estratégias:

```text
1. Entender como patterns solucionam problemas
2. Ler a intenção dos patterns
3. Estudar relações entre patterns
4. Comparar patterns de finalidade semelhante
5. Identificar causas de redesign
6. Identificar o que precisa variar
```



Portanto, um agente não deveria retornar:

> “Use Strategy porque é um design pattern comum.”

Deveria retornar algo próximo de:

> “O problema possui vários algoritmos que precisam ser intercambiáveis. A variação está no algoritmo, não no contexto. Strategy encapsula essa variação e permite trocar a implementação sem alterar o cliente. Entretanto, se a variação for estrutural ou estiver relacionada ao estado interno da entidade, State pode ser mais apropriado.”

Essa é a mentalidade que o livro tenta ensinar.

---

# 10. Como aplicar um pattern

O livro apresenta um procedimento de sete passos.

```text
1. Leia o pattern inteiro
2. Verifique Aplicabilidade e Consequências
3. Estude Estrutura, Participantes e Colaborações
4. Analise o exemplo de código
5. Dê nomes específicos ao domínio
6. Defina operações específicas da aplicação
7. Implemente responsabilidades e colaborações
```

 

Para uma LLM:

```text
NÃO:
"Aplicar Strategy."

SIM:
"Identificar qual comportamento varia,
encapsular o comportamento em uma abstração,
definir implementações intercambiáveis,
injetar a estratégia no contexto,
avaliar custo estrutural,
e somente então implementar."
```

---

# 11. Relações que um agente deve memorizar

## Factory Method × Abstract Factory × Prototype

```text
Factory Method
→ criação por herança

Abstract Factory
→ família de objetos

Prototype
→ criação por cópia
```

O livro trata esses três como alternativas importantes para parametrizar a criação. 

---

## Adapter × Bridge × Decorator

```text
Adapter
→ muda interface

Bridge
→ separa abstração de implementação

Decorator
→ adiciona responsabilidade
```

A estrutura pode parecer semelhante, mas a **intenção** é diferente. O livro chama atenção justamente para essa distinção. 

---

## Strategy × State

```text
Strategy
→ algoritmo escolhido

State
→ comportamento determinado pelo estado
```

---

## Composite × Visitor

```text
Composite
→ estrutura hierárquica

Visitor
→ operações sobre essa estrutura
```

---

## Command × Memento

```text
Command
→ representa a ação

Memento
→ representa o estado
```

Podem ser combinados para implementar undo/redo.

O índice do livro inclusive registra explicitamente a combinação entre Memento e Command. 

---

## Composite × Iterator

```text
Composite
→ estrutura

Iterator
→ percurso
```

O livro mostra essa relação explicitamente. 

---

## Composite × Chain of Responsibility

Um pai da hierarquia Composite pode atuar como sucessor na Chain of Responsibility. 

---

# 12. O princípio mais profundo

Uma maneira muito boa de internalizar o livro é:

```text
Não projete pensando nos objetos primeiro.

Projete pensando nas VARIAÇÕES.
```

Pergunte:

```text
O que muda?

O que provavelmente vai mudar?

O que eu quero poder trocar?

O que está acoplado a essa mudança?

Qual responsabilidade deveria ser extraída?

Qual abstração pode representar essa variação?
```

Isso explica por que tantos patterns parecem diferentes, mas possuem a mesma filosofia.

---

# 13. Os 23 patterns em uma frase

| Pattern                     | Pergunta mental                                           |
| --------------------------- | --------------------------------------------------------- |
| **Abstract Factory**        | Como criar famílias compatíveis de objetos?               |
| **Builder**                 | Como construir um objeto complexo passo a passo?          |
| **Factory Method**          | Como deixar subclasses decidirem o produto?               |
| **Prototype**               | Como criar novos objetos clonando protótipos?             |
| **Singleton**               | Como garantir uma única instância?                        |
| **Adapter**                 | Como fazer interfaces incompatíveis trabalharem juntas?   |
| **Bridge**                  | Como separar abstração e implementação?                   |
| **Composite**               | Como tratar árvore e elementos individuais uniformemente? |
| **Decorator**               | Como adicionar responsabilidades dinamicamente?           |
| **Façade**                  | Como simplificar um subsistema complexo?                  |
| **Flyweight**               | Como reduzir memória através de compartilhamento?         |
| **Proxy**                   | Como controlar acesso a outro objeto?                     |
| **Chain of Responsibility** | Quem deve tratar esta solicitação?                        |
| **Command**                 | Como transformar uma solicitação em objeto?               |
| **Interpreter**             | Como interpretar uma pequena linguagem?                   |
| **Iterator**                | Como percorrer uma coleção sem expor sua estrutura?       |
| **Mediator**                | Como reduzir comunicação direta entre muitos objetos?     |
| **Memento**                 | Como salvar/restaurar estado sem quebrar encapsulamento?  |
| **Observer**                | Como notificar vários dependentes sobre mudanças?         |
| **State**                   | Como mudar comportamento conforme o estado?               |
| **Strategy**                | Como trocar algoritmos?                                   |
| **Template Method**         | Como fixar o fluxo e variar etapas?                       |
| **Visitor**                 | Como adicionar operações sem modificar os elementos?      |

As intenções acima correspondem ao catálogo do próprio livro. 

---

# 14. O que o livro NÃO quer que você conclua

O livro não apresenta patterns como uma receita para transformar qualquer código em uma arquitetura cheia de abstrações.

Ele deixa claro que:

```text
Pattern ≠ código pronto
Pattern ≠ framework
Pattern ≠ arquitetura completa
Pattern ≠ solução universal
```

Patterns são menores e mais abstratos do que frameworks; um framework pode conter vários patterns, enquanto um pattern precisa ser implementado novamente em cada aplicação. 

Além disso, os autores deixam explícito que os 23 patterns cobrem apenas uma fração do conhecimento de um especialista e não constituem uma “linguagem completa” capaz de gerar uma aplicação passo a passo. 

---

# 15. Conhecimento operacional para um Agente de IA

Uma LLM treinada com este material deveria seguir aproximadamente esta política:

```text
Quando analisar um problema de software:

1. Identifique os objetos e responsabilidades.
2. Identifique dependências.
3. Identifique aquilo que varia.
4. Identifique possíveis mudanças futuras.
5. Determine onde o acoplamento está alto.
6. Procure uma abstração para a variação.
7. Considere patterns candidatos.
8. Compare patterns parecidos.
9. Avalie benefícios e custos.
10. Só então recomende um pattern.
11. Explique por que o pattern se aplica.
12. Explique por que os outros candidatos são menos adequados.
13. Não introduza um pattern apenas por preferência estética.
14. Preserve simplicidade quando a variação não justificar abstração.
```

Esse raciocínio está alinhado com a filosofia central do livro: **patterns são ferramentas para preservar flexibilidade e reutilização diante de mudanças**, e não objetivos em si mesmos. 

---

# 16. Ordem de estudo recomendada pelo próprio livro

Para alguém que ainda está consolidando orientação a objetos, os autores recomendam começar por:

```text
1. Abstract Factory
2. Adapter
3. Composite
4. Decorator
5. Factory Method
6. Observer
7. Strategy
8. Template Method
```

Eles consideram esse subconjunto particularmente útil para compreender tanto os patterns quanto o bom design orientado a objetos. 

Para aprender como **engenheiro**, porém, eu organizaria mentalmente assim:

```text
FUNDAMENTOS
    ↓
Interfaces
Polimorfismo
Composição
Encapsulamento
Acoplamento
Coesão
    ↓
CRIAÇÃO
    ↓
Factory Method
Abstract Factory
Builder
Prototype
    ↓
ESTRUTURAL
    ↓
Adapter
Decorator
Composite
Facade
Bridge
Proxy
Flyweight
    ↓
COMPORTAMENTAL
    ↓
Strategy
Observer
Command
State
Template Method
Chain
Mediator
Iterator
Memento
Visitor
Interpreter
    ↓
COMBINAÇÃO DE PATTERNS
    ↓
Arquitetura real
```

---

## A principal ideia para guardar

> **Não memorize 23 classes de diagramas. Memorize 23 problemas.**

Por exemplo:

```text
"Interfaces incompatíveis?"
→ Adapter

"Algoritmo variável?"
→ Strategy

"Comportamento dependente do estado?"
→ State

"Solicitação como objeto?"
→ Command

"Objeto precisa notificar vários?"
→ Observer

"Árvore?"
→ Composite

"Responsabilidades adicionais?"
→ Decorator

"Família de objetos?"
→ Abstract Factory

"Construção complexa?"
→ Builder

"Abstração e implementação variando?"
→ Bridge
```

Quando você consegue reconhecer **o problema sem precisar lembrar o nome do pattern**, você começou a entender Design Patterns de verdade.

E essa é justamente a mudança de mentalidade que o livro pretende provocar: projetistas experientes não precisam reinventar uma solução do zero para cada problema; eles reconhecem estruturas recorrentes e reutilizam conhecimento de projetos anteriores. 
