# Knowledge: Documentar Intenção e Regras em vez de Implementação ou Tipos

---

## 1. Intenção vs Implementação

Uma docstring DEVE responder **"Para que esta função existe no domínio?"** e NUNCA apenas explicar o algoritmo interno linha por linha:

- **Incorreto (Descreve Implementação)**:
  ```python
  def calculate_total(price: Decimal, quantity: int) -> Decimal:
      """Multiply price by quantity."""
  ```
- **Correto (Descreve Intenção)**:
  ```python
  def calculate_total(price: Decimal, quantity: int) -> Decimal:
      """Calculate the total gross amount for the requested order items."""
  ```

---

## 2. Não Duplicar Assinaturas ou Type Hints

Quando a assinatura da função já contém anotações de tipo completas (`type hints`), é desnecessário duplicar a lista de tipos em blocos de documentação detalhados no estilo Sphinx/Google, a menos que o projeto exija explicitamente:

- **Redundante e Desnecessário**:
  ```python
  def create_user(name: str, age: int) -> User:
      """
      Create a user.

      Args:
          name (str): User name.
          age (int): User age.

      Returns:
          User: Created user instance.
      """
  ```
- **Limpo e Eficiente (Recomendado)**:
  ```python
  def create_user(name: str, age: int) -> User:
      """Create and persist a new active user."""
  ```

---

## 3. O que Realmente Deve ser Documentado em Funções Complexas

1. **Intenção do Domínio**: Qual problema do negócio esta função resolve.
2. **Pré-condições Relevantes**: Requisitos de estado prévio do sistema.
3. **Efeitos Colaterais**: Alterações de estado no banco de dados, disparos de eventos ou chamadas de API externas.
4. **Exceções do Contrato Público**: Exceções customizadas que o chamador deve capturar.
