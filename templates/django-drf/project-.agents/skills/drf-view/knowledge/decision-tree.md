# Knowledge: Árvore de Decisão para Seleção de Abstração de View no DRF

---

## 1. Princípio da Composição de Abstração

> **Regra de Ouro para Agentes**: Comece pela abstração **mais alta** que resolve o problema. Só desça para uma abstração mais baixa quando a anterior não oferecer controle suficiente.

```text
APIView
  └── GenericAPIView
        ├── Mixins (List, Create, Retrieve, Update, Destroy)
        └── Concrete Generic Views (ListCreateAPIView, RetrieveUpdateDestroyAPIView, etc.)
```

---

## 2. Fluxo de Seleção Passo a Passo

```text
AO CRIAR UMA VIEW DRF:

1. O endpoint possui comportamento HTTP/API altamente customizado ou de ação única (RPC)?
   └── SIM ──> Usar APIView.

2. O endpoint segue comportamento CRUD/model-oriented?
   └── SIM ──> Usar GenericAPIView / Concrete Generic View / ViewSet.

3. Existe uma Concrete Generic View que resolve exatamente o caso?
   └── SIM ──> Usar a Concrete Generic View (ex: ListCreateAPIView).

4. A Concrete View quase resolve, mas precisa de comportamento adicional?
   └── SIM ──> Herdar da Concrete View e sobrescrever SOMENTE os métodos/hooks necessários:
               - Escopo / ORM ──────────> get_queryset()
               - Busca de Objeto ───────> get_object()
               - Seleção de Serializer ─> get_serializer_class()
               - Filtragem ─────────────> filter_queryset()
               - Hook de Criação ───────> perform_create(serializer)
               - Hook de Atualização ────> perform_update(serializer)
               - Hook de Exclusão ──────> perform_destroy(instance)

5. O comportamento precisa ser reutilizado em múltiplos endpoints?
   └── SIM ──> Criar um Mixin customizado ou classe base.

6. PROIBIÇÃO: NUNCA reimplemente manualmente comportamento que o DRF já fornece out-of-the-box via GenericAPIView ou Mixins.
```
