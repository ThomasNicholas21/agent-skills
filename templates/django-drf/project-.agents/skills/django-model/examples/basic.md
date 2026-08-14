# Example: Django Model Básico com TimeStampedModel

```python
import uuid
from django.db import models


class TimeStampedModel(models.Model):
    """Modelo abstrato para adicionar campos de auditoria de data."""
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class Category(TimeStampedModel):
    id = models.UUIDField(
        primary_key=True,
        default=uuid.uuid4,
        editable=False,
    )
    name = models.CharField("Name", max_length=100, unique=True)
    description = models.TextField("Description", blank=True, default="")
    is_active = models.BooleanField("Is Active", default=True, db_index=True)

    class Meta:
        verbose_name = "Category"
        verbose_name_plural = "Categories"

    def __str__(self) -> str:
        return self.name
```
