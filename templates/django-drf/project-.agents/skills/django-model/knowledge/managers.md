# Knowledge: Django Custom Managers & QuerySets
Toda lógica de consulta complexa e filtros reutilizáveis DEVE ser organizada separando a classe `QuerySet` e a classe `Manager` com delegação explícita via `get_queryset()`:

## 1. Arquitetura em Duas Camadas

1. **`QuerySet` (`models.QuerySet`)**: Encapsula métodos de consulta encadeáveis (`filter`, `exclude`, `annotate`, `aggregate`).
2. **`Manager` (`models.Manager`)**: Sobrescreve `get_queryset()` retornando a instância do `QuerySet` customizado e expõe os métodos de atalho delegando para `self.get_queryset().metodo()`.

## 2. Benefícios do Padrão
- **Encadeamento Fluente**: Permite fazer `Order.objects.active().completed().total_revenue()`.
- **Reuso na Camada de Negócio**: Permite usar os mesmos filtros em serviços, views e Admin.
- **Tipagem Estática**: Facilita a autocompletar e verificação de tipo com MyPy ou Pyright.

## 3. Estrutura Canônica
```python
class OrderQuerySet(models.QuerySet):
    def active(self) -> "OrderQuerySet":
        return self.filter(is_active=True)

    def completed(self) -> "OrderQuerySet":
        return self.filter(status="COMPLETED")


class OrderManager(models.Manager):
    def get_queryset(self) -> OrderQuerySet:
        return OrderQuerySet(self.model, using=self._db)

    def active(self) -> OrderQuerySet:
        return self.get_queryset().active()

    def completed(self) -> OrderQuerySet:
        return self.get_queryset().completed()
```