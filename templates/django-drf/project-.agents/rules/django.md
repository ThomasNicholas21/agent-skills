---
trigger:
  glob:
    - "**/{models,views,admin,forms,validators}*.py"
    - "**/{models,views,admin,forms,validators}/**/*.py"
---

# Regras de Desenvolvimento: Django Architecture & Clean Standards

Ao criar ou modificar arquivos do Django (`models.py`, `admin.py`, `forms.py`, `validators.py`), siga estritamente estas diretrizes de arquitetura de dados e padrões de qualidade.

---

## 1. Ordem Interna Obrigatória da Classe Model

Toda classe de modelo Django DEVE seguir esta ordem determinística:

1. **Campos / Atributos**: Declaração dos campos do banco (`models.CharField`, `models.ForeignKey`, etc.).
2. **Instância do Manager**: `objects = CustomManager()` DEVE ser declarado imediatamente após os campos.
3. **`class Meta`**: Definição de índices compostos, constraints e `db_table`.
4. **Métodos de Negócio / Domain Operations / Helpers**: Regras de domínio intrínsecas ao modelo (Operation Script pattern) ou properties.
5. **Método `__str__()`**: **OBRIGATORIAMENTE** o último método da classe.

---

## 2. Arquitetura de Domínio & Managers (`QuerySet` + `Manager`)

Toda lógica de consulta complexa e filtros reutilizáveis DEVE ser organizada separando a classe `QuerySet` e a classe `Manager` com delegação explícita via `get_queryset()`:

- **QuerySet (`models.QuerySet`)**: Encapsula métodos de consulta encadeáveis, filtros (`filter`), anotações (`annotate`) e agregações (`aggregate`).
- **Manager (`models.Manager`)**: Sobrescreve `get_queryset()` retornando a instância do `QuerySet` customizado e expõe os métodos de atalho delegando para `self.get_queryset().metodo()`.
- **Regra de Ouro do Meta Ordering**:
  - **PROIBIDO** definir `ordering = [...]` em `class Meta`. Essa configuração força uma cláusula `ORDER BY` em TODAS as queries executadas sobre o model (incluindo `count()`, `exists()` e agregações), causando degradação de performance. Ordene explicitamente na consulta do Manager/QuerySet.

---

## 3. Convenções de Campos e Tipos de Dados

- **Primary Keys**: Prefira `models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True)` para entidades expostas publicamente em APIs ou `models.BigAutoField` para tabelas internas de alto volume.
- **Relacionamentos**:
  - `ForeignKey` e `ManyToManyField` DEVEM obrigatoriamente especificar `on_delete` e `related_name` no **plural e em minúsculas** (ex: `related_name='orders'`).
  - Evite sufixos redundantes (use `user` em vez de `user_id`).
- **Valores Monetários / Financeiros**: Use `models.DecimalField(max_digits=10, decimal_places=2)`. NUNCA use `FloatField`.
- **Tratamento de Nulos**:
  - Campos de Texto (`CharField`, `TextField`): Use `blank=True, default=''`. Evite `null=True` em campos de texto para prevenir representação dupla de ausência de dados no banco (`NULL` vs `""`).
  - Relacionamentos, Datas e Números: Use `null=True, blank=True` quando opcional.

---

## 4. Desempenho e Estrutura no Django ModelAdmin (`admin.py`)

Ao criar ou editar classes `admin.ModelAdmin` em `admin.py`, siga estritamente esta ordem estrutural:

1. **Exibição / Busca**: `list_display`, `list_filter`, `search_fields`, `ordering`, `list_select_related`.
2. **Performance & Paginação**: Defina `list_per_page = 25` e `show_full_result_count = False` (para evitar a execução de `SELECT COUNT(*)` a cada página em tabelas grandes).
3. **Formulários & Lookups**: `autocomplete_fields` ou `raw_id_fields` para ForeignKeys volumosas (evitando a renderização de elementos `<select>` pesados).
4. **Prevenção N+1**: Sobrescreva `get_queryset(self, request)` usando `select_related()` (para 1:1 e N:1) e `prefetch_related()` (para 1:N reversos e N:N) de todos os relacionamentos exibidos no admin.
5. **Métodos Customizados**: Exibição (`@admin.display`) e Ações (`@admin.action`).

---

## 5. Gatilhos de Invocação de Skill

> *Para implementar, expandir ou refatorar Django Models, Custom Managers ou ModelAdmin com suporte a conhecimentos avançados e exemplos completos de código, **invoque a skill `django-model`**.*
