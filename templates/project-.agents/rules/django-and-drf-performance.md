---
trigger:
  glob: "**/*.py"
---

# Regras de Performance: Django & DRF

Princípio: **Medir com evidências (`EXPLAIN ANALYZE`, queries) → Menor otimização no SGBD → Medir novamente.**

---

## 1. Otimização de Queries & Prevenção de N+1

| Técnica | Quando Usar | Sintaxe Otimizada |
| :--- | :--- | :--- |
| **`select_related`** | `ForeignKey`, `OneToOne` (SQL JOIN) | `Order.objects.select_related("user", "payment")` |
| **`prefetch_related`** | `ManyToManyField`, Reverse FK | `User.objects.prefetch_related("groups", "orders")` |
| **`Prefetch()`** | Filtrar relacionamentos na pré-busca | `Prefetch("services", queryset=Service.objects.filter(is_active=True))` |
| **`only()` / `defer()`** | Omitir colunas pesadas/não usadas | `User.objects.only("id", "email")` / `defer("logs")` |
| **`values()` / `values_list()`** | Quando não precisa de instâncias | `User.objects.values("id", "name")` / `values_list("id", flat=True)` |
| **`exists()` vs `count()`** | Verificar existência sem carregar | `if qs.exists():` (NUNCA usar `len(qs)` ou `qs.count() > 0`) |
| **`count()`** | Quantidade real no SGBD | `total = qs.count()` (NUNCA usar `len(list(qs))`) |

---

## 2. Subqueries e Agregações Avançadas

Nunca faça cálculos ou sub-buscas em loops Python. Execute no SGBD:

```python
from django.db.models import (
    Avg,
    Count,
    Exists,
    F,
    Max,
    OuterRef,
    Q,
    Subquery,
    Sum,
)

# 1. Subquery & Exists correlacionados
latest_pay = Payment.objects.filter(order=OuterRef("pk")).order_by(
    "-created_at"
)
has_items = Exists(
    OrderItem.objects.filter(order=OuterRef("pk"), status="PENDING")
)

orders = Order.objects.annotate(
    latest_amount=Subquery(latest_pay.values("amount")[:1]),
    has_pending=has_items,
)

# 2. Agregações & Expressions no Banco
stats = Professional.objects.annotate(
    total=Count("services"), avg_rating=Avg("reviews__rating")
)
Product.objects.filter(id=p_id).update(
    stock=F("stock") - 1
)  # Sem race condition
User.objects.filter(Q(name__icontains=term) | Q(email__icontains=term))
```

---

## 3. Serializers & Prevenção de N+1 no DRF

- **PROIBIDO**: Queries dentro de `SerializerMethodField` em listagens.
- **OBRIGATÓRIO**: Calcular agregações via `annotate()` no QuerySet do ViewSet e mapear no Serializer como campo somente leitura.

```python
# ViewSet:
queryset = Professional.objects.annotate(
    total_services=Count("services")
).select_related("user")


# Serializer:
class ProfessionalSerializer(serializers.ModelSerializer):
  total_services = serializers.IntegerField(read_only=True)

  class Meta:
    model = Professional
    fields = ["id", "name", "total_services"]
```

---

## 4. Mutações em Lote, Índices & Concorrência

```python
# Mutações em lote
Notification.objects.bulk_create(notif_list, batch_size=500)
Notification.objects.bulk_update(notif_list, fields=["status"], batch_size=500)
Order.objects.filter(status="PENDING").update(status="CANCELLED")

# Transações curtas (NUNCA fazer chamadas HTTP dentro de atomic)
with transaction.atomic():
  order = Order.objects.create(...)
send_async_webhook(order.id)  # Fora da transação
```

- **Índices**: Adicione `db_index=True` ou `Meta.indexes` em colunas de `WHERE`, `JOIN` e `ORDER BY`.
- **Paginação**: Obrigatória em todos os endpoints de lista (`PageNumberPagination` ou `CursorPagination` para alto volume).

---

## 5. Cache (Redis) & Tarefas Assíncronas (Celery)

- **Redis**: Usar apenas para dados caros e pouco mutáveis (`cache.get_or_set(...)`). O Redis NÃO substitui índices nem correção de N+1.
- **Celery**: Mover processamento pesado para background: e-mails, relatórios, PDFs e APIs externas (Gateways, Webhooks).

---

## 6. Checklist de Auditoria Automática

- [ ] Sem queries em loops Python ou `SerializerMethodField` (usar `annotate`/`Subquery`).
- [ ] `select_related()` (FK/OneToOne) e `prefetch_related()` (M2M/Reverse FK) aplicados.
- [ ] `only()` ou `values()` usados quando nem todos os campos são necessários.
- [ ] `exists()` usado para testes booleanos de existência.
- [ ] Operações de escrita em massa usam `bulk_create` / `bulk_update` / `update`.
- [ ] Paginação ativada (`PAGE_SIZE = 25`).
- [ ] Sem chamadas de API externas síncronas bloqueantes dentro do ciclo HTTP ou transação.
- [ ] Código Python limpo, sem docstrings redundantes e sem anotações de tipagem.
