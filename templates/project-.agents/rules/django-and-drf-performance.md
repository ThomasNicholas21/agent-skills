---
trigger:
  glob: "**/*.py"
---

# Guia Mestre de Performance Django + Django REST Framework para Agentes de IA e LLMs

## Objetivo

Este documento instrui Agentes de IA e sistemas LLM a **analisar, diagnosticar e implementar otimizações de performance de alta eficiência em projetos Django e Django REST Framework (DRF)**.

A IA DEVE seguir este princípio arquitetural estrito:

> **Nunca otimizar por intuição quando for possível medir. Primeiro identificar o gargalo com evidências empíricas; aplicar a menor alteração necessária; por fim medir novamente.**

### Hierarquia Padrão de Prioridade de Otimização:

1. **Banco de Dados e ORM** (Queries ineficientes, filtros em Python)
2. **N+1 Queries** (Serializers, loops e relacionamentos)
3. **Subqueries e Agregações no Banco** (`Subquery`, `OuterRef`, `annotate`, `aggregate`)
4. **Índices** (Campos de `WHERE`, `JOIN`, `ORDER BY`, compostos e parciais)
5. **Serialização** (`ReadSerializer` vs `WriteSerializer`, `SerializerMethodField`)
6. **Paginação** (`PageNumberPagination`, `CursorPagination`)
7. **Cache** (Redis para dados caros/pouco mutáveis)
8. **Processamento Assíncrono** (Celery / tarefas de background)
9. **Integrações Externas** (Timeouts, retries, idempotência)
10. **Profiling e Observabilidade** (`EXPLAIN ANALYZE`, Silk, APM, P95/P99)

---

# 1. Modelo Mental de Performance

Quando uma API Django / DRF apresenta latência elevada, a IA DEVE decompor a requisição:

```text
HTTP Request
    │
    ├── Middleware
    ├── Authentication & Permissions
    ├── View / ViewSet
    ├── ORM / SGBD (PostgreSQL)
    ├── Business Logic (Service Layer)
    ├── Serializer
    ├── External APIs
    └── HTTP Response
```

O objetivo principal é descobrir **qual dessas etapas representa a maior fatia do tempo de execução**.

### Exemplo de Diagnóstico:

```text
Tempo Total da Requisição: 900 ms

PostgreSQL:      650 ms  <-- GARGALO REAL (Atacar aqui primeiro)
Serializer:      130 ms
External API:     80 ms
Python/Core:      30 ms
Middleware:       10 ms
```

Neste cenário, reescrever código Python em C ou refatorar métodos não produzirá impacto mensurável. A IA deve otimizar o banco de dados.

---

# 2. Medir Antes de Otimizar

A IA DEVE responder a estas perguntas com evidências antes de alterar código:

- Quantas queries SQL são executadas?
- Quanto tempo cada query consome?
- Existe padrão N+1?
- Quais tabelas e colunas são carregadas?
- O índice do banco está sendo utilizado (`Index Scan` vs `Seq Scan`)?
- O serializer acessa relacionamentos não pré-carregados?
- Há chamadas HTTP bloqueantes a APIs externas no ciclo do request?
- O payload JSON é maior do que o cliente necessita?

### Ferramentas de Medição:
`Django Debug Toolbar`, `Django Silk`, `Sentry / APM`, `EXPLAIN ANALYZE`, `django.db.connection.queries`.

---

# 3. Avaliação Lazy de QuerySets

QuerySets possuem avaliação preguiçosa (*lazy evaluation*). O banco só é consultado quando o QuerySet é avaliado:

- Iteração (`for obj in queryset:`)
- Fatiamento com passo (`queryset[::2]`)
- Avaliação de tamanho em Python (`len(queryset)`)
- Conversão para lista (`list(queryset)`)
- Teste lógico de boolean em Python (`if queryset:`)
- Acesso de dados pelo Serializer (`serializer.data`)

---

# 4. `only()`: Carregar Somente os Campos Necessários

Evite carregar colunas pesadas que não serão utilizadas:

```python
# CORRETO (Carrega apenas os campos utilizados)
users = User.objects.only("id", "name", "email")
```

```python
# EVITAR (Carrega dezenas de colunas desnecessárias)
users = User.objects.all()
```

> **Aviso para IA**: Acessar um campo omitido pelo `only()` posteriormente no código gerará uma nova consulta SQL individual. Use `only()` considerando **todos** os campos acessados na resposta.

---

# 5. `defer()`: Omitir Campos Volumosos

Para ignorar campos pesados (`JSONField`, `TextField` extensos, blobs):

```python
users = User.objects.defer("large_metadata", "historical_logs")
```

---

# 6. `values()` e `values_list()`

Se a aplicação não necessita de objetos Django completos (`Model instances`), retorne estruturas planas (dicionários ou tuplas):

```python
# Retorna lista de dicionários leves
users = User.objects.values("id", "name", "email")

# Retorna lista plana de IDs
user_ids = User.objects.values_list("id", flat=True)
```

---

# 7. `exists()` vs `count()` vs `len()`

Para verificar se um registro existe no banco:

```python
# CORRETO (Executa SELECT 1 ... LIMIT 1)
if queryset.exists():
  pass
```

```python
# EVITAR (Executa SELECT COUNT(*))
if queryset.count() > 0:
  pass
```

```python
# EVITAR (Carrega TODOS os objetos na memória)
if len(queryset) > 0:
  pass
```

---

# 8. `count()` para Contagem Real

Quando for necessário obter a quantidade exata:

```python
# CORRETO
total = queryset.count()
```

```python
# EVITAR (Carrega objetos para contar em Python)
total = len(list(queryset))
```

---

# 9. `select_related()` (Otimização para JOIN)

Utilize `select_related()` para relacionamentos de valor único resolvíveis via SQL `JOIN`:
- `ForeignKey`
- `OneToOneField`

```python
orders = Order.objects.select_related("patient", "professional", "payment")
```

Sem `select_related()`, iterar sobre os pedidos gera 1 query inicial + N queries adicionais para cada relacionamento (N+1).

---

# 10. `prefetch_related()` (Otimização para Multivalorados)

Utilize `prefetch_related()` para relacionamentos multivalorados executados em consultas separadas combinadas via Python:
- `ManyToManyField`
- `Reverse ForeignKey`

```python
professionals = Professional.objects.prefetch_related(
    "services", "availabilities"
)
```

---

# 11. Combinando `select_related()` e `prefetch_related()`

```python
appointments = (
    Appointment.objects.select_related("patient", "professional", "payment")
    .prefetch_related("services", "documents")
)
```

---

# 12. `Prefetch()` com QuerySet Customizado

Filtre e ordene dados pré-carregados antes de trazê-los para a memória:

```python
from django.db.models import Prefetch

active_services = Service.objects.filter(is_active=True)

professionals = Professional.objects.prefetch_related(
    Prefetch("services", queryset=active_services, to_attr="active_services_list")
)
```

---

# 13. Subqueries Avançadas (`Subquery`, `OuterRef` e `Exists`)

Quando for necessário buscar valores calculados de tabelas relacionadas sem fazer JOINs pesados ou trazer múltiplos registros:

```python
from django.db.models import Exists, OuterRef, Subquery
from apps.orders.models import OrderItem, Payment

# 1. Subquery para buscar o valor do último pagamento
latest_payment_amount = Payment.objects.filter(
    order=OuterRef("pk")
).order_by("-created_at").values("amount")[:1]

# 2. Exists para verificar sub-recursos sem JOIN
has_pending_items = Exists(
    OrderItem.objects.filter(order=OuterRef("pk"), status="PENDING")
)

orders = Order.objects.annotate(
    latest_payment=Subquery(latest_payment_amount),
    has_pending=has_pending_items,
)
```

---

# 14. Eliminando N+1 em Serializers

### PERIGO: Query oculta dentro de `SerializerMethodField`

```python
# EVITAR (Gera N+1 se chamado em listagem)
class ProfessionalSerializer(serializers.ModelSerializer):
  total_services = serializers.SerializerMethodField()

  def get_total_services(self, obj):
    return obj.services.count()  # Executa 1 query por objeto!
```

### CORREÇÃO: Usar `annotate()` no QuerySet do ViewSet

```python
from django.db.models import Count

# No ViewSet:
queryset = Professional.objects.annotate(total_services=Count("services"))


# No Serializer:
class ProfessionalSerializer(serializers.ModelSerializer):
  total_services = serializers.IntegerField(read_only=True)

  class Meta:
    model = Professional
    fields = ["id", "name", "total_services"]
```

---

# 15. Agregações no SGBD (`annotate` e `aggregate`)

Utilize o banco de dados para cálculos em vez de iterar em Python:

```python
from django.db.models import Avg, Count, Max, Min, Sum

stats = Professional.objects.annotate(
    total_services=Count("services"),
    avg_rating=Avg("reviews__rating"),
    max_price=Max("services__price"),
)
```

---

# 16. `F()` Expressions (Operações no Banco & Concorrência)

Execute atualizações diretamente na base sem carregar a instância para o Python:

```python
from django.db.models import F

# Atualização direta no SGBD sem race condition
Product.objects.filter(id=product_id).update(stock=F("stock") - 1)
```

---

# 17. `Q()` Expressions (Filtros Lógicos Complexos)

```python
from django.db.models import Q

users = User.objects.filter(
    Q(name__icontains=search_term) | Q(email__icontains=search_term)
)
```

---

# 18. Operações em Lote (`bulk_create`, `bulk_update`, `update`)

```python
# Criar em lote
Notification.objects.bulk_create(notifications_list, batch_size=500)

# Atualizar em lote
Notification.objects.bulk_update(
    notifications_list, fields=["status"], batch_size=500
)

# Atualizar via QuerySet
Order.objects.filter(status="PENDING").update(status="CANCELLED")
```

---

# 19. Índices e Performance no Banco

Adicione `db_index=True` ou `Meta.indexes` para colunas utilizadas em:
- `WHERE` (Filtros)
- `JOIN` (Chaves estrangeiras)
- `ORDER BY` (Ordenação)
- `UNIQUE` (Restrições)

```python
class Meta:
  indexes = [
      models.Index(fields=["status", "created_at"]),
  ]
```

---

# 20. `EXPLAIN ANALYZE` no PostgreSQL

Investigue planos de execução de queries lentas:

- `Seq Scan`: Tabela lida sequencialmente sem índice (Adicionar índice).
- `Index Scan` / `Index Only Scan`: Acesso otimizado via índice.
- `Execution Time`: Tempo real de execução do motor do banco.

---

# 21. Paginação Obrigatória de APIs

Nunca retorne `Model.objects.all()` sem paginação em endpoints de listagem:

```python
REST_FRAMEWORK = {
    "DEFAULT_PAGINATION_CLASS": (
        "rest_framework.pagination.PageNumberPagination"
    ),
    "PAGE_SIZE": 25,
}
```

Use `CursorPagination` para listas de alto volume ou feeds em tempo real.

---

# 22. Cache Estratégico com Redis

Utilize cache apenas para dados caros de calcular e de baixa mutabilidade:

```python
from django.core.cache import cache

data = cache.get("active_cities")
if data is None:
  data = list(City.objects.filter(is_active=True).values("id", "name"))
  cache.set("active_cities", data, timeout=600)
```

> **Aviso**: O Redis NÃO substitui o PostgreSQL. Corrija N+1 e índices antes de aplicar cache.

---

# 23. Processamento Assíncrono (Celery)

Mova tarefas pesadas para o background fora do ciclo de request/response HTTP:
- Envio de e-mails / SMS / Push
- Geração de PDFs e relatórios
- Chamadas a APIs externas (Pagar.me, Webhooks, Firebase)
- Processamento de imagens e vídeos

```python
# Disparar assincronamente via Celery
send_order_email_task.delay(order.id)
```

---

# 24. Transações Curtas (`transaction.atomic`)

Mantenha blocos `transaction.atomic()` o mais curtos possível. NUNCA faça chamadas de API externas ou processamentos lentos dentro de uma transação de banco.

```python
# CORRETO
with transaction.atomic():
  order = Order.objects.create(...)

# Chamada externa FORA da transação
send_webhook(order.id)
```

---

# 25. Checklist de Auditoria Automática para Agentes de IA

Ao refatorar qualquer ViewSet, View ou Endpoint, valide:

- [ ] Existe N+1 no `get_queryset()`?
- [ ] Foram adicionados `select_related()` e `prefetch_related()`?
- [ ] Há uso de `Prefetch()` para filtrar relacionamentos?
- [ ] O `SerializerMethodField` executa queries individuais? (Substituir por `annotate()`).
- [ ] Foi usada `Subquery` ou `OuterRef` para sub-consultas correlacionadas?
- [ ] Os campos não utilizados foram omitidos via `only()` ou `values()`?
- [ ] Foi usado `exists()` em vez de `count() > 0` para testes de existência?
- [ ] O endpoint possui paginação ativada (`list_per_page = 25`)?
- [ ] O `show_full_result_count` foi desativado no Admin para tabelas grandes?
- [ ] Há chamadas HTTP externas dentro do ciclo do request? (Mover para Celery).
- [ ] O código Python está limpo, **sem docstrings** e **sem anotações de tipagem**?
