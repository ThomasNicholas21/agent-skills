# Knowledge: Escrita Aninhada Transacional e Proteção de ID

Ao manipular relacionamentos 1:N ou N:N nos métodos `create()` ou `update()`:

## 1. Fluxo e Proteção de ID
- **Criação (`POST`)**: Não aceita imposição de `id` para itens aninhados. O banco gera IDs automaticamente.
- **Atualização (`PUT`/`PATCH`)**: O `id` opcional mapeia itens pertencentes à instância pai.
- **IDs Forjados**: Se o `id` não pertencer ao pai, descarte-o e crie como novo registro. Proibido alterar registros de outros pais/tenants.
- **Transacionalidade**: Toda gravação aninhada DEVE estar envolta em `with transaction.atomic():` ou `@transaction.atomic`.

Consulte o exemplo canônico em [`knowledge/nested-serializers.md`](./nested-serializers.md).
