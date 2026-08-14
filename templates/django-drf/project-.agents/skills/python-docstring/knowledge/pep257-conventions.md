# Knowledge: Convenções PEP 257 para Docstrings em Python

O PEP 257 estabelece a guideline oficial para a estruturação de docstrings em Python.

---

## 1. Localização e Acesso a Docstrings

Uma docstring é a primeira instrução literal no corpo de um módulo, classe, função ou método:

```python
def calculate_total(price: Decimal, quantity: int) -> Decimal:
    """Calculate the total price for a given quantity."""
    return price * quantity
```

A docstring fica automaticamente disponível em runtime através do atributo `calculate_total.__doc__`.

---

## 2. Forma Imperativa ("Do this", não "Does this")

O resumo da docstring DEVE ser escrito como uma frase imperativa ordenando a ação:

- **Correto (Imperativo)**: `"""Calculate the transaction fee."""`
- **Incorreto (Narrativo)**: `"""Calculates the transaction fee."""`
- **Incorreto (Informativo)**: `"""Calculated transaction fee."""`

---

## 3. Formatação de Line Docstrings

### One-line Docstrings (Linha Única)
Utilizada para funções ou métodos cuja operação é simples e autoevidente:

- Utilizar sempre aspas duplas triplas `"""..."""`.
- Manter tudo em uma única linha.
- Iniciar com verbo imperativo com maiúscula e terminar com ponto final.

### Multi-line Docstrings (Multilinha)
Utilizada quando a operação envolve regras de negócio, efeitos colaterais ou pré-condições:

```python
def process_payment(payment: Payment, *, capture: bool = True) -> PaymentResult:
    """
    Process a payment transaction through the configured gateway.

    Validates the payment payload before dispatching. If capture is True,
    the funds are captured immediately; otherwise, an authorization is created.
    """
```

- **Resumo**: Primeira linha contendo frase sumarizada curta.
- **Linha em Branco**: Obrigatoriamente uma linha em branco após a frase de resumo.
- **Corpo Detalhado**: Descrição do comportamento público, regras de negócio e exceções.
