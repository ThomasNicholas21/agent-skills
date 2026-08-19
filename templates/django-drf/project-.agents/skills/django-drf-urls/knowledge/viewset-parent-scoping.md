# Knowledge: Proteção de QuerySet e Criacao Contextual em ViewSets Aninhadas
Ao expor um recurso filho através de uma URL aninhada (ex: `/clients/{client_pk}/calculations/{pk}/`), a ViewSet do recurso filho DEVE aplicar o isolamento de escopo obrigatoriamente.

## 1. Proteção do `get_queryset()` pelo `parent_pk`
NUNCA confie apenas na busca pelo `pk` individual da instância. Caso a consulta não filtre pelo `parent_pk`, um usuário poderá acessar `/clients/1/calculations/999/` mesmo que a requisição `999` pertença ao cliente `2`.

```python
class CalculationViewSet(viewsets.ModelViewSet):
    serializer_class = CalculationSerializer

    def get_queryset(self):
        # Filtra estritamente os cálculos pertencentes ao cliente da URL
        return Calculation.objects.filter(client_id=self.kwargs["client_pk"])
```

### Vantagem no `retrieve()`, `update()` e `destroy()`
Ao filtrar o `get_queryset()`, o método `get_object()` do DRF buscará a instância executando a cláusula `WHERE id = pk AND client_id = client_pk`. Se o cálculo não pertencer àquele cliente, o DRF retornará automaticamente `404 Not Found`.

---

## 2. Criação Contextual no `perform_create()`
Quando um novo recurso filho é criado através de uma URL aninhada (POST `/clients/{client_pk}/calculations/`), a chave do pai DEVE ser injetada a partir da URL (`self.kwargs["client_pk"]`).

NUNCA confie em um identificador de pai enviado no corpo do payload (`request.data`). O contexto da URL DEVE ter precedência.

```python
def perform_create(self, serializer):
    # Injeta a chave estrangeira obtida da URL
    serializer.save(client_id=self.kwargs["client_pk"])
```