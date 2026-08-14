# Knowledge: Sintaxe Moderna de Type Hints em Python (3.9+ / 3.10+ / 3.12+)

---

## 1. Generics Embutidos (`Built-in Generics` - Python 3.9+)

É **estritamente proibido** importar `List`, `Dict`, `Set`, `Tuple` ou `FrozenSet` do módulo `typing`. O Python moderno permite parametrizar diretamente os tipos nativos:

- `list[str]`
- `dict[str, Decimal]`
- `set[int]`
- `tuple[str, int]` (tupla de tamanho fixo com elemento 0 str e elemento 1 int)
- `tuple[int, ...]` (tupla homogênea de tamanho variável)

---

## 2. Abstrações de Coleções (`collections.abc`)

Para parâmetros de funções, prefira tipos abstratos do módulo `collections.abc` em vez de exigir tipos concretos:

```python
from collections.abc import Sequence, Mapping, Iterable, Callable
from decimal import Decimal

# Preferir Sequence (aceita list, tuple) em vez de obrigar list
def calculate_total(values: Sequence[Decimal]) -> Decimal:
    return sum(values, Decimal("0"))

# Preferir Mapping (aceita dict, OrderedDict) em vez de dict
def process_headers(headers: Mapping[str, str]) -> None:
    ...
```

---

## 3. União (`|`) e Opcionais (`T | None` - Python 3.10+)

É **estritamente proibido** importar `Union` ou `Optional` do módulo `typing`.

```python
# União de tipos (A | B)
def parse_id(value: int | str) -> int:
    return int(value)

# Retorno opcional (T | None)
def find_user(user_id: int) -> User | None:
    ...
```

---

## 4. Modern Type Aliases (`type` Statement - Python 3.12+)

A partir do Python 3.12, aliases de tipos são declarados nativamente com a instrução `type`:

```python
type UserId = int
type JsonDict = dict[str, object]
type ServerAddress = tuple[str, int]
```
