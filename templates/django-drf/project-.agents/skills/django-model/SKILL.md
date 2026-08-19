---
name: django-model
description: >-
  Especialista em construção e otimização de Django Models, Custom Managers, QuerySets encadeáveis
  e otimização de ModelAdmin no Django Admin.
---

# Django Model Skill
Orienta a construção de modelos Django de alta performance, encapsulando lógica de dados em `QuerySet` / `Manager` e otimizando o Django Admin.

## Quando Ativar
- Criar ou refatorar modelos de dados no Django (`models.py`).
- Implementar consultas encadeáveis através de `QuerySet` e `Manager` customizados.
- Configurar relacionamentos, índices compostos e constraints no `Meta`.
- Otimizar o Django Admin (`admin.py`) contra N+1 e tabelas volumosas.

## Conhecimento (`knowledge/`)
1. [`knowledge/managers.md`](./knowledge/managers.md): Separação entre QuerySet e Manager com delegação via `get_queryset()`.
2. [`knowledge/fields.md`](./knowledge/fields.md): Convenções de campos (UUID, DecimalField, blank vs null).
3. [`knowledge/admin.md`](./knowledge/admin.md): Otimização de ModelAdmin (`select_related`, `autocomplete_fields`, paginação).

## Exemplos (`examples/`)
- [`examples/basic.md`](./examples/basic.md): Modelo básico com `TimeStampedModel`.
- [`examples/manager.md`](./examples/manager.md): Modelo com Custom QuerySet + Manager encadeável.
- [`examples/admin.md`](./examples/admin.md): ModelAdmin otimizado contra queries N+1 e contagens custosas.

## Checklist
1. **Ordem na Classe**: Campos → Manager (`objects`) → `Meta` → Métodos de Domínio → `__str__()` por último?
2. **Manager & QuerySet**: Lógica de consulta está em `QuerySet` e exposta pelo `Manager` via `get_queryset()`?
3. **Sem Meta Ordering**: O `Meta` não possui `ordering` estático (ordenação explícita no QuerySet)?
4. **Relacionamentos**: `ForeignKey` especifica `on_delete` e `related_name` no plural e minúsculo?
5. **Precisão Numérica**: Valores monetários utilizam `DecimalField` (nunca `FloatField`)?