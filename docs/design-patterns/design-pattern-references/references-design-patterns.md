# Referência do PDF — Design Patterns

**Arquivo PDF Primário:** [design-patterns.pdf](pdf/design-patterns.pdf)  
**Documento Conceituador:** [desgin-patterns.md](desgin-patterns.md)  
**Obra:** *Padrões de Projeto — Soluções reutilizáveis de software orientado a objetos*  
**Autores:** Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides  
**Edição em português:** Bookman, 2007 (obra original de 1995)  
**Extensão:** 360 páginas no arquivo PDF  

> **Nota de navegação:** as páginas abaixo usam principalmente a **paginação impressa do livro**, exatamente como apresentada no sumário do PDF. A numeração do arquivo PDF pode não coincidir com a paginação impressa por causa das páginas preliminares.

---

## Índice Padronizado para Agentes de IA

### Acesso Rápido a Seções Principais

- [1. Mapa geral do livro](#1-mapa-geral-do-livro)
- [2. Páginas preliminares](#2-páginas-preliminares)
- [3. Capítulo 1 — Introdução](#3-capítulo-1--introdução)
- [4. Capítulo 2 — Estudo de caso: editor de documentos Lexi](#4-capítulo-2--estudo-de-caso-editor-de-documentos-lexi)
- [5. Capítulo 3 — Padrões de criação](#5-capítulo-3--padrões-de-criação)
- [6. Capítulo 4 — Padrões estruturais](#6-capítulo-4--padrões-estruturais)
- [7. Capítulo 5 — Padrões comportamentais](#7-capítulo-5--padrões-comportamentais)
- [8. Capítulo 6 — Conclusão](#8-capítulo-6--conclusão)
- [9. Apêndice A — Glossário](#9-apêndice-a--glossário)
- [10. Apêndice B — Guia para a notação](#10-apêndice-b--guia-para-a-notação)
- [11. Apêndice C — Classes fundamentais](#11-apêndice-c--classes-fundamentais)
- [12. Referências bibliográficas e índice](#12-referências-bibliográficas-e-índice)
- [13. Índice rápido dos 23 Design Patterns](#13-índice-rápido-dos-23-design-patterns)
- [14. Guia de consulta por problema](#14-guia-de-consulta-por-problema)
- [15. Relações importantes entre patterns](#15-relações-importantes-entre-patterns)
- [16. Páginas-chave para estudo](#16-páginas-chave-para-estudo)
- [17. Referência para LLM/Agente](#17-referência-para-llmagente)

### Matriz de Mapeamento Direto — 23 Padrões GoF

| Padrão | Família | Escopo | Livro (pág.) | Seção no Markdown |
|---|---|---|---:|---|
| Abstract Factory | Criação | Objeto | 95 | [5.2 Abstract Factory](#52-abstract-factory--p-95) |
| Builder | Criação | Objeto | 104 | [5.3 Builder](#53-builder--p-104) |
| Factory Method | Criação | Classe | 112 | [5.4 Factory Method](#54-factory-method--p-112) |
| Prototype | Criação | Objeto | 121 | [5.5 Prototype](#55-prototype--p-121) |
| Singleton | Criação | Objeto | 130 | [5.6 Singleton](#56-singleton--p-130) |
| Adapter | Estrutural | Classe/Objeto | 140 | [6.2 Adapter](#62-adapter--p-140) |
| Bridge | Estrutural | Objeto | 151 | [6.3 Bridge](#63-bridge--p-151) |
| Composite | Estrutural | Objeto | 160 | [6.4 Composite](#64-composite--p-160) |
| Decorator | Estrutural | Objeto | 170 | [6.5 Decorator](#65-decorator--p-170) |
| Façade | Estrutural | Objeto | 179 | [6.6 Façade](#66-façade--p-179) |
| Flyweight | Estrutural | Objeto | 187 | [6.7 Flyweight](#67-flyweight--p-187) |
| Proxy | Estrutural | Objeto | 198 | [6.8 Proxy](#68-proxy--p-198) |
| Chain of Responsibility | Comportamental | Objeto | 212 | [7.2 Chain of Responsibility](#72-chain-of-responsibility--p-212) |
| Command | Comportamental | Objeto | 222 | [7.3 Command](#73-command--p-222) |
| Interpreter | Comportamental | Classe | 231 | [7.4 Interpreter](#74-interpreter--p-231) |
| Iterator | Comportamental | Objeto | 244 | [7.5 Iterator](#75-iterator--p-244) |
| Mediator | Comportamental | Objeto | 257 | [7.6 Mediator](#76-mediator--p-257) |
| Memento | Comportamental | Objeto | 266 | [7.7 Memento](#77-memento--p-266) |
| Observer | Comportamental | Objeto | 274 | [7.8 Observer](#78-observer--p-274) |
| State | Comportamental | Objeto | 284 | [7.9 State](#79-state--p-284) |
| Strategy | Comportamental | Objeto | 292 | [7.10 Strategy](#710-strategy--p-292) |
| Template Method | Comportamental | Classe | 301 | [7.11 Template Method](#711-template-method--p-301) |
| Visitor | Comportamental | Objeto | 305 | [7.12 Visitor](#712-visitor--p-305) |

---

## 1. Mapa geral do livro

| Parte | Conteúdo | Página impressa |
|---|---|---:|
| Cap. 1 | Introdução | 17 |
| Cap. 2 | Estudo de caso — projetando o editor Lexi | 47 |
| Cap. 3 | Padrões de criação | 91 |
| Cap. 4 | Padrões estruturais | 139 |
| Cap. 5 | Padrões comportamentais | 211 |
| Cap. 6 | Conclusão | 323 |
| Apêndice A | Glossário | 331 |
| Apêndice B | Guia para a notação | 335 |
| Apêndice C | Classes fundamentais | 341 |
| Referências bibliográficas | Referências | 347 |
| Índice | Índice remissivo | 353 |

O catálogo principal contém **23 padrões**, divididos em três famílias: criação, estrutural e comportamental.

---

# 2. Páginas preliminares

| Local | Página do PDF | Conteúdo |
|---|---:|---|
| Capa | 1 | Título, subtítulo, autores e editora |
| Ficha catalográfica | 2 | Dados bibliográficos e ISBN |
| Folha de rosto | 3 | Autores, título, tradução, revisão e edição |
| Direitos autorais | 4 | Dados da publicação original e direitos |
| Dedicatórias | 5 | Dedicatórias dos autores |
| Prefácio | 6–7 | Objetivos, público e filosofia do livro |
| Apresentação | 8 | Importância dos padrões para arquitetura OO |
| Guia para os leitores | 9–10 | Como estudar e consultar o catálogo |
| Sumário | 11–13 | Estrutura completa do livro |

---

# 3. Capítulo 1 — Introdução

**Início:** página impressa 17

## 3.1 Índice de seções

| Seção | Título | Página impressa |
|---|---|---:|
| 1 | Introdução | 17 |
| 1.1 | O que é um padrão de projeto? | 19 |
| 1.2 | Padrões de projeto no MVC do Smalltalk | 20 |
| 1.3 | Descrevendo os padrões de projeto | 22 |
| 1.4 | O catálogo de padrões de projeto | 24 |
| 1.5 | Organizando o catálogo | 25 |
| 1.6 | Como os padrões solucionam problemas de projeto | 27 |
| 1.7 | Como selecionar um padrão de projeto | 43 |
| 1.8 | Como usar um padrão de projeto | 44 |

## 3.2 Conteúdos importantes do capítulo

### O que é um Design Pattern — p. 19

Um padrão é descrito por quatro elementos fundamentais:

1. **Nome**
2. **Problema**
3. **Solução**
4. **Consequências**

Use esta seção para entender a definição formal e a função do vocabulário de patterns.

### MVC e patterns — p. 20–22

A discussão de MVC mostra como patterns podem ser reconhecidos dentro de uma arquitetura existente:

- **Observer** — relação entre Model e Views.
- **Composite** — views compostas por outras views.
- **Strategy** — Controller como estratégia de resposta.
- **Factory Method** e **Decorator** aparecem como patterns auxiliares.

### Como descrever um pattern — p. 22–24

O template utilizado pelo livro inclui:

- Nome e classificação
- Intenção e objetivo
- Também conhecido como
- Motivação
- Aplicabilidade
- Estrutura
- Participantes
- Colaborações
- Consequências
- Implementação
- Exemplo de código
- Usos conhecidos
- Padrões relacionados

### Catálogo dos 23 patterns — p. 24–25

O catálogo apresenta a intenção resumida de cada pattern.

### Organização do catálogo — p. 25–26

Dois eixos de classificação:

- **Finalidade:** criação, estrutural, comportamental.
- **Escopo:** classe ou objeto.

### Como patterns solucionam problemas — p. 27–42

Principais problemas de projeto abordados:

- Encontrar objetos apropriados.
- Determinar granularidade dos objetos.
- Especificar interfaces.
- Especificar implementações.
- Programar para uma interface, não implementação.
- Evitar dependências de implementação.
- Encapsular conceitos que variam.
- Reduzir acoplamento.
- Projetar para mudanças futuras.

### Como selecionar um pattern — p. 43–44

Estratégias de seleção:

- Partir do problema.
- Ler as intenções dos patterns.
- Estudar os relacionamentos entre patterns.
- Comparar patterns de finalidade semelhante.
- Identificar causas de redesign.
- Identificar quais aspectos devem variar independentemente.

### Como usar um pattern — p. 44–45

Processo recomendado:

1. Ler o pattern inteiro.
2. Estudar Aplicabilidade e Consequências.
3. Estudar Estrutura, Participantes e Colaborações.
4. Analisar o exemplo de código.
5. Adaptar os nomes ao domínio da aplicação.
6. Definir operações específicas do domínio.
7. Implementar as responsabilidades e colaborações.

---

# 4. Capítulo 2 — Estudo de caso: editor de documentos Lexi

**Início:** página impressa 47

## 4.1 Índice de seções

| Seção | Título | Página impressa |
|---|---|---:|
| 2.1 | Problemas de projeto | 47 |
| 2.2 | Estrutura do documento | 49 |
| 2.3 | Formatação | 53 |
| 2.4 | Adornando a interface do usuário | 56 |
| 2.5 | Suportando múltiplos estilos de interação (look-and-feel) | 60 |
| 2.6 | Suportando múltiplos sistemas de janelas | 64 |
| 2.7 | Operações do usuário | 70 |
| 2.8 | Verificação ortográfica e hifenização | 75 |
| 2.9 | Resumo | 86 |

## 4.2 Problemas e patterns usados no Lexi

| Problema | Pattern(s) relacionado(s) | Página da seção |
|---|---|---:|
| Estrutura hierárquica de documento | Composite | 49 |
| Formatação e algoritmos intercambiáveis | Strategy | 53 |
| Adornos de UI adicionáveis/removíveis | Decorator | 56 |
| Diferentes look-and-feel | Abstract Factory | 60 |
| Diferentes sistemas de janelas | Bridge | 64 |
| Operações de usuário | Command | 70 |
| Percorrer/analisar estruturas | Iterator, Visitor | 75 |
| Spell-check e hifenização | Strategy / Visitor | 75 |

## 4.3 Páginas úteis

- **p. 48:** interface de usuário do Lexi e motivação do estudo de caso.
- **p. 49–52:** representação hierárquica da estrutura do documento.
- **p. 53–55:** encapsulamento do algoritmo de formatação.
- **p. 56–59:** decoração da interface.
- **p. 60–63:** múltiplos look-and-feel.
- **p. 64–69:** independência em relação ao sistema de janelas e Bridge.
- **p. 70–74:** operações do usuário, Command e undo/redo.
- **p. 75–85:** análise do documento, Iterator e Visitor.
- **p. 86:** resumo dos patterns aplicados.

---

# 5. Capítulo 3 — Padrões de criação

**Início:** página impressa 91

Os patterns de criação abstraem o processo de instanciação e buscam reduzir dependência das classes concretas.

## 5.1 Índice

| Pattern / seção | Página impressa |
|---|---:|
| Discussão introdutória sobre padrões de criação | 91 |
| Abstract Factory | 95 |
| Builder | 104 |
| Factory Method | 112 |
| Prototype | 121 |
| Singleton | 130 |
| Discussão sobre padrões de criação | 136 |

## 5.2 Abstract Factory — p. 95

**Localização principal:** p. 95–103

**Intenção:** fornecer uma interface para criar famílias de objetos relacionados ou dependentes sem especificar suas classes concretas.

**Use como referência quando estudar:**

- famílias de produtos;
- produtos compatíveis entre si;
- independência de plataforma;
- criação indireta de objetos;
- comparação com Factory Method e Prototype.

## 5.3 Builder — p. 104

**Localização principal:** p. 104–111

**Intenção:** separar a construção de um objeto complexo da sua representação.

**Use como referência quando estudar:**

- construção passo a passo;
- produtos complexos;
- diferentes representações;
- Director e Builder;
- comparação com Abstract Factory e Prototype.

## 5.4 Factory Method — p. 112

**Localização principal:** p. 112–120

**Intenção:** definir uma interface de criação deixando subclasses decidir qual classe concreta instanciar.

**Use como referência quando estudar:**

- criação por herança;
- Creator / ConcreteCreator;
- Product / ConcreteProduct;
- dependência de subclasses;
- comparação com Abstract Factory.

## 5.5 Prototype — p. 121

**Localização principal:** p. 121–129

**Intenção:** especificar tipos de objetos através de uma instância prototípica e criar novos objetos copiando esse protótipo.

**Use como referência quando estudar:**

- clone;
- protótipos registrados dinamicamente;
- criação sem conhecer classes concretas;
- variação por cópia;
- relação com Abstract Factory.

## 5.6 Singleton — p. 130

**Localização principal:** p. 130–135

**Intenção:** garantir uma única instância e fornecer um ponto global de acesso.

**Use como referência quando estudar:**

- unicidade de instância;
- acesso controlado;
- implementação de Singleton;
- consequências de usar estado global;
- relação com outros patterns.

## 5.7 Discussão sobre padrões de criação — p. 136–138

Ponto importante para comparar:

```text
Factory Method
    → parametrização por subclasses / herança

Abstract Factory
    → fábrica responsável por famílias de produtos

Builder
    → construção incremental de produto complexo

Prototype
    → construção por clonagem

Singleton
    → restrição de uma única instância
```

---

# 6. Capítulo 4 — Padrões estruturais

**Início:** página impressa 139

## 6.1 Índice

| Pattern / seção | Página impressa |
|---|---:|
| Adapter | 140 |
| Bridge | 151 |
| Composite | 160 |
| Decorator | 170 |
| Façade | 179 |
| Flyweight | 187 |
| Proxy | 198 |
| Discussão sobre padrões estruturais | 207 |

## 6.2 Adapter — p. 140

**Localização principal:** p. 140–150

**Intenção:** converter a interface de uma classe para outra interface esperada pelos clientes.

**Estudar especialmente:**

- adapter de classe;
- adapter de objeto;
- objetos adaptadores plugáveis;
- diferenças entre Adapter, Bridge e Decorator.

## 6.3 Bridge — p. 151

**Localização principal:** p. 151–159

**Intenção:** separar uma abstração da implementação para permitir que ambas variem independentemente.

**Estudar especialmente:**

- Abstraction / Implementor;
- duas hierarquias independentes;
- plataforma e implementação;
- Bridge vs Adapter.

## 6.4 Composite — p. 160

**Localização principal:** p. 160–169

**Intenção:** representar hierarquias partes-todo e permitir tratamento uniforme de folhas e composições.

**Estudar especialmente:**

- Component;
- Leaf;
- Composite;
- Client;
- árvore recursiva;
- composição uniforme.

## 6.5 Decorator — p. 170

**Localização principal:** p. 170–178

**Intenção:** adicionar responsabilidades dinamicamente a um objeto.

**Estudar especialmente:**

- Component;
- Decorator;
- ConcreteDecorator;
- composição de decorators;
- alternativa à herança.

## 6.6 Façade — p. 179

**Localização principal:** p. 179–186

**Intenção:** fornecer uma interface unificada e de nível mais alto para um subsistema.

**Estudar especialmente:**

- simplificação de subsistemas;
- redução de dependências do cliente;
- interface de alto nível;
- diferenças entre Façade e Mediator.

## 6.7 Flyweight — p. 187

**Localização principal:** p. 187–197

**Intenção:** compartilhar objetos de granularidade fina para reduzir custos de armazenamento.

**Estudar especialmente:**

- estado intrínseco;
- estado extrínseco;
- FlyweightFactory;
- pool de objetos;
- compartilhamento;
- memória vs complexidade.

## 6.8 Proxy — p. 198

**Localização principal:** p. 198–206

**Intenção:** fornecer um substituto para controlar o acesso a outro objeto.

**Estudar especialmente:**

- Virtual Proxy;
- Remote Proxy;
- Protection Proxy;
- lazy loading;
- acesso controlado;
- custos de criação.

## 6.9 Discussão sobre padrões estruturais — p. 207–210

Use esta seção para comparar os patterns estruturais e compreender diferenças de intenção apesar de estruturas semelhantes.

---

# 7. Capítulo 5 — Padrões comportamentais

**Início:** página impressa 211

## 7.1 Índice

| Pattern / seção | Página impressa |
|---|---:|
| Chain of Responsibility | 212 |
| Command | 222 |
| Interpreter | 231 |
| Iterator | 244 |
| Mediator | 257 |
| Memento | 266 |
| Observer | 274 |
| State | 284 |
| Strategy | 292 |
| Template Method | 301 |
| Visitor | 305 |
| Discussão sobre padrões comportamentais | 318 |

## 7.2 Chain of Responsibility — p. 212

**Localização principal:** p. 212–221

**Intenção:** reduzir o acoplamento entre remetente e receptor permitindo que múltiplos objetos tenham oportunidade de tratar uma solicitação.

**Estudar especialmente:**

- Handler;
- ConcreteHandler;
- successor;
- propagação da solicitação;
- cadeia dinâmica;
- ausência de garantia de tratamento.

## 7.3 Command — p. 222

**Localização principal:** p. 222–230

**Intenção:** encapsular uma solicitação como objeto.

**Estudar especialmente:**

- Command;
- ConcreteCommand;
- Receiver;
- Invoker;
- histórico;
- fila;
- log;
- undo/redo.

## 7.4 Interpreter — p. 231

**Localização principal:** p. 231–243

**Intenção:** representar uma gramática e interpretar sentenças dessa linguagem.

**Estudar especialmente:**

- AbstractExpression;
- TerminalExpression;
- NonterminalExpression;
- Context;
- árvore sintática;
- interpretação recursiva.

## 7.5 Iterator — p. 244

**Localização principal:** p. 244–256

**Intenção:** acessar elementos sequencialmente sem expor a representação interna da coleção.

**Estudar especialmente:**

- Iterator;
- ConcreteIterator;
- Aggregate;
- ConcreteAggregate;
- iteradores externos e internos;
- iteração em estruturas recursivas.

## 7.6 Mediator — p. 257

**Localização principal:** p. 257–265

**Intenção:** encapsular a forma de interação entre um conjunto de objetos.

**Estudar especialmente:**

- Mediator;
- ConcreteMediator;
- Colleague;
- redução de referências diretas;
- comunicação indireta.

## 7.7 Memento — p. 266

**Localização principal:** p. 266–273

**Intenção:** capturar e restaurar estado interno sem violar encapsulamento.

**Estudar especialmente:**

- Originator;
- Memento;
- Caretaker;
- encapsulamento;
- snapshots;
- undo/restore.

## 7.8 Observer — p. 274

**Localização principal:** p. 274–283

**Intenção:** estabelecer dependência um-para-muitos com notificação automática de mudanças.

**Estudar especialmente:**

- Subject;
- Observer;
- ConcreteSubject;
- ConcreteObserver;
- subscribe/notify;
- MVC.

## 7.9 State — p. 284

**Localização principal:** p. 284–291

**Intenção:** alterar o comportamento do objeto conforme seu estado interno muda.

**Estudar especialmente:**

- Context;
- State;
- ConcreteState;
- estados como objetos;
- transições;
- comparação com Strategy.

## 7.10 Strategy — p. 292

**Localização principal:** p. 292–300

**Intenção:** encapsular uma família de algoritmos intercambiáveis.

**Estudar especialmente:**

- Context;
- Strategy;
- ConcreteStrategy;
- composição;
- escolha de algoritmo;
- substituição em runtime;
- Strategy vs Template Method;
- Strategy vs State.

## 7.11 Template Method — p. 301

**Localização principal:** p. 301–304

**Intenção:** definir o esqueleto de um algoritmo e deixar determinados passos para subclasses.

**Estudar especialmente:**

- AbstractClass;
- ConcreteClass;
- template method;
- primitive operations;
- hooks;
- herança vs composição.

## 7.12 Visitor — p. 305

**Localização principal:** p. 305–317

**Intenção:** representar uma operação sobre elementos de uma estrutura permitindo adicionar novas operações sem modificar as classes dos elementos.

**Estudar especialmente:**

- Visitor;
- ConcreteVisitor;
- Element;
- ConcreteElement;
- accept;
- operações sobre estruturas;
- Visitor + Composite;
- Visitor + Interpreter.

## 7.13 Discussão sobre padrões comportamentais — p. 318–322

Use esta seção para estudar os temas comuns da família:

- encapsulamento de variações;
- objetos usados como argumentos;
- comunicação entre objetos;
- delegação;
- composição vs herança;
- diferenças de intenção entre patterns semelhantes.

---

# 8. Capítulo 6 — Conclusão

**Início:** página impressa 323

| Seção | Título | Página impressa |
|---|---|---:|
| 6.1 | O que esperar do uso de padrões de projeto | 323 |
| 6.2 | Uma breve história | 327 |
| 6.3 | A comunidade envolvida com padrões | 328 |
| 6.4 | Um convite | 330 |
| 6.5 | Um pensamento final | 330 |

## Pontos importantes

### p. 323–326 — O que esperar do uso de patterns

Use para estudar benefícios, limitações, custos e efeitos sobre reutilização, flexibilidade e documentação.

### p. 327 — Uma breve história

Use para estudar a evolução dos padrões e a influência de Christopher Alexander.

### p. 328–330 — Comunidade e linguagem de patterns

O livro compara os patterns de software com a linguagem de patterns de Alexander e ressalta que o catálogo não pretende formar uma linguagem completa capaz de gerar programas inteiros.

### p. 330 — Convite

Os autores incentivam o uso crítico dos patterns e o desenvolvimento de um vocabulário compartilhado.

---

# 9. Apêndice A — Glossário

**Página impressa:** 331–334

Use para consultar terminologia utilizada pelo livro, especialmente quando conceitos de orientação a objetos ou notação forem desconhecidos.

---

# 10. Apêndice B — Guia para a notação

**Página impressa:** 335–340

| Subseção | Conteúdo | Página |
|---|---|---:|
| B.1 | Diagrama de classe | 335 |
| B.2 | Diagrama de objeto | 336 |
| B.3 | Diagrama de interação | 338 |

Use este apêndice para interpretar os diagramas UML/OMT presentes no catálogo.

---

# 11. Apêndice C — Classes fundamentais

**Página impressa:** 341–346

| Subseção | Conteúdo | Página |
|---|---|---:|
| C1 | List | 341 |
| C2 | Iterator | 344 |
| C3 | ListIterator | 344 |
| C4 | Point | 345 |
| C5 | Rect | 346 |

---

# 12. Referências bibliográficas e índice

| Conteúdo | Página impressa |
|---|---:|
| Referências bibliográficas | 347–352 |
| Índice | 353–360 |

---

# 13. Índice rápido dos 23 Design Patterns

## Criação

| # | Pattern | Página impressa |
|---:|---|---:|
| 1 | Abstract Factory | 95 |
| 2 | Builder | 104 |
| 3 | Factory Method | 112 |
| 4 | Prototype | 121 |
| 5 | Singleton | 130 |

## Estruturais

| # | Pattern | Página impressa |
|---:|---|---:|
| 6 | Adapter | 140 |
| 7 | Bridge | 151 |
| 8 | Composite | 160 |
| 9 | Decorator | 170 |
| 10 | Façade | 179 |
| 11 | Flyweight | 187 |
| 12 | Proxy | 198 |

## Comportamentais

| # | Pattern | Página impressa |
|---:|---|---:|
| 13 | Chain of Responsibility | 212 |
| 14 | Command | 222 |
| 15 | Interpreter | 231 |
| 16 | Iterator | 244 |
| 17 | Mediator | 257 |
| 18 | Memento | 266 |
| 19 | Observer | 274 |
| 20 | State | 284 |
| 21 | Strategy | 292 |
| 22 | Template Method | 301 |
| 23 | Visitor | 305 |

---

# 14. Guia de consulta por problema

| Problema | Patterns para consultar | Localizações |
|---|---|---|
| Criar objetos sem depender de classes concretas | Abstract Factory, Factory Method, Prototype | 95, 112, 121 |
| Construir objeto complexo | Builder | 104 |
| Garantir instância única | Singleton | 130 |
| Adaptar interface incompatível | Adapter | 140 |
| Separar abstração de implementação | Bridge | 151 |
| Estrutura em árvore | Composite | 160 |
| Acrescentar responsabilidades | Decorator | 170 |
| Simplificar subsistema | Façade | 179 |
| Economizar memória com compartilhamento | Flyweight | 187 |
| Controlar acesso a objeto | Proxy | 198 |
| Encadear possíveis responsáveis | Chain of Responsibility | 212 |
| Transformar solicitação em objeto | Command | 222 |
| Interpretar linguagem | Interpreter | 231 |
| Percorrer coleção | Iterator | 244 |
| Centralizar comunicação | Mediator | 257 |
| Salvar/restaurar estado | Memento | 266 |
| Notificar dependentes | Observer | 274 |
| Alterar comportamento conforme estado | State | 284 |
| Trocar algoritmo | Strategy | 292 |
| Fixar algoritmo e variar etapas | Template Method | 301 |
| Adicionar operações a uma estrutura | Visitor | 305 |

---

# 15. Relações importantes entre patterns

| Relação | Referência |
|---|---|
| Abstract Factory ↔ Builder ↔ Factory Method ↔ Prototype ↔ Singleton | Discussão de criação, p. 136 |
| Adapter ↔ Bridge | Diferença de intenção, p. 151 e discussão estrutural |
| Adapter ↔ Decorator | Estrutura parecida, intenção diferente |
| Composite ↔ Iterator | Iterator frequentemente aplicado sobre Composite |
| Composite ↔ Visitor | Visitor opera naturalmente sobre Composite |
| Flyweight ↔ Composite | Compartilhamento de folhas dentro de estruturas |
| Flyweight ↔ State | Estados podem ser compartilhados |
| Flyweight ↔ Strategy | Strategies podem ser flyweights |
| Command ↔ Memento | Undo/redo |
| Mediator ↔ Observer | Comunicação e notificações |
| State ↔ Strategy | Estrutura semelhante, intenção diferente |
| Strategy ↔ Template Method | Algoritmo variável por composição vs herança |
| Visitor ↔ Interpreter | Visitor pode efetuar operações de interpretação |
| Chain of Responsibility ↔ Composite | Pai da estrutura pode funcionar como sucessor |

---

# 16. Páginas-chave para estudo

## Fundamentos

- **p. 17–19:** por que design OO reutilizável é difícil.
- **p. 19:** definição de Design Pattern.
- **p. 20–22:** patterns dentro de MVC.
- **p. 22–24:** estrutura descritiva dos patterns.
- **p. 25–26:** classificação.
- **p. 27–42:** problemas solucionados por patterns.
- **p. 43–45:** seleção e aplicação.

## Aplicação prática

- **p. 47–86:** estudo completo do Lexi.

## Catálogo

- **p. 91–138:** criação.
- **p. 139–210:** estrutural.
- **p. 211–322:** comportamental.

## Fechamento

- **p. 323–330:** consequências, história e comunidade.
- **p. 331–346:** material de referência.
- **p. 347–360:** referências e índice.

---

# 17. Referência para LLM/Agente

Use esta árvore para navegação rápida:

```text
Design Patterns
│
├── Fundamentos
│   ├── O que é Pattern ................ p. 19
│   ├── MVC ............................ p. 20
│   ├── Descrição dos Patterns ........ p. 22
│   ├── Catálogo ....................... p. 24
│   ├── Classificação .................. p. 25
│   ├── Problemas de Design ............ p. 27
│   ├── Seleção ......................... p. 43
│   └── Aplicação ....................... p. 44
│
├── Criação
│   ├── Abstract Factory ............... p. 95
│   ├── Builder ........................ p. 104
│   ├── Factory Method ................. p. 112
│   ├── Prototype ...................... p. 121
│   └── Singleton ...................... p. 130
│
├── Estruturais
│   ├── Adapter ........................ p. 140
│   ├── Bridge ......................... p. 151
│   ├── Composite ...................... p. 160
│   ├── Decorator ...................... p. 170
│   ├── Façade ........................ p. 179
│   ├── Flyweight ...................... p. 187
│   └── Proxy .......................... p. 198
│
├── Comportamentais
│   ├── Chain of Responsibility ........ p. 212
│   ├── Command ....................... p. 222
│   ├── Interpreter ................... p. 231
│   ├── Iterator ...................... p. 244
│   ├── Mediator ...................... p. 257
│   ├── Memento ....................... p. 266
│   ├── Observer ...................... p. 274
│   ├── State ......................... p. 284
│   ├── Strategy ...................... p. 292
│   ├── Template Method ............... p. 301
│   └── Visitor ....................... p. 305
│
└── Referência
    ├── Conclusão ...................... p. 323
    ├── Glossário ...................... p. 331
    ├── Notação ....................... p. 335
    ├── Classes fundamentais .......... p. 341
    ├── Bibliografia ................... p. 347
    └── Índice ......................... p. 353
```

---

## Fonte

Referência baseada integralmente no arquivo `design-pattern.pdf` fornecido nesta conversa, especialmente no sumário, capítulos, catálogo dos 23 patterns, estudo de caso Lexi, discussão sobre seleção/aplicação e apêndices.
