---
trigger:
  glob: "**/*.py"
---

# Regras de Desenvolvimento: Modern Python Type Hints (Python 3.12+)

Ao escrever ou modificar código Python, utilize o sistema moderno de type hints para declarar explicitamente contratos estáticos, parâmetros e retornos.

---

## 1. Tipagem Obrigatória e Sintaxe Moderna
- **Assinaturas Públicas**: Toda função e método público DEVE declarar anotações de tipo para todos os parâmetros e tipo de retorno (`-> ReturnType`).
- **Built-in Generics (Python 3.9+)**: Utilize sempre os tipos embutidos minúsculos (`list[str]`, `dict[str, Decimal]`, `set[int]`, `tuple[str, int]`). É **PROIBIDO** importar `List`, `Dict`, `Set` ou `Tuple` do módulo `typing`.
- **União e Opcionais (Python 3.10+)**: Utilize a sintaxe de pipe `A | B` para uniões e `T | None` para valores opcionais. É **PROIBIDO** utilizar `Union` ou `Optional` do módulo `typing`.
- **Aliases Modernos (Python 3.12+)**: Declare type aliases usando a palavra-chave `type` (ex: `type UserId = int` ou `type PaymentStatus = Literal["pending", "paid"]`).

---

## 2. Abstrações de Coleções (`collections.abc`)
- **Usar Abstrações**: Em argumentos de funções, prefira tipos abstratos do `collections.abc` (`Sequence[T]`, `Iterable[T]`, `Mapping[K, V]`, `Callable[...]`) em vez de exigir tipos concretos (`list[T]` ou `dict[K, V]`), a menos que a implementação exija a classe concreta.

---

## 3. Tipos Avançados de Domínio e Contratos
- **`TypedDict`**: Utilize para dicionários estruturados com schemas conhecidos (ex: payloads de APIs, configurações).
- **`Protocol`**: Utilize para contratos comportamentais (*structural typing / static duck typing*) sem exigir herança de classe base.
- **`NewType`**: Utilize para distinguir tipos semânticos que possuem a mesma representação primitiva (ex: `UserId = NewType("UserId", int)` vs `OrderId = NewType("OrderId", int)`).
- **`Literal`**: Utilize para argumentos ou tipos que aceitam um conjunto fechado de valores string/int.
- **`Final` & `ClassVar`**: Utilize `Final` para valores imutáveis/constantes e `ClassVar` para atributos pertencentes à classe.

---

## 4. Proibições Estritas
- **Não usar `Any` por conveniência**: NUNCA utilize `Any` quando um tipo mais preciso puder ser determinado.
- **`object` vs `Any`**: Use `object` quando qualquer tipo for aceito mas a verificação estática deva ser preservada.
- **Type Hints NÃO substituem Validação Runtime**: Type hints declaram contratos estáticos para IDEs e linters, mas NÃO executam validação em runtime (ex: `is_valid()` do DRF ou Pydantic).
- **Não usar `cast()` para silenciar linters**: NUNCA use `cast()` como substituto de validação ou de narrowed types reais.

---

## 5. Gatilho de Invocação de Skill

> *Para implementar Protocols, TypedDicts avançados, Generics modernos ou NewTypes em arquitetura Python, **invoque a skill `python-typing`**.*
