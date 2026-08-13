---
trigger:
  glob: "**/{views.py,views/**/*.py}"
---

# Regras de Desenvolvimento: DRF Views, GenericAPIView & Mixins

Ao criar ou editar qualquer View no Django REST Framework (`views.py`), agentes e LLMs DEVEM entender a hierarquia de abstrações do DRF e escolher a classe base mais apropriada para a rota.

---

## 1. Hierarquia de Abstração do DRF

Entenda a relação de herança entre as classes de View do DRF:

```text
APIView (Controle HTTP bruto)
  └── GenericAPIView (Infraestrutura de ORM, Serializers, Filtros e Paginação)
        ├── + ListModelMixin / CreateModelMixin / RetrieveModelMixin ...
        └── Generic Views Concretas (generics.ListCreateAPIView, etc.)
```

---

## 2. Matriz de Decisão: Qual Classe Base Escolher?

| Cenário de Uso | Classe Recomendada | Exemplos de Endpoints |
| :--- | :--- | :--- |
| **Ação de Negócio Customizada Não-CRUD** | `APIView` | `POST /payments/{id}/refund/`, `POST /auth/login/`, `POST /notifications/send/` |
| **CRUD de Recurso Único ou Coleção** | `generics.ListCreateAPIView`, `generics.RetrieveUpdateDestroyAPIView` | `GET/POST /products/`, `GET/PUT/DELETE /products/{id}/` |
| **CRUD Parcial ou Combinação Específica** | `GenericAPIView` + `mixins.*` | `GET/POST` apenas sem suporte a exclusão ou alteração. |
| **Múltiplos Endpoints Roteados do Mesmo Recurso** | `viewsets.GenericViewSet` + `mixins.*` | Conjunto completo de rotas baseadas em roteadores (`DefaultRouter`). |

---

## 3. Quando Usar `APIView` (Controle HTTP Bruto)

Use `APIView` quando o endpoint representa um processo de negócio único que não é um CRUD tradicional de modelo:

```python
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from apps.payments.services import PaymentService


class RefundPaymentView(APIView):
    def post(self, request, pk):
        payment = PaymentService.refund_payment(
            payment_id=pk, user=request.user, reason=request.data.get("reason")
        )
        return Response(
            {"status": "refunded", "payment_id": payment.id},
            status=status.HTTP_200_OK,
        )
```

---

## 4. `GenericAPIView`: Otimização e Infraestrutura de Dados

`GenericAPIView` herda de `APIView` e adiciona integração nativa com QuerySets, Serializers, Filtros e Paginação.

### Atributos e Métodos Chave:

- **`get_queryset(self)`**: DEVE ser preferido em vez de definir o atributo `queryset` estático. Centraliza otimizações de banco (`select_related`, `prefetch_related`) e restrições por usuário ou método HTTP:

```python
def get_queryset(self):
    queryset = Order.objects.filter(user=self.request.user)
    if self.request.method == "GET":
        return queryset.select_related("user").prefetch_related("items__product")
    return queryset
```

- **`get_serializer_class(self)`**: Permite alternar dinamicamente o serializador conforme o verbo HTTP:

```python
def get_serializer_class(self):
    if self.request.method == "POST":
        return OrderWriteSerializer
    return OrderReadSerializer
```

- **`get_serializer(self, *args, **kwargs)`**: Instancia o serializador injetando o contexto padrão `get_serializer_context()` (contendo `request`, `view` e `format`).
- **`get_object(self)`**: Busca o objeto individual baseado na URL respeitando `lookup_field` (ex: `lookup_field = "uuid"`) e aplica permissões de objeto.
- **`filter_queryset(self, queryset)`**: Aplica os backends de busca e filtro configurados na view (`DjangoFilterBackend`, `SearchFilter`).

---

## 5. Generic Views Concretas (`generics.*`)

Em endpoints CRUD de rotas isoladas, utilize as Generic Views prontas do DRF:

- `generics.CreateAPIView` (`POST`)
- `generics.ListAPIView` (`GET` lista)
- `generics.RetrieveAPIView` (`GET` detalhe)
- `generics.ListCreateAPIView` (`GET` + `POST`)
- `generics.RetrieveUpdateAPIView` (`GET` + `PUT` / `PATCH`)
- `generics.RetrieveUpdateDestroyAPIView` (`GET` + `PUT` / `PATCH` + `DELETE`)

```python
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from apps.orders.api.serializers import (
    OrderReadSerializer,
    OrderWriteSerializer,
)
from apps.orders.models import Order
from apps.orders.services import OrderService


class OrderListCreateView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user).select_related("user")

    def get_serializer_class(self):
        if self.request.method == "POST":
            return OrderWriteSerializer

        return OrderReadSerializer

    def perform_create(self, serializer):
        OrderService.create_order(
            user=self.request.user, validated_data=serializer.validated_data
        )
```

---

## 6. Hooks de Persistência vs Orquestração HTTP

- **`perform_create(self, serializer)` / `perform_update(self, serializer)`**: Use quando precisar apenas alterar **como** o objeto é salvo ou injetar o usuário logado, delegando a regra de negócio para a **Service Layer (`services.py`)**.
- **`create(self, request, *args, **kwargs)` / `update(...)`**: Sobrescreva apenas quando for necessário alterar o **fluxo HTTP completo** (headers customizados, formato do payload de resposta ou status code).

---

## 7. Ordem Estrutural Obrigatória em `GenericAPIView` / `generics.*`

1. **Configurações de Classe**: `permission_classes`, `authentication_classes`, `throttle_classes`, `pagination_class`, `filterset_class`, `search_fields`, `lookup_field`.
2. **Métodos de Configuração Dinâmica**: `get_queryset()`, `get_serializer_class()`, `get_serializer_context()`.
3. **Hooks de Persistência**: `perform_create()`, `perform_update()`, `perform_destroy()`.
4. **Sobrescrita de Métodos HTTP** (se necessário): `get()`, `post()`, `put()`, `patch()`, `delete()`.
