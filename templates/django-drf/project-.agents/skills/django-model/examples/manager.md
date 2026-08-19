# Example: Django Model com Custom QuerySet e Manager Encadeável

Demonstração do padrão de duas camadas (`QuerySet` + `Manager`):

```python
from decimal import Decimal
import uuid
from django.db import models


class OrderQuerySet(models.QuerySet):
    """Encapsula filtros e agregações encadeáveis."""

    def active(self):
        return self.filter(is_active=True)

    def completed(self):
        return self.filter(status="COMPLETED")

    def high_value(self, threshold: Decimal = Decimal("1000.00")):
        return self.filter(total_amount__gte=threshold)


class OrderManager(models.Manager):
    """Expõe os métodos do QuerySet e implementa criação customizada."""

    def get_queryset(self) -> OrderQuerySet:
        return OrderQuerySet(self.model, using=self._db)

    def active(self) -> OrderQuerySet:
        return self.get_queryset().active()

    def completed(self) -> OrderQuerySet:
        return self.get_queryset().completed()

    def high_value(self, threshold: Decimal = Decimal("1000.00")) -> OrderQuerySet:
        return self.get_queryset().high_value(threshold)


class Order(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    code = models.CharField(max_length=50, unique=True)
    status = models.CharField(max_length=20, default="PENDING")
    total_amount = models.DecimalField(max_digits=12, decimal_places=2)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    objects = OrderManager()

    class Meta:
        indexes = [
            models.Index(fields=["status", "created_at"]),
        ]

    def __str__(self) -> str:
        return f"Order #{self.code}"
```