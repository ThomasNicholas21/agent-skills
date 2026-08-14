# Knowledge: Operações Customizadas com @action em ViewSets

Quando um recurso possui uma operação que pertence semanticamente ao seu contexto mas não é uma operação CRUD padrão (ex: `set_password`, `deactivate`, `recent_items`), utiliza-se o decorador `@action`.

---

## 1. `@action(detail=True)` vs `@action(detail=False)`

### A. `@action(detail=True)` (Ação em Nível de Objeto)
- Opera sobre um recurso específico identificado na URL pelo parâmetro `pk` ou `lookup_field`.
- Rota gerada pelo Router: `/resources/{pk}/set_password/`
- Pode chamar `self.get_object()` internamente para carregar o objeto e aplicar permissões de objeto.

### B. `@action(detail=False)` (Ação em Nível de Coleção)
- Opera sobre a coleção inteira de recursos.
- Rota gerada pelo Router: `/resources/recent_items/`
- Não requer parâmetro `pk` na URL.

---

## 2. Parâmetro `methods` em `@action`
Por padrão, `@action` aceita apenas o verbo HTTP `GET`. Para permitir outros verbos, especifique a lista no argumento `methods`:

```python
@action(detail=True, methods=["post"])
def set_password(self, request, pk=None):
    user = self.get_object()
    ...
```

---

## 3. Sobrescrita de Configurações por `@action`

Uma `@action` pode sobrescrever atributos de classe da ViewSet exclusivamente para a sua execução:

```python
@action(
    detail=True,
    methods=["post"],
    permission_classes=[IsAdminOrSelf],
    serializer_class=SetPasswordSerializer
)
def set_password(self, request, pk=None):
    ...
```

> **Regra para Agente**: NUNCA crie um ViewSet separado apenas porque uma operação específica possui uma regra de permissão ou serializador diferente. Utilize `@action` sobrescrevendo os parâmetros locais.
