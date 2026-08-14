# Knowledge: Scoping e Otimização de QuerySet em ViewSets

---

## 1. Scoping por Usuário / Multi-tenancy
Nunca exponha `queryset = Order.objects.all()` estático na classe quando a API for restrita ao usuário autenticado.

Sobrescreva `get_queryset()`:

```python
def get_queryset(self):
    user = self.request.user
    if user.is_staff:
        return Order.objects.all()
    return Order.objects.filter(user=user)
```

---

## 2. Eliminação de N+1 Queries
Sempre inclua junções antecipadas no `get_queryset()`:
- `select_related()`: Para relacionamentos 1:1 e N:1 (`ForeignKey`).
- `prefetch_related()`: Para relacionamentos 1:N reversos e N:N (`ManyToManyField`).

```python
def get_queryset(self):
    return (
        Order.objects.filter(user=self.request.user)
        .select_related("user", "shipping_address")
        .prefetch_related("items__product")
    )
```
