---
name: django-model
description: >-
  Especialista em construção e otimização de Django Models, Custom Managers, QuerySets encadeáveis
  e otimização de ModelAdmin no Django Admin. Use quando for criar ou refatorar modelos e a camada de persistência.
---

# Django Model Skill

Esta habilidade guia a construção de modelos Django de alta performance, encapsulando lógica de dados em `QuerySet` / `Manager` e garantindo otimizações no Django Admin.

---

## Quando Ativar Esta Skill

Ative esta skill quando a tarefa envolver:
- Criar novos modelos de dados no Django (`models.py`).
- Implementar consultas complexas encadeáveis através de `QuerySet` e `Manager` customizados.
- Configurar relacionamentos, índices compostos e constraints no `class Meta`.
- Otimizar o Django Admin (`admin.py`) contra problemas de N+1 e tabelas volumosas.

---

## Índice de Conhecimento Profundo (`knowledge/`)

Ao trabalhar em um aspecto específico, leia o arquivo correspondente em `knowledge/`:
1. [`knowledge/managers.md`](./knowledge/managers.md): Separação entre QuerySet e Manager com delegação via `get_queryset()`.
2. [`knowledge/fields.md`](./knowledge/fields.md): Convenções de campos (UUID, Decimals, Null vs Blank, Índices).
3. [`knowledge/admin.md`](./knowledge/admin.md): Otimização de ModelAdmin (N+1, autocomplete_fields, paginação).

---

## Exemplos de Código Práticos (`examples/`)

Consulte exemplos de referência prontos para uso:
- [`examples/basic.md`](./examples/basic.md): Modelo básico com auditoria `TimeStampedModel`.
- [`examples/manager.md`](./examples/manager.md): Modelo completo com Custom QuerySet + Manager encadeável.
- [`examples/admin.md`](./examples/admin.md): Classe ModelAdmin otimizada contra queries N+1 e `COUNT(*)` custosos.

---

## Checklist de Implementação de Model

1. **Herança Base**: O model herda de `TimeStampedModel` (com `created_at` e `updated_at`)?
2. **Ordem Interna**: Atributos → Manager (`objects`) → Meta → Métodos de Negócio → `__str__()` (último)?
3. **Manager Separado**: A lógica de consulta encadeável está em uma classe `QuerySet` e exposta via `Manager`?
4. **Sem Meta Ordering**: O `class Meta` está sem a opção `ordering = [...]` para prevenir degradação no banco?
5. **Relacionamentos**: `ForeignKey` especifica `on_delete` e `related_name` no plural e minúsculo?
