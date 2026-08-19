# Knowledge: Convenções PEP 257 para Docstrings
## 1. Regras Principais
- Use aspas triplas duplas: `"""..."""`.
- Sempre inicie a primeira linha com verbo no **modo imperativo** (ex: `"Calculate the total price."`, não `"Calculates..."` ou `"Calculated..."`).
- Termine a primeira linha com ponto final.

## 2. Docstrings de Linha Única (*One-line*)
Para funções simples e óbvias:
```python
def is_active(self) -> bool:
    """Return whether the user account is active."""
    return self.status == "ACTIVE"
```

## 3. Docstrings Multilinha (*Multi-line*)
Estrutura recomendada:
```python
def process_refund(payment_id: str, amount: Decimal) -> RefundResult:
    """Process a partial or full refund for a settled transaction.

    Validate transaction status, communicate with payment gateway,
    and update local ledger records within an atomic block.

    Args:
        payment_id: Unique payment identifier.
        amount: Monetary value to refund.

    Raises:
        PaymentNotFoundError: If payment_id does not exist.
        InvalidRefundAmountError: If amount exceeds remaining balance.
    """
```