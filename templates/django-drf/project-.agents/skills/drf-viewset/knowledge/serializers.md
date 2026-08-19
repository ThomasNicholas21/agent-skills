# Knowledge: Troca Dinâmica de Serializer por Action
Listagens de tabelas volumosas não devem serializar grafos de objetos profundos.

## 1. Padrão `get_serializer_class`

```python
class OrderViewSet(viewsets.ModelViewSet):
    serializer_class = OrderDetailSerializer  # Default fallback

    def get_serializer_class(self):
        if self.action == "list":
            return OrderListSerializer
        if self.action in ["create", "update", "partial_update"]:
            return OrderWriteSerializer
        return super().get_serializer_class()
```

## 2. Vantagens
- **Listings Rápidos**: `OrderListSerializer` retorna apenas IDs e totais, sem carregar sub-itens ou descrições longas.
- **Validação Segura na Criação**: `OrderWriteSerializer` valida entradas sem expor campos somente de leitura.