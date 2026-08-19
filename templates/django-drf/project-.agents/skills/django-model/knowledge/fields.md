# Knowledge: Convenções de Campos e Performance de Banco em Django Models
## 1. Identificadores Principais (Primary Keys)
- Prefira `models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True)` para APIs expostas publicamente.
- Para tabelas internas de altíssimo volume, utilize `models.BigAutoField`.

## 2. Tratamento de Nulos (`null` vs `blank`)
- **Campos de Texto (`CharField`, `TextField`)**:
  - Use `blank=True, default=''`.
  - EVITE `null=True` em campos de texto para prevenir representação dupla de ausência de dados no banco (`NULL` vs `""`).
- **Campos Numéricos, Datas e Relacionamentos**:
  - Use `null=True, blank=True` quando o campo for opcional.

## 3. Valores Monetários e Decimais
- NUNCA utilize `FloatField` para valores financeiros ou monetários devido a erros de precisão binária de ponto flutuante.
- Use `models.DecimalField(max_digits=10, decimal_places=2)`.

## 4. Índices Compostos e Constraints no `class Meta`
- Defina índices compostos no `Meta.indexes` para colunas que aparecem frequentemente juntas em cláusulas `WHERE` ou `JOIN`.
- Defina regras de unicidade no `Meta.constraints` usando `models.UniqueConstraint`.

```python
class Meta:
    indexes = [
        models.Index(fields=["status", "created_at"]),
    ]
    constraints = [
        models.UniqueConstraint(fields=["user", "code"], name="unique_user_order_code")
    ]
```