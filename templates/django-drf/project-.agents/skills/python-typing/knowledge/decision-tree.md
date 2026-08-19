# Knowledge: Árvore de Decisão de Type Hints e Regras Estritas
## 1. Árvore de Decisão para Seleção de Construtos de Tipagem
```text
QUAL É O TIPO OU CONTRATO QUE PRECISO TIPAR?
1. Tipo primitivo simples ou classe de domínio?
   └── Usar str, int, float, Decimal, bool, User, Order.
2. Coleção de dados?
   ├── No retorno de função ────────> Usar list[T], dict[K, V], set[T], tuple[T, ...].
   └── Em argumento de função ─────> Usar Sequence[T], Mapping[K, V], Iterable[T] (collections.abc).
3. Estrutura de Dicionário com chaves conhecidas?
   └── Usar TypedDict.
4. Contrato de Interface/Comportamento de Classe?
   └── Usar Protocol.
5. Valor de string/int pertencente a um conjunto fixo de opções?
   └── Usar Literal["a", "b", "c"].
6. Tipos que são a mesma primitiva (int), mas representam entidades diferentes (UserId vs OrderId)?
   └── Usar NewType("UserId", int).
7. Função, Classe ou Alias Genérico?
   └── Usar sintaxe moderna Python 3.12+: class Repo[T]: ..., def first[T](...): ...
```

## 2. Regras Estritas de Proibição
1. **NUNCA** importe `List`, `Dict`, `Set`, `Tuple`, `Union` ou `Optional` do módulo `typing`. Use `list[T]`, `dict[K, V]`, `A | B` e `T | None`.
2. **NUNCA** use `Any` por conveniência ou para calar linters. Se qualquer objeto for aceito sem perder a verificação estática, use `object`.
3. **NUNCA** use `cast()` como substituto de validação de runtime ou narrowing real.
4. **NUNCA** confunda type hints com validação em tempo de execução. Type hints servem para análise estática.