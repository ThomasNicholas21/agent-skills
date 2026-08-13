# Referência completa — Mergulho nos Padrões de Projeto

**Arquivo PDF Primário:** [design-pattern-refactoring-guru.pdf](pdf/design-pattern-refactoring-guru.pdf)  
**Documento Conceituador:** [desing-pattern-refactoring-guru.md](desing-pattern-refactoring-guru.md)  
**Autor:** Alexander Shvets — Refactoring.Guru  
**Versão indicada no PDF:** v2021-1.15  
**Total de páginas do arquivo:** 442 páginas no arquivo PDF  

> Este arquivo foi montado como um **índice de navegação para estudo/uso como contexto de LLM ou Agente**. As páginas abaixo usam dois números:
> - **Livro:** paginação impressa do próprio conteúdo.
> - **PDF:** página física no arquivo PDF aberto em um visualizador.

---

## Índice Padronizado para Agentes de IA

### Acesso Rápido a Seções Principais

- [1. Mapa rápido do livro](#1-mapa-rápido-do-livro)
- [2. Índice de navegação por tópico](#2-índice-de-navegação-por-tópico)
- [3. Introdução à Programação Orientada a Objetos](#3-introdução-à-programação-orientada-a-objetos)
- [4. Introdução aos Padrões de Projeto](#4-introdução-aos-padrões-de-projeto)
- [5. Princípios de Projeto de Software](#5-princípios-de-projeto-de-software)
- [6. SOLID](#6-solid)
- [7. Catálogo dos Padrões de Projeto](#7-catálogo-dos-padrões-de-projeto)
- [8. Padrões Criacionais](#8-padrões-criacionais)
- [9. Padrões Estruturais](#9-padrões-estruturais)
- [10. Padrões Comportamentais](#10-padrões-comportamentais)
- [11. Conclusão](#11-conclusão)
- [12. Índice por intenção](#12-índice-por-intenção)
- [13. Referência compacta para LLM/Agente](#13-referência-compacta-para-llmagente)

### Matriz de Mapeamento Direto — Padrões Refactoring Guru

| Padrão | Categoria | Livro (pág.) | PDF (pág.) | Seção no Markdown |
|---|---|---:|---:|---|
| Factory Method | Criacional | 80 | 81 | [8.2 Factory Method](#82-factory-method) |
| Abstract Factory | Criacional | 97 | 98 | [8.3 Abstract Factory](#83-abstract-factory) |
| Builder | Criacional | 113 | 114 | [8.4 Builder](#84-builder) |
| Prototype | Criacional | 134 | 135 | [8.5 Prototype](#85-prototype) |
| Singleton | Criacional | 150 | 151 | [8.6 Singleton](#86-singleton) |
| Adapter | Estrutural | 163 | 164 | [9.2 Adapter](#92-adapter) |
| Bridge | Estrutural | 177 | 178 | [9.3 Bridge](#93-bridge) |
| Composite | Estrutural | 194 | 195 | [9.4 Composite](#94-composite) |
| Decorator | Estrutural | 208 | 209 | [9.5 Decorator](#95-decorator) |
| Facade | Estrutural | 228 | 229 | [9.6 Facade](#96-facade) |
| Flyweight | Estrutural | 239 | 240 | [9.7 Flyweight](#97-flyweight) |
| Proxy | Estrutural | 254 | 255 | [9.8 Proxy](#98-proxy) |
| Chain of Responsibility | Comportamental | 272 | 273 | [10.2 Chain of Responsibility](#102-chain-of-responsibility) |
| Command | Comportamental | 292 | 293 | [10.3 Command](#103-command) |
| Iterator | Comportamental | 313 | 314 | [10.4 Iterator](#104-iterator) |
| Mediator | Comportamental | 329 | 330 | [10.5 Mediator](#105-mediator) |
| Memento | Comportamental | 345 | 346 | [10.6 Memento](#106-memento) |
| Observer | Comportamental | 362 | 363 | [10.7 Observer](#107-observer) |
| State | Comportamental | 378 | 379 | [10.8 State](#108-state) |
| Strategy | Comportamental | 395 | 396 | [10.9 Strategy](#109-strategy) |
| Template Method | Comportamental | 410 | 411 | [10.10 Template Method](#1010-template-method) |
| Visitor | Comportamental | 424 | 425 | [10.11 Visitor](#1011-visitor) |

---

## 1. Mapa rápido do livro

| Bloco | Livro | PDF | Conteúdo |
|---|---:|---:|---|
| Introdução à POO | 7–27 | 8–28 | POO, pilares e relações entre objetos |
| Introdução aos padrões | 28–34 | 29–35 | Conceito e importância dos padrões |
| Princípios de projeto | 35–55 | 36–56 | Princípios gerais |
| SOLID | 56–76 | 57–77 | SRP, OCP, LSP, ISP, DIP |
| Padrões criacionais | 78–159 | 79–160 | 5 padrões |
| Padrões estruturais | 160–267 | 161–268 | 7 padrões |
| Padrões comportamentais | 268–440 | 269–441 | 10 padrões |
| Conclusão | 441–442 | 442 | Encerramento |

---

# 2. Índice de navegação por tópico

## 2.1 Pré-texto e navegação

### Capa / identificação
- **Livro:** p. 2
- **PDF:** p. 2

### Direitos autorais
- **Livro:** p. 3
- **PDF:** p. 3

### Dedicatória
- **Livro:** p. 4
- **PDF:** p. 4

### Índice
- **Livro:** p. 4–5
- **PDF:** p. 5–6

### Como ler este livro
- **Livro:** p. 6
- **PDF:** p. 7

---

# 3. Introdução à Programação Orientada a Objetos

## 3.1 Visão geral
- **Livro:** p. 7–27
- **PDF:** p. 8–28

## 3.2 Básico da POO
- **Livro:** p. 8–13
- **PDF:** p. 9–14
- **Tópicos:** classes, objetos, estado, comportamento e UML básico.

## 3.3 Pilares da POO
- **Livro:** p. 14–21
- **PDF:** p. 15–22
- **Tópicos:** abstração, encapsulamento, herança, polimorfismo e interfaces.

## 3.4 Relações entre objetos
- **Livro:** p. 22–27
- **PDF:** p. 23–28
- **Tópicos:** dependência, associação, agregação, composição, implementação e herança.

---

# 4. Introdução aos Padrões de Projeto

## 4.1 Visão geral
- **Livro:** p. 28–34
- **PDF:** p. 29–35

## 4.2 O que é um padrão de projeto?
- **Livro:** p. 29–33
- **PDF:** p. 30–34

## 4.3 Por que devo aprender padrões?
- **Livro:** p. 34
- **PDF:** p. 35

---

# 5. Princípios de Projeto de Software

## 5.1 Visão geral
- **Livro:** p. 35–55
- **PDF:** p. 36–56

## 5.2 Características de um bom projeto
- **Livro:** p. 36–40
- **PDF:** p. 37–41

## 5.3 Princípios de projeto
- **Livro:** p. 41–55
- **PDF:** p. 42–56

### Encapsule o que varia
- **Livro:** p. 42–46
- **PDF:** p. 43–47

### Programe para uma interface, não uma implementação
- **Livro:** p. 47–51
- **PDF:** p. 48–52

### Prefira composição sobre herança
- **Livro:** p. 52–55
- **PDF:** p. 53–56

---

# 6. SOLID

## 6.1 Princípios SOLID
- **Livro:** p. 56–76
- **PDF:** p. 57–77

### S — Single Responsibility Principle
**Princípio de responsabilidade única**

- **Livro:** p. 57–58
- **PDF:** p. 58–59
- **Ideia central:** uma classe deve ter apenas uma razão para mudar.

### O — Open/Closed Principle
**Princípio aberto/fechado**

- **Livro:** p. 59–62
- **PDF:** p. 60–63
- **Ideia central:** aberto para extensão, fechado para modificação.

### L — Liskov Substitution Principle
**Princípio de substituição de Liskov**

- **Livro:** p. 63–69
- **PDF:** p. 64–70
- **Ideia central:** subclasses devem permanecer compatíveis com o contrato da superclasse.

### I — Interface Segregation Principle
**Princípio de segregação de interface**

- **Livro:** p. 70–72
- **PDF:** p. 71–73
- **Ideia central:** prefira interfaces menores e específicas.

### D — Dependency Inversion Principle
**Princípio de inversão de dependência**

- **Livro:** p. 73–76
- **PDF:** p. 74–77
- **Ideia central:** módulos de alto e baixo nível devem depender de abstrações.

---

# 7. Catálogo dos Padrões de Projeto

## 7.1 Visão geral
- **Livro:** p. 77–440
- **PDF:** p. 78–441

---

# 8. Padrões Criacionais

## 8.1 Visão geral
- **Livro:** p. 78–159
- **PDF:** p. 79–160

## 8.2 Factory Method
- **Livro:** p. 80–96
- **PDF:** p. 81–97
- **Intenção:** fornecer uma interface de criação e permitir que subclasses decidam o tipo concreto criado.
- **Questão de reconhecimento:** "A subclasse precisa decidir qual produto será criado?"

## 8.3 Abstract Factory
- **Livro:** p. 97–112
- **PDF:** p. 98–113
- **Intenção:** criar famílias de objetos relacionados.
- **Questão de reconhecimento:** "Preciso garantir que vários produtos sejam compatíveis entre si?"

## 8.4 Builder
- **Livro:** p. 113–133
- **PDF:** p. 114–134
- **Intenção:** construir objetos complexos passo a passo.
- **Questão de reconhecimento:** "O objeto precisa ser construído em várias etapas?"

## 8.5 Prototype
- **Livro:** p. 134–149
- **PDF:** p. 135–150
- **Intenção:** copiar objetos existentes por clonagem.
- **Questão de reconhecimento:** "É mais conveniente clonar um objeto já configurado do que construí-lo novamente?"

## 8.6 Singleton
- **Livro:** p. 150–159
- **PDF:** p. 151–160
- **Intenção:** garantir uma única instância e fornecer um ponto de acesso.
- **Questão de reconhecimento:** "Existe uma razão real para existir exatamente uma instância?"

---

# 9. Padrões Estruturais

## 9.1 Visão geral
- **Livro:** p. 160–267
- **PDF:** p. 161–268

## 9.2 Adapter
- **Livro:** p. 163–176
- **PDF:** p. 164–177
- **Intenção:** fazer interfaces incompatíveis colaborarem.
- **Questão de reconhecimento:** "Já existe um objeto útil, mas a interface dele não bate com a que meu código espera?"

## 9.3 Bridge
- **Livro:** p. 177–193
- **PDF:** p. 178–194
- **Intenção:** separar duas dimensões de variação em hierarquias independentes.
- **Questão de reconhecimento:** "Tenho duas dimensões que precisam evoluir separadamente?"

## 9.4 Composite
- **Livro:** p. 194–207
- **PDF:** p. 195–208
- **Intenção:** representar estruturas de árvore e tratar folhas e contêineres uniformemente.
- **Questão de reconhecimento:** "Meu domínio é naturalmente uma árvore?"

## 9.5 Decorator
- **Livro:** p. 208–227
- **PDF:** p. 209–228
- **Intenção:** adicionar responsabilidades sem modificar a classe original.
- **Questão de reconhecimento:** "Preciso combinar comportamentos dinamicamente mantendo a mesma interface?"

## 9.6 Facade
- **Livro:** p. 228–238
- **PDF:** p. 229–239
- **Intenção:** oferecer uma interface simples para um subsistema complexo.
- **Questão de reconhecimento:** "O cliente está tendo que conhecer detalhes demais de um subsistema?"

## 9.7 Flyweight
- **Livro:** p. 239–253
- **PDF:** p. 240–254
- **Intenção:** compartilhar estado comum entre muitos objetos para reduzir memória.
- **Questão de reconhecimento:** "Tenho muitos objetos semelhantes com dados repetidos?"

## 9.8 Proxy
- **Livro:** p. 254–267
- **PDF:** p. 255–268
- **Intenção:** fornecer um substituto que controla o acesso ao objeto real.
- **Questão de reconhecimento:** "Preciso controlar o acesso, adiar ou intermediar chamadas ao objeto real?"

---

# 10. Padrões Comportamentais

## 10.1 Visão geral
- **Livro:** p. 268–440
- **PDF:** p. 269–441

## 10.2 Chain of Responsibility
- **Livro:** p. 272–291
- **PDF:** p. 273–292
- **Intenção:** passar pedidos por uma cadeia de handlers.
- **Questão de reconhecimento:** "Qualquer um de vários handlers pode tratar esse pedido?"

## 10.3 Command
- **Livro:** p. 292–312
- **PDF:** p. 293–313
- **Intenção:** transformar uma operação/pedido em objeto.
- **Questão de reconhecimento:** "Preciso armazenar, enfileirar, adiar, serializar ou desfazer uma operação?"

## 10.4 Iterator
- **Livro:** p. 313–328
- **PDF:** p. 314–329
- **Intenção:** percorrer uma coleção sem expor sua estrutura interna.
- **Questão de reconhecimento:** "Quero separar a forma de percorrer da coleção em si?"

## 10.5 Mediator
- **Livro:** p. 329–344
- **PDF:** p. 330–345
- **Intenção:** centralizar comunicação entre componentes.
- **Questão de reconhecimento:** "Tenho muitos componentes se comunicando diretamente entre si?"

## 10.6 Memento
- **Livro:** p. 345–361
- **PDF:** p. 346–362
- **Intenção:** salvar/restaurar estado sem violar o encapsulamento.
- **Questão de reconhecimento:** "Preciso de snapshot/undo do estado?"

## 10.7 Observer
- **Livro:** p. 362–377
- **PDF:** p. 363–378
- **Intenção:** notificar vários assinantes sobre eventos.
- **Questão de reconhecimento:** "Vários objetos precisam reagir quando algo acontece?"

## 10.8 State
- **Livro:** p. 378–394
- **PDF:** p. 379–395
- **Intenção:** alterar comportamento do contexto conforme seu estado.
- **Questão de reconhecimento:** "Minha classe possui muitos condicionais relacionados ao estado?"

## 10.9 Strategy
- **Livro:** p. 395–409
- **PDF:** p. 396–410
- **Intenção:** encapsular e trocar algoritmos.
- **Questão de reconhecimento:** "Tenho várias maneiras de realizar o mesmo algoritmo?"

## 10.10 Template Method
- **Livro:** p. 410–423
- **PDF:** p. 411–424
- **Intenção:** manter a estrutura de um algoritmo fixa e permitir que etapas sejam sobrescritas.
- **Questão de reconhecimento:** "Tenho algoritmos quase iguais com algumas etapas diferentes?"

## 10.11 Visitor
- **Livro:** p. 424–440
- **PDF:** p. 425–441
- **Intenção:** separar operações dos elementos sobre os quais essas operações atuam.
- **Questão de reconhecimento:** "Tenho uma hierarquia de objetos relativamente estável e muitos comportamentos que preciso adicionar?"

---

# 11. Conclusão

- **Livro:** p. 441–442
- **PDF:** p. 442
- **Conteúdo:** encerramento do livro e sugestões para continuar estudando padrões/refatoração.

---

# 12. Índice por intenção

## Quero CRIAR objetos

| Problema | Referência |
|---|---|
| Subclasses escolhem o tipo criado | [Factory Method — livro p. 80](#82-factory-method) |
| Família de objetos relacionados | [Abstract Factory — livro p. 97](#83-abstract-factory) |
| Construção complexa passo a passo | [Builder — livro p. 113](#84-builder) |
| Clonar objeto existente | [Prototype — livro p. 134](#85-prototype) |
| Uma única instância | [Singleton — livro p. 150](#86-singleton) |

## Quero ESTRUTURAR objetos

| Problema | Referência |
|---|---|
| Interfaces incompatíveis | [Adapter — livro p. 163](#92-adapter) |
| Duas dimensões independentes | [Bridge — livro p. 177](#93-bridge) |
| Estrutura de árvore | [Composite — livro p. 194](#94-composite) |
| Adicionar responsabilidades | [Decorator — livro p. 208](#95-decorator) |
| Simplificar subsistema | [Facade — livro p. 228](#96-facade) |
| Compartilhar estado/memória | [Flyweight — livro p. 239](#97-flyweight) |
| Controlar acesso a um objeto | [Proxy — livro p. 254](#98-proxy) |

## Quero DISTRIBUIR comportamento

| Problema | Referência |
|---|---|
| Pedido percorre handlers | [Chain of Responsibility — livro p. 272](#102-chain-of-responsibility) |
| Transformar operação em objeto | [Command — livro p. 292](#103-command) |
| Percorrer coleção | [Iterator — livro p. 313](#104-iterator) |
| Centralizar comunicação | [Mediator — livro p. 329](#105-mediator) |
| Snapshot/undo | [Memento — livro p. 345](#106-memento) |
| Notificações | [Observer — livro p. 362](#107-observer) |
| Comportamento dependente de estado | [State — livro p. 378](#108-state) |
| Variar algoritmo | [Strategy — livro p. 395](#109-strategy) |
| Algoritmo com estrutura fixa | [Template Method — livro p. 410](#1010-template-method) |
| Adicionar operações a uma hierarquia | [Visitor — livro p. 424](#1011-visitor) |

---

# 13. Referência compacta para LLM/Agente

```text
POO
  8  Básico da POO
  14 Pilares da POO
  22 Relações entre objetos

PADRÕES
  29 O que é um padrão de projeto?
  34 Por que devo aprender padrões?

PRINCÍPIOS
  36 Características de um bom projeto
  41 Princípios de projeto
  42 Encapsule o que varia
  47 Programe para uma interface
  52 Prefira composição sobre herança

SOLID
  57 SRP
  59 OCP
  63 LSP
  70 ISP
  73 DIP

CRIACIONAIS
  80 Factory Method
  97 Abstract Factory
  113 Builder
  134 Prototype
  150 Singleton

ESTRUTURAIS
  163 Adapter
  177 Bridge
  194 Composite
  208 Decorator
  228 Facade
  239 Flyweight
  254 Proxy

COMPORTAMENTAIS
  272 Chain of Responsibility
  292 Command
  313 Iterator
  329 Mediator
  345 Memento
  362 Observer
  378 State
  395 Strategy
  410 Template Method
  424 Visitor

CONCLUSÃO
  441
```

---

## 14. Observação sobre paginação

As referências acima preservam a **paginação impressa indicada no próprio índice do livro** e também fornecem a página física correspondente no arquivo PDF.

O arquivo possui **442 páginas físicas**; o índice começa na página física 5 e aponta para a paginação impressa do livro. A conclusão está na página física 442. 
