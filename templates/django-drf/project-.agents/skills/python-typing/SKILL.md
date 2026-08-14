---
name: python-typing
description: >-
  Especialista em Modern Python Type Hints (Python 3.12+ / 3.13 / 3.14), collections.abc,
  TypedDict, Protocol, NewType, Literal, Generics e type aliases.
---

# Modern Python Typing Skill (Python 3.12+)

Esta habilidade orienta a declaração de contratos estáticos de tipos em código Python moderno, utilizando a sintaxe nativa do Python 3.9+, 3.10+, 3.12+ e 3.13+.

---

## Quando Ativar Esta Skill

Ative esta skill quando a tarefa envolver:
- Tipar funções, métodos, classes ou constantes em código Python novo ou refatorado.
- Declarar estruturas de dicionários e payloads com `TypedDict` (`NotRequired`, `ReadOnly`).
- Definir interfaces comportamentais (*structural typing*) com `Protocol`.
- Criar identificadores semânticos com `NewType` para evitar ambiguidades de IDs.
- Utilizar abstrações de coleções (`collections.abc.Sequence`, `Mapping`, `Iterable`, `Callable`).
- Criar classes ou aliases genéricos (`class Repository[T]`, `type UserId = int`).

---

## Índice de Conhecimento Profundo (`knowledge/`)

1. [`knowledge/modern-syntax.md`](./knowledge/modern-syntax.md): Generics embutidos (`list[T]`, `dict[K, V]`), `collections.abc`, união `A | B`, `T | None` e `type` aliases (3.12+).
2. [`knowledge/domain-typing.md`](./knowledge/domain-typing.md): `TypedDict` (`NotRequired`, `ReadOnly`), `NewType`, `Literal`, `Final` e `ClassVar`.
3. [`knowledge/protocols-and-generics.md`](./knowledge/protocols-and-generics.md): `Protocol` (*static duck typing*), classes e funções genéricas (`[T]`), `ParamSpec`.
4. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão para escolha de construtos de tipagem e regras estritas.

---

## Exemplos de Código (`examples/`)

- [`examples/typed-dict-dto.md`](./examples/typed-dict-dto.md): Payloads de DTO e configurações com `TypedDict`.
- [`examples/protocol-architecture.md`](./examples/protocol-architecture.md): Arquitetura desacoplada utilizando `Protocol`.
- [`examples/newtype-and-literals.md`](./examples/newtype-and-literals.md): IDs semânticos com `NewType` e status com `Literal`.

---

## Checklist de Implementação de Type Hints

1. **Built-in Generics**: Usou `list[T]`, `dict[K, V]` em vez dos legados `typing.List`, `typing.Dict`?
2. **Sintaxe de Pipe**: Usou `A | B` e `T | None` em vez de `Union[A, B]` e `Optional[T]`?
3. **Abstração em Parâmetros**: Preferiu `Sequence[T]` ou `Iterable[T]` do `collections.abc` em vez de `list[T]` nos argumentos de entrada?
4. **Sem `Any` Frívolo**: Evitou usar `Any` para calar o linters e investigou o tipo real ou usou `object`?
5. **Modern Type Alias**: Declarou aliases usando a sintaxe moderna `type Alias = Type` (Python 3.12+)?
