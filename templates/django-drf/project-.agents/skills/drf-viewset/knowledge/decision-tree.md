# Knowledge: Árvore de Decisão e Regras de Seleção de ViewSets
## 1. Árvore de Decisão para Seleção de ViewSet
```text
AO CRIAR OU REFATORAR UM VIEWSET:
1. O recurso necessita de CRUD convencional completo (list, create, retrieve, update, destroy)?
   └── SIM ──> Usar ModelViewSet.
2. O recurso é estritamente de leitura (list, retrieve)?
   └── SIM ──> Usar ReadOnlyModelViewSet.
3. O recurso necessita apenas de algumas operações CRUD (ex: apenas list e create)?
   └── SIM ──> Usar GenericViewSet + Mixins necessários (ex: mixins.ListModelMixin + mixins.CreateModelMixin + viewsets.GenericViewSet).
4. A operação não é um CRUD padrão, mas pertence ao contexto do recurso?
   └── SIM ──> Adicionar um método decorado com @action:
               - Operação em objeto único ──> @action(detail=True)
               - Operação em coleção ────────> @action(detail=False)
5. Operações diferentes necessitam de serializers diferentes?
   └── SIM ──> Sobrescrever get_serializer_class() avaliando self.action.
6. Operações diferentes necessitam de permissões diferentes?
   └── SIM ──> Sobrescrever get_permissions() avaliando self.action ou declarar em @action.
```

## 2. Regras Estritas de Proibição

1. **NUNCA** defina métodos HTTP `get()`, `post()`, `put()`, `patch()` ou `delete()` dentro de uma classe `ViewSet`.
2. **NUNCA** duplique CRUD manualmente re-implementando a lógica que o `ModelViewSet` ou os `Mixins` já fornecem.
3. **NUNCA** crie um `ViewSet` separado apenas porque uma ação específica possui permissão ou serializador diferente.
4. **NUNCA** insira lógica de negócio complexa nos métodos de ação (`list`, `create`, `retrieve`, `update`, `destroy` ou `@action`). Mantenha a ViewSet responsável apenas pela orquestração HTTP.