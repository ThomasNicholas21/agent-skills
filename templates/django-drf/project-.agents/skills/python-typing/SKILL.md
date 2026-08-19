---
name: python-typing
description: >-
  Especialista em Modern Python Type Hints (Python 3.12+), collections.abc, TypedDict,
  Protocol, NewType, Literal, Generics e type aliases.
---

# Modern Python Typing Skill (Python 3.12+)
Orienta a declaração de contratos estáticos de tipos em código Python moderno (3.10+, 3.12+).

## Quando Ativar
- Tipar funções, métodos, classes ou constantes em Python (quando solicitado).
- Declarar estruturas de dicionários e payloads com `TypedDict` (`NotRequired`, `ReadOnly`).
- Definir interfaces comportamentais (*structural typing*) com `Protocol`.
- Criar identificadores semânticos com `NewType`.
- Utilizar abstrações de coleções (`collections.abc.Sequence`, `Mapping`, `Iterable`).
- Criar classes ou aliases genéricos (`type UserId = int`, `class Repository[T]`).

## Conhecimento (`knowledge/`)
1. [`knowledge/modern-syntax.md`](./knowledge/modern-syntax.md): Generics embutidos (`list[T]`), união `A | B`, `T | None` e `type` aliases.
2. [`knowledge/domain-typing.md`](./knowledge/domain-typing.md): `TypedDict`, `NewType`, `Literal`, `Final` e `ClassVar`.
3. [`knowledge/protocols-and-generics.md`](./knowledge/protocols-and-generics.md): `Protocol` (*static duck typing*) e generics com `[T]`.
4. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão e proibições.

## Exemplos (`examples/`)
- [`examples/typed-dict-dto.md`](./examples/typed-dict-dto.md): Payloads DTO com `TypedDict`.
- [`examples/protocol-architecture.md`](./examples/protocol-architecture.md): Interfaces desacopladas com `Protocol`.
- [`examples/newtype-and-literals.md`](./examples/newtype-and-literals.md): IDs semânticos com `NewType` e status com `Literal`.

## Checklist
1. **Built-in Generics**: Usou `list[T]`, `dict[K, V]` em vez dos legados `typing.List`, `typing.Dict`?
2. **Sintaxe de Pipe**: Usou `A | B` e `T | None` em vez de `Union` e `Optional`?
3. **Abstração em Parâmetros**: Preferiu `Sequence[T]` ou `Iterable[T]` em argumentos de funções?
4. **Sem `Any` Genérico**: Evitou `Any` desnecessário buscando o tipo real ou usando `object`?
5. **Type Aliases Modernos**: Usou `type Alias = Type` (Python 3.12+)?