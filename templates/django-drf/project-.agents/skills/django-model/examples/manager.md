# Example: Django Model Completo com Custom Manager e QuerySet

```python
import uuid
from decimal import Decimal
from django.db import models
from django.db.models import Sum


class TimeStampedModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class OrderQuerySet(models.QuerySet):
    def active(self) -> "OrderQuerySet":
        return self.filter(is_active=True)

    def completed(self) -> "OrderQuerySet":
        return self.filter(status="COMPLETED")

    def total_revenue(self) -> Decimal:
        return self.aggregate(total=Sum("total_amount"))["total"] or Decimal("0.00")


class OrderManager(models.Manager):
    def get_queryset(self) -> OrderQuerySet:
        return OrderQuerySet(self.model, using=self._db)

    def active(self) -> OrderQuerySet:
        return self.get_queryset().active()

    def completed(self) -> OrderQuerySet:
        return self.get_queryset().completed()

    def total_revenue(self) -> Decimal:
        return self.get_queryset().total_revenue()


class Order(TimeStampedModel):
    # 1. Campos
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey("users.User", on_delete=models.CASCADE, related_name="orders")
    code = models.CharField("Code", max_length=50, unique=True)
    status = models.CharField("Status", max_length=20, db_index=True, default="PENDING")
    total_amount = models.DecimalField("Total Amount", max_digits=10, decimal_places=2, default=Decimal("0.00"))
    is_active = models.BooleanField("Is Active", default=True, db_index=True)

    # 2. Manager
    objects = OrderManager()

    # 3. Meta (Sem ordering padrão!)
    class Meta:
        indexes = [
            models.Index(fields=["status", "created_at"]),
        ]
        constraints = [
            models.UniqueConstraint(fields=["user", "code"], name="unique_user_order_code")
        ]

    # 4. Métodos de Negócio
    def mark_as_completed(self) -> None:
        self.status = "COMPLETED"
        self.save(update_fields=["status", "updated_at"])

    # 5. __str__ (OBRIGATORIAMENTE o último método)
    def __str__(self) -> str:
        return f"Order #{self.code} ({self.status})"
```
