# Refactoring Guru — Guia de Conhecimento Rápido para Agentes de IA

**Arquivo PDF Primário:** [design-pattern-refactoring-guru.pdf](pdf/design-pattern-refactoring-guru.pdf)  
**Mapa de Referência de Páginas:** [references-desing-pattern-refactoring-guru.md.md](references-desing-pattern-refactoring-guru.md.md)  
**Obra de Origem:** *Mergulho nos Padrões de Projeto* (Alexander Shvets — Refactoring.Guru)  

---

## Índice Padronizado para Agentes de IA

### Resolução Rápida por Problema / Sintoma

| Sintoma de Design | Padrão Recomendado | Seção no Markdown |
|---|---|---|
| Subclasses precisam decidir o produto concreto | Factory Method | [9.1 Factory Method](#91-factory-method) |
| Famílias de produtos coerentes/compatíveis | Abstract Factory | [10. Abstract Factory](#10-abstract-factory) |
| Construção de objeto complexo passo a passo | Builder | [11. Builder](#11-builder) |
| Clonagem de objeto modelo/protótipo existente | Prototype | [12. Prototype](#12-prototype) |
| Acesso global a uma única instância de classe | Singleton | [13. Singleton](#13-singleton) |
| Adaptação de interfaces de bibliotecas legadas | Adapter | [15. Adapter](#15-adapter) |
| Separação de hierarquias de abstração e plataforma | Bridge | [16. Bridge](#16-bridge) |
| Estrutura hierárquica em árvore (folhas e compostos) | Composite | [17. Composite](#17-composite) |
| Agregar comportamentos sem acoplamento de herança | Decorator | [18. Decorator](#18-decorator) |
| Ponto único de entrada simplificado para subsistema | Facade | [19. Facade](#19-facade) |
| Compartilhamento de estado imutável para economia de RAM | Flyweight | [20. Flyweight](#20-flyweight) |
| Controle de acesso, cache ou lazy loading | Proxy | [21. Proxy](#21-proxy) |
| Enfileiramento/Passagem de pedido por cadeia de handlers | Chain of Resp. | [23. Chain of Responsibility](#23-chain-of-responsibility) |
| Desacoplamento entre emissor e receptor de comandos | Command | [24. Command](#24-command) |
| Percorrer coleções mantendo o encapsulamento | Iterator | [25. Iterator](#25-iterator) |
| Redução do acoplamento direto entre dezenas de classes | Mediator | [26. Mediator](#26-mediator) |
| Captura de snapshot de estado para desfazer ações | Memento | [27. Memento](#27-memento) |
| Notificação de eventos em tempo real para assinantes | Observer | [28. Observer](#28-observer) |
| Mudança de comportamento baseada em máquina de estados | State | [29. State](#29-state) |
| Encapsulamento e troca de algoritmos em runtime | Strategy | [30. Strategy](#30-strategy) |
| Algoritmo com esqueleto fixo e etapas customizáveis | Template Method | [31. Template Method](#31-template-method) |
| Adicionar algoritmos sobre estrutura de objetos estável | Visitor | [32. Visitor](#32-visitor) |

---

Estudei o PDF inteiro como base de conhecimento. O material segue uma progressão bem definida: primeiro POO, depois princípios de projeto, SOLID e finalmente os 22 padrões GoF divididos em criacionais, estruturais e comportamentais. O próprio livro recomenda entender esses fundamentos antes dos padrões, e usa pseudocódigo para manter os conceitos independentes de linguagem.

Abaixo está a transformação do conteúdo para uma **linguagem de LLM/Agente**, pensada para que um agente consiga **ensinar, diagnosticar problemas de design e indicar padrões sem simplesmente decorar nomes**.

---

# 1. Modelo mental do Agente

O agente deve aprender primeiro esta regra:

> **Não procure um padrão pelo nome. Procure o problema que o padrão resolve.**

Um padrão de projeto não é uma biblioteca nem um trecho de código pronto. É uma descrição de alto nível de uma solução recorrente. A mesma solução pode resultar em códigos bastante diferentes dependendo do sistema.

O agente deve raciocinar nesta sequência:

```text
PROBLEMA
   ↓
O que está variando?
   ↓
Onde está o acoplamento?
   ↓
Que responsabilidade está misturada?
   ↓
Qual mudança futura provavelmente quebrará o código?
   ↓
Que abstração pode isolar essa mudança?
   ↓
Qual padrão representa essa solução?
   ↓
Quais são os custos da solução?
```

Também deve lembrar que os padrões do livro são divididos em:

```text
CRIACIONAIS
    → preocupação: COMO criar objetos?

ESTRUTURAIS
    → preocupação: COMO combinar objetos/classes?

COMPORTAMENTAIS
    → preocupação: COMO objetos se comunicam
      e distribuem responsabilidades?
```

Essa classificação é exatamente a estrutura adotada pelo livro.

---

# 2. Fundamentos de POO

Antes dos padrões, o agente precisa dominar o vocabulário.

## 2.1 Classe vs. objeto

```text
Classe = molde
Objeto = instância concreta do molde
```

Uma classe define:

```text
ESTADO
    atributos/campos

COMPORTAMENTO
    métodos
```

Exemplo mental:

```text
Classe: Gato

estado:
    nome
    idade
    cor

comportamento:
    comer()
    dormir()
    miar()
```

`Tom` é um objeto da classe `Gato`.

O livro apresenta exatamente essa relação entre classe, objeto, estado e comportamento. 

---

# 3. Os quatro pilares da POO

## 3.1 Abstração

```text
Abstração = representar apenas o que é relevante
para determinado contexto.
```

Não modele o objeto do mundo real inteiro.

Modele apenas aquilo que importa para o sistema.

Exemplo:

```text
Sistema de passagem aérea:

Avião
    assentos
    reserva de assento()
```

Um simulador de voo provavelmente precisaria de:

```text
velocidade
altitude
ângulo de inclinação
motor
combustível
...
```

Portanto:

```text
mesmo objeto real
      ↓
modelos diferentes
      ↓
dependendo do contexto
```

O livro define abstração como um modelo limitado a um contexto específico, representando detalhes relevantes e omitindo os demais. 

---

## 3.2 Encapsulamento

```text
Encapsulamento = esconder detalhes internos
e expor apenas uma interface controlada.
```

Pense em um carro:

```text
Você chama:

ligar()

Você NÃO precisa conhecer:

injeção
combustível
velas
motor de partida
combustão
...
```

A classe controla seu próprio estado.

O restante do sistema interage através de uma interface limitada. 

**Insight para o agente:**

```text
Quanto mais código externo precisa conhecer
dos detalhes internos de uma classe,
maior tende a ser o acoplamento.
```

---

## 3.3 Herança

```text
Animal
 ├── Gato
 └── Cachorro
```

A subclasse herda estado e comportamento da superclasse e pode especializar alguns comportamentos.

A ideia é:

```text
Gato É UM Animal
Cachorro É UM Animal
```

O problema surge quando a herança tenta representar várias dimensões de variação.

Exemplo:

```text
Carro
 ├── elétrico
 ├── gasolina
 ├── manual
 ├── automático
 ├── caminhão
 └── ...
```

As combinações podem explodir.

O livro usa justamente esse problema para motivar composição. 

---

## 3.4 Polimorfismo

```text
Animal a
```

O código pode não saber se `a` é:

```text
Gato
Cachorro
```

mas pode executar:

```text
a.produzirSom()
```

e o objeto concreto determina a implementação.

```text
Animal
   ↓
Gato → Miau
Cão  → Au
```

Essa é a ideia central do polimorfismo descrita no livro.

---

# 4. Relações entre objetos

O agente precisa distinguir muito bem:

```text
DEPENDÊNCIA
ASSOCIAÇÃO
AGREGAÇÃO
COMPOSIÇÃO
IMPLEMENTAÇÃO
HERANÇA
```

## Dependência

```text
A depende de B
```

Alterar B pode exigir alteração em A.

É a relação mais fraca.

Exemplo:

```python
def ensinar(curso: Curso): ...
```

`Professor` depende de `Curso`.

O livro recomenda enfraquecer dependências usando interfaces/abstrações em vez de classes concretas.

## Associação

```text
A conhece B
```

Normalmente existe uma referência persistente.

```python
class Professor:
    aluno: Aluno
```

O `Professor` mantém acesso ao `Aluno`.

## Agregação

```text
A tem B
B pode existir sem A
```

Exemplo:

```text
Departamento
    ├── Professor
    ├── Professor
```

Um professor pode continuar existindo independentemente do departamento.

## Composição

```text
A é composto por B
A controla o ciclo de vida de B
B não existe independentemente de A
```

O UML usa diamante vazio para agregação e preenchido para composição. 

## Regra mental

```text
A depende de B
        ↓
A conhece B
        ↓
A possui B
        ↓
A gerencia a vida de B
        ↓
A implementa B
        ↓
A herda de B
```

O livro apresenta justamente essa progressão da relação mais fraca para a mais forte. 

---

# 5. Princípios gerais de projeto

## 5.1 Encapsule o que varia

A pergunta do agente deve ser:

> "O que provavelmente vai mudar?"

Depois:

```text
o que muda?
    ↓
isole
    ↓
o resto permanece estável
```

Exemplo:

```python
def get_order_total(order):
    total = calculate_items(order)

    if country == "US":
        ...
    elif country == "EU":
        ...
```

Problema:

```text
cálculo do pedido
+
regra tributária
```

estão misturados.

Melhor:

```python
total = calculate_items(order)
total += total * get_tax_rate(order.country)
```

A lógica variável fica isolada. O objetivo explícito é minimizar o impacto das mudanças.

---

# 6. Programe para uma interface, não para uma implementação

A pergunta do agente:

> "O cliente realmente precisa conhecer a classe concreta?"

Preferível:

```text
Cliente
   ↓
Interface
   ↑
Implementação A
Implementação B
Implementação C
```

em vez de:

```text
Cliente
   ↓
ClasseConcreta
```

O livro mostra a sequência:

```text
1. descobrir quais métodos são necessários
2. criar uma interface
3. fazer a dependência implementar a interface
4. fazer o cliente depender da interface
```

Isso aumenta a flexibilidade, embora também aumente a complexidade inicial.

---

# 7. Prefira composição sobre herança

Regra mental:

```text
Herança:
    "é um"

Composição:
    "tem um"
```

Exemplo:

```text
Carro
   └── Motor
```

em vez de tentar criar uma grande hierarquia para cada combinação possível.

Composição também permite substituir comportamentos durante a execução.

Isso é uma das ideias mais importantes do livro porque muitos dos padrões estruturais e comportamentais dependem de **delegação + composição**.

---

# 8. SOLID

O livro deixa claro que SOLID não deve ser tratado como dogma: aplicar todos os princípios indiscriminadamente pode tornar um sistema mais complicado do que deveria.

## S — Single Responsibility Principle

```text
Uma classe deve ter apenas uma razão para mudar.
```

Não significa:

```text
"uma classe só pode ter um método"
```

Significa:

```text
uma responsabilidade coerente
→ uma razão de mudança
```

Exemplo ruim:

```text
Employee
 ├── dados do funcionário
 ├── cálculo salarial
 ├── relatório
 └── persistência
```

Exemplo melhor:

```text
Employee
EmployeeReport
EmployeeRepository
PayrollCalculator
```

O objetivo principal é reduzir complexidade e limitar mudanças que podem afetar partes não relacionadas. 

---

## O — Open/Closed Principle

```text
Aberto para extensão
Fechado para modificação
```

A intenção:

```text
novo comportamento
        ↓
adicione extensão
        ↓
não fique alterando código estável
```

Exemplo:

```text
Pedido
  └── cálculo de frete
```

Em vez de:

```python
if transportadora == "A":
    ...
elif transportadora == "B":
    ...
elif transportadora == "C":
    ...
```

cada nova transportadora obrigando alteração da classe.

O livro destaca que OCP existe principalmente para evitar que novas funcionalidades quebrem código existente.

---

## L — Liskov Substitution Principle

Regra mental:

> "Se meu código funciona com a classe base, também deve funcionar quando receber uma subclasse."

```text
Base
  ↑
Subclasse
```

A subclasse não pode quebrar as expectativas estabelecidas pela base.

O livro detalha:

```text
não fortalecer pré-condições
não enfraquecer pós-condições
preservar invariantes
respeitar contratos
```

e explica que métodos sobrescritos precisam manter compatibilidade comportamental.  

---

## I — Interface Segregation Principle

Evite:

```text
Interface gigantesca
        ↓
classe implementa coisas que não usa
```

Prefira:

```text
InterfaceA
InterfaceB
InterfaceC
```

mais específicas.

Mas existe uma ressalva importante no livro:

```text
não divida interfaces infinitamente
```

Interfaces demais também aumentam a complexidade. 

---

## D — Dependency Inversion Principle

A regra:

```text
Alto nível ──X──> Baixo nível

Alto nível ──> Abstração <── Baixo nível
```

A lógica de negócio não deve depender diretamente de detalhes como:

```text
Banco de dados
Filesystem
HTTP
SMTP
Redis
```

Ela deve depender de abstrações que expressem aquilo que precisa.

O livro mostra explicitamente a inversão dessa direção de dependência. 

---

# 9. Padrões criacionais

Os padrões criacionais tratam de mecanismos de criação e procuram aumentar flexibilidade e reutilização. 

---

## 9.1 Factory Method

### Agente deve reconhecer

```text
Tenho uma hierarquia de criadores
e cada subclasse precisa criar
um tipo diferente de produto.
```

### Intenção

```text
Criação fica encapsulada em um método fábrica.
Subclasses decidem qual produto concreto criar.
```

```text
Creator
   |
   +-- createProduct()
   |
ConcreteCreatorA → ProductA
ConcreteCreatorB → ProductB
```

A definição do livro é exatamente fornecer a criação na superclasse permitindo que subclasses alterem o tipo criado. 

### Benefícios

```text
↓ acoplamento com produtos concretos
SRP
OCP
```

### Custo

```text
mais subclasses
mais estrutura
```



### Pergunta do agente

> "O tipo concreto do objeto deve variar com a subclasse?"

---

# 10. Abstract Factory

### Agente deve reconhecer

```text
Tenho famílias de objetos relacionados
e não quero permitir combinações incompatíveis.
```

Exemplo:

```text
Factory Windows
    ButtonWindows
    CheckboxWindows
    MenuWindows

Factory Linux
    ButtonLinux
    CheckboxLinux
    MenuLinux
```

O código cliente conhece:

```text
AbstractFactory
```

e não:

```text
WindowsButton
LinuxButton
...
```

O livro destaca que a fábrica mantém os produtos de uma família compatíveis entre si. 

### Diferença para Factory Method

```text
Factory Method
→ normalmente um tipo de produto

Abstract Factory
→ família de produtos relacionados
```

### Pergunta

> "Estou escolhendo uma família/coerência de produtos, e não apenas um objeto?"

---

# 11. Builder

### Agente deve reconhecer

```text
Objeto complexo
+
muitos passos
+
muitas configurações
```

Exemplo:

```text
UserBuilder
    .name(...)
    .email(...)
    .phone(...)
    .address(...)
    .permissions(...)
    .build()
```

O Builder constrói passo a passo e permite diferentes representações usando o mesmo processo. 

Estrutura:

```text
Director
   ↓
Builder
   ↓
Product
```

O `Director`, quando utilizado, coordena a ordem da construção. 

### Use quando

```text
construção é complexa
há etapas
há representações diferentes
há configuração pesada
```

### Cuidado

Criar classes demais para objetos simples.

---

# 12. Prototype

### Agente deve reconhecer

```text
Criar do zero é caro/complexo
e já existe um objeto configurado.
```

Então:

```text
objeto existente
      ↓
clone()
      ↓
novo objeto
```

O Prototype permite copiar objetos sem acoplar o código às classes concretas. 

O livro também apresenta o uso de **protótipos pré-configurados**: em vez de montar centenas de campos novamente, cria-se um conjunto de objetos-modelo e eles são clonados. 

### Cuidado

Clonar objetos complexos com referências circulares pode ser difícil. 

---

# 13. Singleton

### Intenção

```text
garantir uma única instância
+
fornecer acesso global
```



Estrutura mental:

```text
Singleton
    private instance

getInstance()
    se não existe:
        cria
    retorna mesma instância
```

O livro mostra o uso de construtor privado, método de acesso e inicialização preguiçosa.

### Atenção

O próprio livro é bastante crítico:

```text
pode violar SRP
pode mascarar design ruim
complica testes
precisa cuidado em multithreading
```



Regra do agente:

> **Não sugerir Singleton apenas porque “preciso acessar de qualquer lugar”.**

---

# 14. Padrões estruturais

Esses padrões tratam da montagem de objetos e classes maiores, procurando manter flexibilidade e eficiência.

---

# 15. Adapter

### Problema

```text
Cliente espera InterfaceA

Objeto existente fornece InterfaceB
```

O Adapter faz:

```text
Cliente
  ↓
Adapter
  ↓
Serviço incompatível
```

Ele traduz interface/formato/dados. 

### Exemplo

```text
Seu código espera JSON
Biblioteca antiga fornece XML

Seu Adapter:
XML → JSON
```

### Pergunta

> "Eu já tenho uma classe que faz o trabalho, mas a interface dela é incompatível?"

Esse é o sinal clássico.

---

# 16. Bridge

### Problema

Duas dimensões independentes provocam explosão de subclasses:

```text
Forma
+
Cor
```

Você acaba com:

```text
RedCircle
BlueCircle
RedSquare
BlueSquare
...
```

O Bridge separa:

```text
Abstração
   ↓
Implementação
```

em duas hierarquias independentes. 

E usa composição para conectar as duas. 

### Pergunta

> "Tenho duas dimensões de variação que precisam evoluir independentemente?"

---

# 17. Composite

### Reconhecimento

```text
estrutura de árvore
```

Exemplo:

```text
Pedido
 ├── Caixa
 │    ├── Produto
 │    └── Produto
 └── Caixa
      └── Produto
```

O cliente quer tratar:

```text
Produto
Caixa
```

com a mesma interface. 

Estrutura:

```text
Component
 ├── Leaf
 └── Composite
       ├── Component
       ├── Component
       └── Composite
```

Polimorfismo + recursão são os mecanismos centrais. 

### Forte conexão

```text
Composite + Iterator
Composite + Visitor
Composite + Chain of Responsibility
Composite + Builder
```

O livro explicitamente apresenta essas combinações. 

---

# 18. Decorator

### Intenção

```text
adicionar comportamento
sem modificar a classe original
e sem depender de herança.
```

O decorator envolve outro objeto e mantém a mesma interface. 

Estrutura:

```text
Component
   ↑
Decorator
   ↓
Component
```

Pode formar:

```text
Base
 ↓
Decorator A
 ↓
Decorator B
 ↓
Decorator C
```

e adicionar comportamentos em camadas durante execução. 

### Pergunta

> "Quero adicionar responsabilidades dinamicamente sem alterar a interface?"

---

# 19. Facade

### Problema

Um subsistema possui:

```text
A
B
C
D
E
F
G
```

e o cliente precisa conhecer toda a sequência.

Facade:

```text
Cliente
   ↓
Facade
   ↓
A B C D E F
```

Ela fornece uma interface simples sobre um subsistema complexo. 

Exemplo:

```python
converter.convert(file, "mp4")
```

em vez de o cliente conhecer:

```text
codec
reader
bitrate
audio mixer
buffer
...
```

### Diferença fundamental

```text
Adapter
→ torna uma interface existente compatível.

Facade
→ cria uma interface simplificada para um subsistema.
```



---

# 20. Flyweight

### Problema

Milhões de pequenos objetos:

```text
Particle
Particle
Particle
Particle
...
```

possuem muitos dados repetidos.

Separar:

```text
Estado intrínseco
→ compartilhado

Estado extrínseco
→ específico
```

O Flyweight mantém partes comuns compartilhadas para economizar RAM. 

Exemplo:

```text
Bala #1
posição X
posição Y
velocidade
    ↓
FlyweightBullet
    cor
    sprite

Bala #2
posição X
posição Y
velocidade
    ↓
mesmo FlyweightBullet
```

### Pergunta

> "Tenho enorme quantidade de objetos com estado repetido?"

---

# 21. Proxy

### Intenção

```text
Objeto Cliente
      ↓
Proxy
      ↓
Objeto Real
```

O Proxy é um substituto/espaço reservado que controla acesso ao objeto original e pode executar lógica antes/depois da chamada. 

Exemplos conceituais:

```text
Lazy loading
Controle de acesso
Cache
Remote access
Logging
```

Ponto-chave:

```text
Proxy
→ mesma interface do objeto real
```

Isso o diferencia da Facade e do Adapter. 

---

# 22. Padrões comportamentais

Agora o foco muda:

```text
Quem executa?
Quem conhece quem?
Quem recebe o pedido?
Como distribuir responsabilidades?
```

---

# 23. Chain of Responsibility

### Problema

Você tem vários processadores possíveis:

```text
Autenticação
     ↓
Permissão
     ↓
Validação
     ↓
Rate limit
     ↓
Processamento
```

Cada handler decide:

```text
processo?
ou
passo para o próximo?
```

Essa é exatamente a ideia da Chain of Responsibility. 

### Agente deve pensar

> "Não sei antecipadamente quem deve tratar este pedido."

### Cuidado

O pedido pode:

```text
ser tratado no meio
ou
chegar ao fim sem tratamento
```



---

# 24. Command

### Ideia revolucionária

Transforme:

```text
"faça isso"
```

em:

```text
objeto Command
```

Exemplo:

```text
CreateUserCommand
DeleteUserCommand
SendEmailCommand
RefundPaymentCommand
```

Estrutura:

```text
Invoker
   ↓
Command
   ↓
Receiver
```

Isso permite:

```text
fila
agendamento
serialização
logging
execução remota
undo/redo
histórico
```



O livro mostra inclusive o uso de histórico para desfazer operações. 

### Pergunta

> "Preciso transformar uma operação em algo que possa ser armazenado, enfileirado, adiado ou revertido?"

---

# 25. Iterator

### Problema

Uma coleção pode ser:

```text
lista
pilha
árvore
grafo
```

mas o cliente só quer:

```text
próximo elemento
```

O Iterator extrai a lógica de travessia para um objeto independente. 

Assim:

```text
Collection
    ↓
Iterator
    ↓
next()
```

O cliente não precisa conhecer a estrutura interna.

Benefícios incluem múltiplas iterações independentes e possibilidade de novas estratégias de travessia. 

---

# 26. Mediator

### Problema

Sem Mediator:

```text
A ↔ B
A ↔ C
A ↔ D
B ↔ C
B ↔ D
C ↔ D
```

Com Mediator:

```text
      Mediator
      /  |  \
     A   B   C
```

Os componentes deixam de conversar diretamente.

O Mediator centraliza a comunicação e reduz dependências caóticas. 

### Cuidado

Pode evoluir para:

```text
God Object
```

ou seja, um mediador que passa a concentrar responsabilidade demais. 

---

# 27. Memento

### Problema

Você quer:

```text
salvar estado
↓
alterar objeto
↓
voltar ao estado anterior
```

mas não quer expor os detalhes internos.

Solução:

```text
Originator
    ↓
  Memento
    ↓
Caretaker
```

O próprio dono do estado cria o snapshot, preservando o encapsulamento. 

### Uso clássico

```text
Undo
Histórico
Snapshots
```

### Custo

Muitos snapshots podem consumir muita memória. 

---

# 28. Observer

### Problema

Um objeto muda e várias outras partes precisam saber.

```text
Publisher
   ├── Subscriber A
   ├── Subscriber B
   └── Subscriber C
```

Os subscribers se registram e recebem notificações quando eventos acontecem. 

Muito útil para:

```text
eventos
notificações
UI
sistemas reativos
```

O livro enfatiza que os relacionamentos entre publisher e subscribers podem ser criados durante a execução. 

### Diferença para Mediator

```text
Observer
→ comunicação dinâmica de um para vários

Mediator
→ centralização de comunicação entre vários componentes
```



---

# 29. State

### Problema

Uma classe começa a acumular:

```python
if state == "A":
    ...

elif state == "B":
    ...

elif state == "C":
    ...
```

e cada método repete a mesma lógica.

O State transforma estados em objetos:

```text
Context
   ↓
State
 ├── StateA
 ├── StateB
 └── StateC
```

Cada estado encapsula seu comportamento.

O livro recomenda extrair o código dependente de estado para classes específicas e trocar o objeto de estado no contexto. 

### Pergunta

> "O comportamento do objeto muda profundamente conforme seu estado interno?"

---

# 30. Strategy

### Ideia

Tenho várias maneiras de executar **o mesmo tipo de algoritmo**:

```text
Strategy
 ├── StrategyA
 ├── StrategyB
 └── StrategyC
```

Context:

```text
Context
   ↓
Strategy
```

Pode trocar:

```text
strategy = A
strategy = B
strategy = C
```

durante execução. 

### Sinal clássico

```text
if algorithm == A:
    ...
elif algorithm == B:
    ...
elif algorithm == C:
    ...
```

Extraia cada algoritmo para uma estratégia.

O livro recomenda Strategy justamente para variantes de algoritmo e condicionais grandes. 

### Diferença importante

```text
Strategy
→ maneiras diferentes de fazer a mesma coisa

Command
→ transforma uma operação em objeto

Decorator
→ adiciona responsabilidades

State
→ comportamento muda conforme estado
```

A distinção Command × Strategy aparece explicitamente no livro. 

---

# 31. Template Method

### Ideia

Existe um algoritmo com estrutura fixa:

```text
passo A
passo B
passo C
passo D
```

Mas algumas etapas variam.

Então:

```text
AbstractClass
    templateMethod()
        stepA()
        stepB()
        stepC()
```

Subclasses sobrescrevem:

```text
stepB
stepC
```

mas não mudam a estrutura inteira.



### Conceito adicional importante

O livro apresenta:

```text
abstract steps
optional steps
hooks
```

Hooks são pontos opcionais de extensão. 

### Diferença para Strategy

```text
Template Method
→ herança
→ nível de classe
→ estrutura mais estática

Strategy
→ composição
→ nível de objeto
→ pode trocar durante execução
```



---

# 32. Visitor

### Problema

Você tem uma estrutura de objetos:

```text
City
Industry
SightSeeing
...
```

e começa a adicionar comportamentos:

```text
exportar XML
exportar JSON
calcular imposto
gerar relatório
...
```

Se colocar tudo nas classes originais:

```text
City
Industry
...
```

elas começam a acumular responsabilidades.

O Visitor extrai esses comportamentos para objetos separados. 

Estrutura:

```text
Element
   ↓ accept(visitor)

Visitor
   ├── visitCity()
   ├── visitIndustry()
   └── visitSightSeeing()
```

O mecanismo fundamental é **Double Dispatch**. 

### Use especialmente quando

```text
estrutura é complexa
+
vários tipos de elementos
+
muitos comportamentos diferentes
```

O próprio livro recomenda Visitor para operações sobre árvores/estruturas complexas e mostra sua combinação com Composite e Iterator.  

---

# 33. O mapa mental dos 22 padrões

Para o agente, a melhor forma de memorizar não é decorar 22 definições, mas esta matriz:

| Problema detectado                           | Padrão                      |
| -------------------------------------------- | --------------------------- |
| Subclasse decide qual objeto criar           | **Factory Method**          |
| Família de objetos relacionados              | **Abstract Factory**        |
| Construção complexa em etapas                | **Builder**                 |
| Copiar configuração existente                | **Prototype**               |
| Uma única instância controlada               | **Singleton**               |
| Interfaces incompatíveis                     | **Adapter**                 |
| Duas dimensões independentes                 | **Bridge**                  |
| Estrutura em árvore                          | **Composite**               |
| Adicionar responsabilidades dinamicamente    | **Decorator**               |
| Simplificar subsistema complexo              | **Facade**                  |
| Muitos objetos com estado repetido           | **Flyweight**               |
| Controlar acesso a objeto                    | **Proxy**                   |
| Pedido percorre vários possíveis handlers    | **Chain of Responsibility** |
| Transformar operação em objeto               | **Command**                 |
| Percorrer coleção sem conhecer implementação | **Iterator**                |
| Centralizar comunicação                      | **Mediator**                |
| Snapshot/Undo sem quebrar encapsulamento     | **Memento**                 |
| Notificar assinantes                         | **Observer**                |
| Comportamento depende do estado              | **State**                   |
| Variar algoritmo                             | **Strategy**                |
| Estrutura fixa + etapas variáveis            | **Template Method**         |
| Adicionar operações a uma hierarquia         | **Visitor**                 |

O catálogo do livro apresenta exatamente essas 22 categorias e padrões. 

---

# 34. Como um Agente deve decidir qual padrão usar

Essa é provavelmente a parte mais importante para transformar o PDF em conhecimento operacional.

## Quando o usuário apresentar código, o Agente deve perguntar:

### A. O problema é criação?

```text
"Estou criando objetos."
        ↓
Factory Method?
Abstract Factory?
Builder?
Prototype?
Singleton?
```

### B. O problema é estrutura?

```text
"Estou conectando/compondo objetos."
        ↓
Adapter?
Bridge?
Composite?
Decorator?
Facade?
Flyweight?
Proxy?
```

### C. O problema é comportamento?

```text
"Estou decidindo quem executa/como comunica."
        ↓
Chain?
Command?
Iterator?
Mediator?
Memento?
Observer?
State?
Strategy?
Template Method?
Visitor?
```

---

# 35. Árvore de decisão prática

```text
Tenho um problema de design
│
├── É sobre CRIAR objetos?
│   │
│   ├── Subclasses escolhem o tipo?
│   │      → Factory Method
│   │
│   ├── Família de objetos?
│   │      → Abstract Factory
│   │
│   ├── Muitos passos?
│   │      → Builder
│   │
│   ├── Quero copiar?
│   │      → Prototype
│   │
│   └── Exatamente uma instância?
│          → Singleton
│
├── É sobre ESTRUTURA?
│   │
│   ├── Interfaces incompatíveis?
│   │      → Adapter
│   │
│   ├── Duas dimensões independentes?
│   │      → Bridge
│   │
│   ├── Árvore?
│   │      → Composite
│   │
│   ├── Adicionar comportamento?
│   │      → Decorator
│   │
│   ├── Simplificar subsistema?
│   │      → Facade
│   │
│   ├── Economizar memória compartilhando estado?
│   │      → Flyweight
│   │
│   └── Controlar acesso?
│          → Proxy
│
└── É sobre COMPORTAMENTO?
    │
    ├── Vários possíveis processadores?
    │      → Chain of Responsibility
    │
    ├── Quero transformar operação em objeto?
    │      → Command
    │
    ├── Quero percorrer coleção?
    │      → Iterator
    │
    ├── Muitos objetos conversando entre si?
    │      → Mediator
    │
    ├── Quero snapshot/undo?
    │      → Memento
    │
    ├── Quero notificações?
    │      → Observer
    │
    ├── O comportamento depende do estado?
    │      → State
    │
    ├── Existem vários algoritmos?
    │      → Strategy
    │
    ├── Existe um algoritmo com estrutura fixa?
    │      → Template Method
    │
    └── Quero adicionar operações à hierarquia?
           → Visitor
```

---

# 36. Conexões que o Agente precisa saber

O livro é especialmente forte nas relações entre padrões. O conhecimento não deve ficar isolado em 22 caixas.

## Factory Method ↔ Template Method

Factory Method pode ser uma etapa especializada dentro de Template Method.

## Abstract Factory ↔ Builder

```text
Abstract Factory
→ família de produtos

Builder
→ construção passo a passo
```



## Adapter ↔ Facade

```text
Adapter
→ compatibilizar interface

Facade
→ simplificar subsistema
```



## Decorator ↔ Composite

Ambos usam composição recursiva, mas:

```text
Composite
→ estrutura árvore

Decorator
→ um componente envolvido + responsabilidades adicionais
```



## Decorator ↔ Strategy

```text
Decorator → muda a "pele"
Strategy   → muda as "entranhas"
```



## State ↔ Strategy ↔ Bridge

Podem parecer estruturalmente semelhantes porque usam composição e delegação, mas representam **intenções diferentes**. 

## Command ↔ Memento

```text
Command
→ operação

Memento
→ estado anterior
```

Juntos são úteis para implementar undo/redo. 

## Composite ↔ Visitor

```text
Composite
→ representa a estrutura

Visitor
→ executa operação sobre a estrutura
```



---

# 37. Regra final de ensino do Agente

O agente não deve ensinar:

> “Strategy é um padrão comportamental que faz X.”

Deve ensinar:

```text
1. Mostre o código problemático.

2. Identifique a causa:
   "há várias versões do mesmo algoritmo".

3. Mostre por que isso gera acoplamento.

4. Mostre a abstração.

5. Extraia as variantes.

6. Introduza Strategy.

7. Mostre o código depois.

8. Explique o trade-off:
   mais classes/interfaces,
   porém maior flexibilidade.

9. Compare com:
   State
   Command
   Template Method

10. Faça o aluno decidir qual usaria
    em um cenário novo.
```

Isso é coerente com a própria estrutura do livro: **propósito → motivação → estrutura → código → aplicabilidade → implementação → relações**. 

# 38. Prompt-base para transformar isso em um Agente professor

Você pode usar esta lógica como instrução central de um agente:

```text
Você é um Agente Professor de Engenharia de Software especializado
em Programação Orientada a Objetos, princípios de design, SOLID
e padrões GoF.

Sua base conceitual segue a organização do livro
"Mergulho nos Padrões de Projeto", de Alexander Shvets.

OBJETIVO

Ensinar o aluno a reconhecer problemas de design e escolher
soluções apropriadas.

NÃO ensine padrões como receitas decoradas.

Para cada tópico:

1. Explique o problema.
2. Mostre o código/design ingênuo.
3. Identifique o acoplamento ou responsabilidade problemática.
4. Explique o motivo pelo qual o design tende a ficar difícil de evoluir.
5. Apresente a solução conceitual.
6. Mostre a estrutura das classes/objetos.
7. Mostre uma implementação simples.
8. Explique quando usar.
9. Explique quando NÃO usar.
10. Explique os trade-offs.
11. Compare com padrões semelhantes.
12. Crie um exercício para o aluno escolher a solução.
13. Faça uma pergunta de verificação.

REGRAS FUNDAMENTAIS

- Primeiro procure o PROBLEMA, depois o PADRÃO.
- Priorize abstração, encapsulamento e composição.
- Não recomende padrões sem justificar a necessidade.
- Explique o custo de adicionar abstrações.
- Não trate SOLID como dogma.
- Diferencie herança de composição.
- Diferencie interface de implementação concreta.
- Sempre explique o motivo da mudança arquitetural.
- Relacione padrões quando eles possuírem estruturas semelhantes,
  mas intenções diferentes.
- Use exemplos progressivos.
- Ao analisar código real, primeiro diagnostique o problema e só
  depois indique possíveis padrões.

NÍVEIS DE EXPLICAÇÃO

Nível 1:
explicação intuitiva.

Nível 2:
estrutura de classes.

Nível 3:
implementação.

Nível 4:
trade-offs.

Nível 5:
comparação com padrões relacionados.

Nível 6:
aplicação em código real.

Nível 7:
refatoração de código ruim para código melhor.

Nível 8:
exercício em que o aluno deve escolher o padrão sem receber
o nome antecipadamente.

COMPORTAMENTO PEDAGÓGICO

Nunca revele apenas a resposta.

Quando apropriado, conduza o aluno pelas perguntas:

- O que está variando?
- O que está acoplado?
- Quem deveria ter essa responsabilidade?
- Essa classe depende de uma implementação concreta?
- Posso resolver isso com composição?
- Preciso criar uma abstração?
- Essa abstração realmente reduz uma mudança futura?
- Qual é o custo dessa solução?
- Existe um padrão mais simples?

Ao comparar padrões, explique a INTENÇÃO, não apenas a estrutura.

Exemplo:

Adapter:
"interfaces incompatíveis"

Decorator:
"adicionar responsabilidades mantendo a interface"

Proxy:
"controlar acesso mantendo a interface"

Facade:
"simplificar um subsistema"

Não trate padrões visualmente semelhantes como equivalentes.

Sempre termine um tópico importante com um pequeno desafio.
```

A essência do PDF é essa: **padrões não são o objetivo final; eles são uma linguagem para pensar sobre mudança, acoplamento, responsabilidades, criação, composição e comunicação entre objetos**. O próprio livro ressalta que eles funcionam como um kit de soluções testadas e também como uma linguagem comum entre desenvolvedores. 

E, para estudar de verdade, a ordem mais eficiente é:

```text
POO
 ↓
Relações entre objetos
 ↓
Encapsule o que varia
 ↓
Interface vs implementação
 ↓
Composição vs herança
 ↓
SOLID
 ↓
Criacionais
 ↓
Estruturais
 ↓
Comportamentais
 ↓
Refatorações
 ↓
Exercícios sem revelar o padrão
```

Isso acompanha a organização pedagógica do próprio material.
