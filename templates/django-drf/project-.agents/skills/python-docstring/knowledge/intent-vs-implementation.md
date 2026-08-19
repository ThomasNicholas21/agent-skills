# Knowledge: Documentar Intenção vs Implementação
## 1. Intenção vs Implementação
A docstring deve responder **"Por que esta função existe no domínio?"** e não reescrever o algoritmo linha por linha.

- **Incorreto (descreve algoritmo / tipos repetidos)**:
  ```python
  def calculate_discount(price: Decimal, rate: float) -> Decimal:
      """Multiply price by rate and cast to decimal."""
  ```

- **Correto (descreve intenção e regras de negócio)**:
  ```python
  def calculate_discount(price: Decimal, rate: float) -> Decimal:
      """Calculate final order discount applying tenant-specific promotional rules."""
  ```

## 2. Não Duplicar Type Hints
Evite declarar tipos redundantes na docstring (ex: `Args: price (Decimal): ...`). O sistema de tipagem estática do Python já fornece essa informação.