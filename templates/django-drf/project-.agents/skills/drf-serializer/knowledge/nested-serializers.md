# Knowledge: Nested Serializers Manuais (Escrita Aninhada sem Libs Terceiras)

Um **Nested Serializer** é a utilização de um Serializer como tipo de campo dentro de outro Serializer.

```python
class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ["bio", "phone"]


class UserSerializer(serializers.ModelSerializer):
    profile = ProfileSerializer()
```

---

## 1. Dependência do Fluxo de Negócio

A estratégia de implementação de um Nested Serializer **depende inteiramente do fluxo de uso da API**:
- **Análise do Fluxo**: Antes de implementar, deve-se analisar a necessidade do endpoint (Criação vs. Atualização, Substituição Total vs. Atualização Delta, Relacionamento 1:1 vs. 1:N).
- **Fluxo de Criação (`POST`)**: O payload representa novos dados. Relacionamentos 1:N **não devem exigir nem considerar `id`**.
- **Fluxo de Atualização (`PUT`/`PATCH`)**: O payload pode listar alterações em registros existentes ou inclusão de novos itens. A passagem de `id` opcional nos itens aninhados permite ao backend identificar quais registros atualizar e quais criar.
- **Contextos Segregados**: Sempre avalie a necessidade de separar serializadores de leitura (`ReadSerializer`) e escrita (`WriteSerializer`).

---

## 2. Proibição Estrita de Bibliotecas Terceiras

É **estritamente proibido** utilizar bibliotecas terceiras de escrita aninhada (ex: `drf-writable-nested`). Toda a lógica de gravação aninhada deve ser implementada manualmente nos métodos `create()` e `update()` do `Serializer`.

---

## 3. Comportamento e Proteção de ID em Relacionamentos 1:N

Ao manipular coleções aninhadas (1:N):

### A. Na Criação (`create`)
- **Não enviar `id`**: O payload dos itens aninhados não precisa enviar o campo `id`. O banco de dados gera novas chaves primárias automaticamente.

### B. Na Atualização (`update`) com Mapeamento por ID
- O serializador do item aninhado expõe `id = serializers.UUIDField(required=False)` (ou `IntegerField`) para que seja capturado na `validated_data`.
- **Regra de Proteção de ID**:
  - Se um `id` for fornecido no item aninhado, o backend DEVE verificar se esse `id` existe **dentro da coleção pertencente ao objeto pai** (`existing_items = {item.id: item for item in instance.items.all()}`).
  - **Caso o `id` informado NÃO exista na coleção do pai** (ID inexistente, forjado ou de outro recurso/tenant):
    - O backend **NÃO altera** nenhum objeto associado àquele ID forjado.
    - O `id` enviado é **descartado** (não é considerado nem forçado no banco).
    - O registro é criado como um **novo objeto com um novo ID gerado pelo sistema**.
  - **Dessa forma, NUNCA é permitido alterar ou criar um objeto impondo um ID informado pelo cliente.**

---

## 4. Implementação Manual de Nested `create()`

```python
def create(self, validated_data):
    items_data = validated_data.pop("items")
    with transaction.atomic():
        order = Order.objects.create(**validated_data)
        # Na criação, ignora qualquer ID enviado no payload e gera novos objetos
        order_items = [
            OrderItem(order=order, **{k: v for k, v in item_data.items() if k != "id"})
            for item_data in items_data
        ]
        OrderItem.objects.bulk_create(order_items)
    return order
```

---

## 5. Implementação Manual de Nested `update()` com Proteção de ID (1:N)

```python
class OrderItemUpdateSerializer(serializers.ModelSerializer):
    id = serializers.UUIDField(required=False)

    class Meta:
        model = OrderItem
        fields = ["id", "product_name", "unit_price", "quantity"]


class OrderNestedUpdateSerializer(serializers.ModelSerializer):
    items = OrderItemUpdateSerializer(many=True)

    class Meta:
        model = Order
        fields = ["id", "code", "items"]

    def update(self, instance, validated_data):
        items_data = validated_data.pop("items", None)

        with transaction.atomic():
            # 1. Atualizar campos da instância pai
            for attr, value in validated_data.items():
                setattr(instance, attr, value)

            instance.save()

            if items_data is not None:
                # Mapear apenas os itens existentes pertencentes a ESTE pai
                existing_items = {item.id: item for item in instance.items.all()}
                kept_item_ids = set()
                items_to_create = []

                for item_data in items_data:
                    item_id = item_data.pop("id", None)

                    # Se o ID foi informado E realmente pertence a este pai: atualize
                    if item_id and item_id in existing_items:
                        item_obj = existing_items[item_id]
                        for attr, value in item_data.items():
                            setattr(item_obj, attr, value)

                        item_obj.save()
                        kept_item_ids.add(item_id)

                    else:
                        # Se o ID não pertence ao pai ou não foi enviado, descarta o ID e cria novo item
                        items_to_create.append(OrderItem(order=instance, **item_data))

                # Remover itens da coleção antiga que foram omitidos no payload (sincronização)
                instance.items.exclude(id__in=kept_item_ids).delete()

                # Criar novos itens com IDs automáticos gerados pelo banco
                if items_to_create:
                    OrderItem.objects.bulk_create(items_to_create)

        return instance
```
