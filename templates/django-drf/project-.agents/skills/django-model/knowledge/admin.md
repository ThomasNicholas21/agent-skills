# Knowledge: Otimização de ModelAdmin no Django Admin
## 1. Prevenção Obrigatória do Problema N+1 (`get_queryset`)
- **SEMPRE** sobrescreva `get_queryset(self, request)` na classe `ModelAdmin` para incluir `select_related()` (para ForeignKeys / OneToOne) e `prefetch_related()` (para ManyToMany / Reverse FKs) de todos os relacionamentos exibidos em `list_display`.

## 2. Paginação e Desempenho em Tabelas Grandes
- **Paginação de Resultados**: Defina `list_per_page = 25` (ou `50`) para evitar o carregamento de milhares de instâncias na memória.
- **Desativar Query Custosa de Contagem**: Defina `show_full_result_count = False` em tabelas volumosas para evitar a execução de `SELECT COUNT(*)` a cada navegação de página.

## 3. Form Lookups Otimizados (`autocomplete_fields` / `raw_id_fields`)
- NUNCA permita a renderização de elementos `<select>` padrão para ForeignKeys em tabelas com milhares de registros.
- Use `autocomplete_fields = ['user']` (requer `search_fields` no ModelAdmin do model relacionado) ou `raw_id_fields = ['user']`.