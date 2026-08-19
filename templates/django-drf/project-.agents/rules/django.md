---
trigger:
  glob:
    - "**/{models,views,admin,forms,validators}*.py"
    - "**/{models,views,admin,forms,validators}/**/*.py"
---

# Arquitetura Django

## Models
Ordem na classe:
1. Campos
2. Manager customizado
3. `Meta`
4. Métodos/propriedades de domínio
5. `__str__` por último

## QuerySet / Manager
- Coloque lógica reutilizável de busca/filtro em `QuerySet` customizado.
- Managers devem expor métodos do QuerySet via delegação em `get_queryset()`.
- Não defina `Meta.ordering`; ordene explicitamente nos QuerySets/managers quando necessário.

## Campos
- Prefira chaves primárias UUID para entidades expostas publicamente.
- Use `BigAutoField` para tabelas internas de alto volume.
- `ForeignKey` / `ManyToManyField` exigem `on_delete` explícito (quando aplicável) e `related_name` no plural e minúsculo.
- Evite sufixo `_id` redundante em campos de relacionamento Django.
- Use `DecimalField` para valores monetários; nunca use `FloatField`.
- Campos de texto devem usar `blank=True, default=""` em vez de `null=True`.
- Relacionamentos, datas e números opcionais devem usar `null=True, blank=True`.

## ModelAdmin
- Prefira `select_related()` para relações diretas e `prefetch_related()` para relações reversas/N:N.
- Evite queries N+1 no admin.
- Use `list_per_page = 25` e `show_full_result_count = False` para tabelas grandes.
- Use `autocomplete_fields` ou `raw_id_fields` para ForeignKeys com muitos registros.

## Skills
- `django-model` → Implementação de Models, QuerySets, Managers e ModelAdmin.
- `django-drf-tests` → Implementação de Testes.