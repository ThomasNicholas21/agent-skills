# Example: IDs Semânticos com NewType e Enums Estáticos com Literal
```python
from typing import NewType, Literal
from decimal import Decimal

# IDs semanticamente distintos baseados em int para evitar trocas acidentais de parametros
UserId = NewType("UserId", int)
OrderId = NewType("OrderId", int)

# Conjunto fechado de estados de pedido
type OrderStatus = Literal["draft", "pending", "paid", "cancelled"]


def update_order_status(
    user_id: UserId, order_id: OrderId, new_status: OrderStatus
) -> None:
    """Atualiza o status de um pedido pertencente a um usuario especifico."""
    ...


# Uso correto:
user_id = UserId(100)
order_id = OrderId(500)
update_order_status(user_id, order_id, "paid")
```