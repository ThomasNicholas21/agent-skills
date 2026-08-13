---
name: drf-spectacular
description: >
  Habilidade especializada em documentação OpenAPI 3.0 e Swagger/ReDoc em Django REST Framework usando drf-spectacular.
  Ensina e gera anotações com @extend_schema, @extend_schema_field, esquemas customizados de requisição/resposta,
  parâmetros de query, enumerações, respostas de erro padronizadas e inclusão de exemplos sintáticos.
metadata:
  category: backend-drf
---

# Skill: DRF Spectacular (OpenAPI 3.0 & Swagger Documentation)

Esta habilidade orienta o agente na implementação de documentação OpenAPI 3.0 precisa e completa em endpoints Django REST Framework usando a biblioteca `drf-spectacular`.

---

## 1. Diretrizes de Uso do `@extend_schema`

Sempre que criar ou refatorar um endpoint ou método de ViewSet (`create`, `retrieve`, `update`, `destroy`, `list` ou `@action`), adicione a anotação `@extend_schema`.

```python
from drf_spectacular.utils import extend_schema, OpenApiParameter, OpenApiResponse, OpenApiExample
from drf_spectacular.types import OpenApiTypes
from .serializers import OrderDetailSerializer, OrderCreateSerializer, ErrorResponseSerializer

class OrderViewSet(viewsets.ModelViewSet):

    @extend_schema(
        summary="Cria um novo pedido de compra",
        description="Recebe os itens e o endereço de entrega, valida o estoque e inicia o processamento do pagamento.",
        request=OrderCreateSerializer,
        responses={
            201: OrderDetailSerializer,
            400: OpenApiResponse(response=ErrorResponseSerializer, description="Dados de requisição inválidos"),
            422: OpenApiResponse(description="Estoque insuficiente para um ou mais itens")
        },
        tags=["Pedidos"]
    )
    def create(self, request, *args, **kwargs):
        ...
```

---

## 2. Documentação de Parâmetros de Busca e Filtros

Para métodos de listagem ou busca com query parameters:

```python
@extend_schema(
    parameters=[
        OpenApiParameter(
            name="status",
            type=OpenApiTypes.STR,
            location=OpenApiParameter.QUERY,
            description="Filtra pedidos pelo status atual (ex: PENDING, PAID, CANCELLED)",
            required=False,
            enum=["PENDING", "PAID", "CANCELLED"]
        ),
        OpenApiParameter(
            name="start_date",
            type=OpenApiTypes.DATE,
            location=OpenApiParameter.QUERY,
            description="Data inicial para o período do pedido (YYYY-MM-DD)",
            required=False
        )
    ],
    responses={200: OrderDetailSerializer(many=True)}
)
def list(self, request, *args, **kwargs):
    ...
```

---

## 3. Campos Customizados com `@extend_schema_field`

Ao utilizar `SerializerMethodField` ou propriedades calculadas, informe expressamente o tipo OpenAPI retornado:

```python
from drf_spectacular.utils import extend_schema_field
from rest_framework import serializers

class OrderDetailSerializer(serializers.ModelSerializer):
    total_formatted = serializers.SerializerMethodField()

    @extend_schema_field(OpenApiTypes.STR)
    def get_total_formatted(self, obj) -> str:
        return f"R$ {obj.total_amount:.2f}"
```

---

## 4. Exemplos de Payload (`OpenApiExample`)

Adicione exemplos realistas de payload para facilitar os testes no Swagger UI:

```python
@extend_schema(
    examples=[
        OpenApiExample(
            name="Exemplo de Pedido Simples",
            value={
                "customer_id": 42,
                "items": [{"product_id": 10, "quantity": 2}],
                "payment_method": "CREDIT_CARD"
            },
            request_only=True
        )
    ]
)
```
