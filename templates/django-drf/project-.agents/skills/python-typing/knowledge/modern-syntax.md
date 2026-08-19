# Knowledge: Sintaxe Moderna de Type Hints em Python (3.10+ / 3.12+)

## 1. Built-in Generics (Python 3.9+)
Proibido importar `List`, `Dict`, `Set`, `Tuple` de `typing`. Use tipos nativos:
- `list[str]`
- `dict[str, Decimal]`
- `set[int]`
- `tuple[str, int]` (fixo) / `tuple[int, ...]` (variável)

## 2. Union e Optional com Pipe `|` (Python 3.10+)
Proibido usar `Union` e `Optional`. Use a sintaxe de pipe:
- `int | str` em vez de `Union[int, str]`
- `str | None` em vez de `Optional[str]`

## 3. Collections Abstractions (`collections.abc`)
Em argumentos de funções, use abstrações em vez de tipos concretos:
```python
from collections.abc import Sequence, Mapping, Iterable, Callable


def process_items(items: Sequence[Item]) -> list[Result]: ...
```

## 4. Modern Type Aliases (Python 3.12+)
Use a palavra-chave nativa `type`:
```python
type UserId = int
type JsonDict = dict[str, object]
type Coordinates[T] = tuple[T, T]
```