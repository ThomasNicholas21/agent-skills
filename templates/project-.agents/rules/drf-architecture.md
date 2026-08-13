# Regras de Arquitetura Django REST Framework (DRF)

trigger: glob "**/*.py"

Ao criar ou editar qualquer endpoint, ViewSet, Serializer, Model ou Service em projetos Django REST Framework, você DEVE seguir estritamente as regras abaixo:

---

## 1. Separação Estrita de Camadas (ViewSet vs Serializer vs Service Layer)

- **ViewSets**:
  - Responsáveis **apenas** pela camada HTTP (status code, permissões `permission_classes`, rate limiting, throttling e roteamento).
  - **NUNCA** execute lógica de negócio pesada, regras de cálculo ou chamadas de APIs externas dentro de métodos `create()`, `update()`, `destroy()` ou `perform_create()` do ViewSet.
  - Delegue toda a execução de domínio para métodos estáticos ou de classe no arquivo `services.py` do aplicativo correspondente.
  - Sobrescreva obrigatoriamente o método `get_serializer_class()` para retornar serializadores distintos de Leitura e Escrita.

- **Serializers**:
  - Responsáveis **apenas** pela validação sintática das requisições, coerção de tipos de dados e estruturação dos esquemas JSON de saída.
  - **NUNCA** execute transações complexas ou chamadas externas no método `validate()` ou `create()` de um Serializer.

- **Camada de Serviço (`services.py`)**:
  - Encapsula toda a lógica de negócio, transações de banco de dados (`@transaction.atomic`), integração com serviços externos e orquestração de múltiplos models.

---

## 2. Serializadores Distintos para Leitura e Escrita

- É **PROIBIDO** utilizar o mesmo `ModelSerializer` para operações de leitura (`GET`) e escrita (`POST`/`PUT`/`PATCH`).
- Padrão recomendado:
  - `OrderReadSerializer`: Contém relacionamentos aninhados (*nested serializers*) detalhados para exibição.
  - `OrderWriteSerializer`: Aceita apenas chaves primárias (`PrimaryKeyRelatedField`) ou IDs planos para persistência.

```python
def get_serializer_class(self):
    if self.action in ['create', 'update', 'partial_update']:
        return OrderWriteSerializer
    elif self.action == 'retrieve':
        return OrderDetailSerializer
    return OrderListSerializer
```

---

## 3. Prevenção de Consultas N+1

- Todo método `get_queryset()` de um `ViewSet` DEVE incluir `select_related()` para ForeignKeys / OneToOne e `prefetch_related()` for ManyToMany / Reverse ForeignKeys que forem serializados na resposta.

```python
def get_queryset(self):
    return (
        Order.objects
        .select_related('customer', 'payment_info')
        .prefetch_related('items__product')
        .filter(customer__user=self.request.user)
    )
```

---

## 4. Anotações OpenAPI e Documentação

- Todos os ViewSets e ações customizadas (`@action`) devem incluir a skill/diretiva do `drf-spectacular` para anotações `@extend_schema` garantindo OpenAPI 3.0 preciso.
