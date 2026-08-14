# Knowledge: Otimização de Performance e Prevenção de N+1 em Serializers

---

## 1. Nested Serializers Não Otimizam Consultas ao Banco

O uso de Serializers Aninhados (`Nested Serializers`) ou campos de relacionamento (`PrimaryKeyRelatedField`, `SlugRelatedField`) **NÃO realiza automaticamente** otimizações de consulta no banco de dados.

Cada relação acessada por um Serializer sem pré-carregamento dispara uma query adicional ao banco para cada objeto da lista (Problema N+1).

---

## 2. Onde Resolver a Performance

A otimização de consultas N+1 DEVE ser resolvida na camada de acesso ao banco (**`ViewSet.get_queryset()`** ou no Custom Manager do Model), e não dentro do Serializer.

- **Para relacionamentos 1:1 e N:1 (`ForeignKey`)**: Adicione `.select_related("relacao")` no `get_queryset()`.
- **Para relacionamentos 1:N reversos e N:N (`ManyToManyField`)**: Adicione `.prefetch_related("relacoes")` no `get_queryset()`.

---

## 3. Risco de Travessia Profunda no Atributo `source`

Utilizar navegações profundas no parâmetro `source` (ex: `source="profile.user.company.address"`) provoca consultas adicionais em cascata caso os relacionamentos não estejam pré-carregados.

> **Regra para Agente**: Sempre que declarar `SerializerMethodField`, `source` com navegação por ponto (`.`) ou `Nested Serializer`, revise o `get_queryset()` da View correspondente.
