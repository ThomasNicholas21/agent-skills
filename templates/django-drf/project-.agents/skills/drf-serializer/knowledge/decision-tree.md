# Knowledge: Árvore de Decisão para Seleção de Serializers e Regras Estritas

---

## 1. Árvore de Decisão de Serializers

```text
AO CRIAR OU REFATORAR UM SERIALIZER:

1. A estrutura da API representa diretamente um modelo Django?
   ├── SIM ──> Usar ModelSerializer.
   └── NÃO ──> Usar Serializer (Plain).

2. Como os relacionamentos devem ser representados na saída?
   ├── Apenas ID ─────────────────> PrimaryKeyRelatedField.
   ├── Username ou código legível ──> SlugRelatedField.
   ├── URL do recurso ─────────────> HyperlinkedRelatedField.
   └── Dados complexos expandidos ─> Nested Serializer.

3. O Nested Serializer aceitará escrita (POST/PUT/PATCH)?
   ├── NÃO ──> Declarar com read_only=True.
   └── SIM ──> Implementar create() e update() manuais usando transaction.atomic().

4. Um campo precisa ser calculado exclusivamente na saída?
   └── SIM ──> Usar SerializerMethodField com método get_<field_name>(self, obj).
```

---

## 2. Regras Estritas de Proibição

1. **NUNCA** utilize bibliotecas terceiras como `drf-writable-nested`. Escreva gravações aninhadas manualmente.
2. **NUNCA** utilize `JSONField` para esconder esquemas que deveriam ser declarados com Serializers explícitos.
3. **NUNCA** utilize `FloatField` para valores monetários. Use `DecimalField(max_digits=10, decimal_places=2)`.
4. **NUNCA** acesse `.validated_data` antes de chamar `.is_valid()`.
5. **NUNCA** execute consultas ORM dentro de `SerializerMethodField` ou `to_representation()`.
