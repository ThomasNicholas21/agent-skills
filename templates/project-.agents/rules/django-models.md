---
trigger:
  glob: "**/{models.py,models/**/*.py}"
---

# Regras de Desenvolvimento: Django Models & QuerySet Managers

Ao criar ou editar qualquer modelo do Django (`models.py`) ou sua representação no Admin (`admin.py`), você DEVE seguir estritamente as regras de arquitetura, organização de managers, performance e layout abaixo:

---

## 1. Ordem Interna Obrigatória da Classe Model

Toda classe de modelo Django DEVE seguir esta ordem determinística:

1. **Campos / Atributos**: Todas as declarações de campos (`models.CharField`, `models.ForeignKey`, etc.).
2. **`class Meta`**: DEVE ser posicionada imediatamente após a declaração dos campos.
3. **Declaração do Manager**: `objects = CustomManager()` DEVE ser declarado imediatamente após `class Meta`.
4. **Métodos de Negócio / Helpers**: Métodos customizados de domínio ou properties.
5. **Método `__str__()`**: DEVE ser OBRIGATORIAMENTE o ÚLTIMO método da classe.

---

## 2. Organização de Managers & QuerySets (`models.Manager` + `models.QuerySet`)

Toda lógica de consulta complexa e filtros reutilizáveis DEVE ser organizada separando a classe `QuerySet` e a classe `Manager` com delegação explícita via `get_queryset()`:

- **QuerySet (`models.QuerySet`)**: Encapsula métodos de consulta encadeáveis, filtros (`filter`), anotações (`annotate`) e agregações (`aggregate`).
- **Manager (`models.Manager`)**: Sobrescreve `get_queryset()` retornando a instância do `QuerySet` customizado e expõe os métodos delegando para `self.get_queryset().metodo()`.
- **Model**: Declara a instância do Manager explicitamente no atributo `objects = CustomManager()`.

---

## 3. Definição de Campos & Nomenclatura Minimalista

- **Primary Keys**: Prefira `models.BigAutoField` ou `models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True)`.
- **Relacionamentos**:
  - `ForeignKey` e `ManyToManyField` DEVEM obrigatoriamente especificar `on_delete` e `related_name` no **plural e em minúsculas** (ex: `related_name='orders'`).
  - Evite sufixos redundantes no nome do campo (use `user` em vez de `user_id`).
- **Valores Monetários / Financeiros**: Use `models.DecimalField(max_digits=10, decimal_places=2)`. NUNCA use `FloatField`.
- **Tratamento de Nulos**:
  - Campos de Texto (`CharField`, `TextField`): Use `blank=True, default=''`. Evite `null=True` em campos de texto para prevenir representação dupla de ausência de dados no banco.
  - Relacionamentos, Datas e Números: Use `null=True, blank=True` quando opcional.

---

## 4. Mixins de Data e Reusabilidade

Herde de um modelo abstrato padrão para campos de auditoria em vez de redefinir `created_at` e `updated_at` em cada model:

```python
class TimeStampedModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True
```

---

## 5. Meta, Índices e Performance de Consulta

- **Indexação**: Adicione `db_index=True` em campos individuais frequentemente buscados ou filtrados (`filter`, `order_by`).
- **Evitar `ordering` padrão no `class Meta`**:
  - **CRÍTICO**: NÃO defina `ordering = [...]` dentro de `class Meta`. Essa configuração força uma cláusula `ORDER BY` em TODAS as queries executadas sobre o model (incluindo `count()`, `exists()` e agregações), causando degradação severa de performance no banco de dados. Ordene explicitamente nas queries do `QuerySet`/`Manager`.
- **Índices Compostos e Constraints**: Defina no `Meta`:

```python
class Meta:
    indexes = [
        models.Index(fields=["status", "created_at"]),
    ]
    constraints = [
        models.UniqueConstraint(fields=["user", "code"], name="unique_user_order_code")
    ]
```

---

## 6. Exemplo Completo de Implementação de Model

Abaixo está o layout padrão para um arquivo de modelo Django de produção:

```python
import uuid
from decimal import Decimal
from django.db import models
from django.db.models import Sum


# 1. Mixin Abstrato Base
class TimeStampedModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


# 2. Subclasse de QuerySet com lógica de consulta e agregações
class OrderQuerySet(models.QuerySet):
    def active(self) -> "OrderQuerySet":
        return self.filter(is_active=True)

    def completed(self) -> "OrderQuerySet":
        return self.filter(status="COMPLETED")

    def total_revenue(self) -> Decimal:
        return self.aggregate(total=Sum("total_amount"))["total"] or Decimal("0.00")


# 3. Subclasse de Manager sobrescrevendo get_queryset e delegando métodos
class OrderManager(models.Manager):
    def get_queryset(self) -> OrderQuerySet:
        return OrderQuerySet(self.model, using=self._db)

    def active(self) -> OrderQuerySet:
        return self.get_queryset().active()

    def completed(self) -> OrderQuerySet:
        return self.get_queryset().completed()

    def total_revenue(self) -> Decimal:
        return self.get_queryset().total_revenue()


# 4. Classe do Model (seguindo a ordem obrigatória)
class Order(TimeStampedModel):
    # --- 1. Campos / Atributos ---
    id = models.UUIDField(
        "ID",
        primary_key=True,
        default=uuid.uuid4,
        editable=False,
    )
    user = models.ForeignKey(
        "users.User",
        on_delete=models.CASCADE,
        related_name="orders",
    )
    code = models.CharField(
        "Code",
        max_length=50,
        unique=True,
    )
    status = models.CharField(
        "Status",
        max_length=20,
        db_index=True,
        default="PENDING",
    )
    total_amount = models.DecimalField(
        "Total Amount",
        max_digits=10,
        decimal_places=2,
        default=Decimal("0.00"),
    )
    is_active = models.BooleanField(
        "Is Active",
        default=True,
        db_index=True,
    )

    # --- 2. Declaração do Manager (imediatamente após os campo) ---
    objects = OrderManager()

    # --- 3. class Meta (imediatamente após os manager caso existir) ---
    class Meta:
        indexes = [
            models.Index(fields=["status", "created_at"]),
        ]
        constraints = [
            models.UniqueConstraint(
                fields=["user", "code"],
                name="unique_user_order_code",
            )
        ]

    # --- 4. Métodos de Negócio / Helpers ---
    def mark_as_completed(self) -> None:
        self.status = "COMPLETED"
        self.save(update_fields=["status", "updated_at"])

    # --- 5. __str__ (OBRIGATORIAMENTE o último método) ---
    def __str__(self) -> str:
        return f"Order #{self.code} ({self.status})"
```

---

## 7. Regras de ModelAdmin & Performance no Admin (`admin.py`)

Ao criar ou editar classes `admin.ModelAdmin` em `admin.py`, você DEVE seguir estritamente as regras de performance e layout abaixo:

### 1. Prevenção Obrigatória do Problema N+1 (`get_queryset`)
- **SEMPRE** sobrescreva `get_queryset(self, request)` para incluir `select_related()` (para ForeignKeys / OneToOne) e `prefetch_related()` (para ManyToMany / Reverse FKs) de todos os relacionamentos exibidos em `list_display`, `readonly_fields` ou métodos customizados do admin.
- Utilize também `list_select_related = ('user',)` como atalho declarativo complementar.

### 2. Paginação e Desempenho em Tabelas Grandes
- **Paginação de Resultados**: Defina `list_per_page = 25` (ou `50`) para evitar o carregamento de milhares de instâncias na memória.
- **Desativar Query Custosa de Contagem**: Defina `show_full_result_count = False` em tabelas volumosas para evitar a execução de `SELECT COUNT(*)` a cada navegação de página.

### 3. Otimização de Lookups e Formulários (`autocomplete_fields` / `raw_id_fields`)
- **NUNCA** permita a renderização de elementos `<select>` padrão para ForeignKeys em tabelas com milhares de registros.
- Use `autocomplete_fields = ['user']` (requer `search_fields` no ModelAdmin do model relacionado) ou `raw_id_fields = ['user']`.

### 4. Ordem Estrutural Obrigatória da Classe `ModelAdmin`
A classe `ModelAdmin` DEVE seguir esta ordem determinística:
1. **Configurações de Exibição / Busca**: `list_display`, `list_filter`, `search_fields`, `ordering`, `list_select_related`.
2. **Performance & Paginação**: `list_per_page`, `show_full_result_count`.
3. **Formulários & Lookups**: `autocomplete_fields` / `raw_id_fields`, `readonly_fields`, `fieldsets`.
4. **Sobrescrita de `get_queryset(self, request)`**.
5. **Métodos Customizados de Exibição (`@admin.display`) e Ações (`@admin.action`)**.

### Exemplo Completo de Implementação de ModelAdmin:

```python
from django.contrib import admin
from .models import Order


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    # --- 1. Configurações de Exibição / Busca ---
    list_display = (
        "code",
        "user_email",
        "status",
        "total_amount",
        "is_active",
        "created_at",
    )
    list_filter = (
        "status",
        "is_active",
        "created_at",
    )
    search_fields = (
        "code",
        "user__email",
        "user__username",
    )
    ordering = ("-created_at",)
    list_select_related = ("user",)

    # --- 2. Performance & Paginação ---
    list_per_page = 25
    show_full_result_count = False  # Evita COUNT(*) custoso em tabelas grandes

    # --- 3. Formulários & Lookups ---
    autocomplete_fields = ("user",)
    readonly_fields = (
        "id",
        "created_at",
        "updated_at",
    )

    # --- 4. Prevenção de N+1 via get_queryset ---
    def get_queryset(self, request):
        return (
            super()
            .get_queryset(request)
            .select_related("user")
            .prefetch_related("items")
        )

    # --- 5. Métodos Customizados de Exibição se necessário ---
    @admin.display(description="User Email", ordering="user__email")
    def user_email(self, obj: Order) -> str:
        return obj.user.email
```
