---
trigger:
  glob: "**/{viewsets.py,viewsets/**/*.py}"
---

# Regras de Desenvolvimento: DRF GenericViewSet & Mixins

Ao criar ou editar qualquer ViewSet no Django REST Framework (`viewsets.py`), agentes e LLMs DEVEM tratar o ViewSet exclusivamente como uma **camada de orquestração HTTP**, utilizando o padrão **`GenericViewSet` + Mixins**.

---

## 1. Escolha Explícita de Mixins (Evitar `ModelViewSet` Cego)

Evite utilizar `viewsets.ModelViewSet` quando a API não precisa de todas as operações CRUD. Herde estritamente os mixins correspondentes aos verbos HTTP suportados:

| Mixin | Método Fornecido | Verbo HTTP |
| :--- | :--- | :--- |
| `mixins.ListModelMixin` | `list()` | `GET /recurso/` |
| `mixins.RetrieveModelMixin` | `retrieve()` | `GET /recurso/{id}/` |
| `mixins.CreateModelMixin` | `create()` | `POST /recurso/` |
| `mixins.UpdateModelMixin` | `update()` / `partial_update()` | `PUT` / `PATCH /recurso/{id}/` |
| `mixins.DestroyModelMixin` | `destroy()` | `DELETE /recurso/{id}/` |

```python
# CORRETO (Apenas leitura e criação expostos explicitamente)
from rest_framework import mixins, viewsets


class OrderViewSet(
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    viewsets.GenericViewSet,
):
    pass
```

---

## 2. Restrição de Métodos HTTP (`http_method_names`)

Use `http_method_names` para bloquear verbos HTTP que não fazem parte do contrato da API (ex: desativar `PUT` mantendo apenas `PATCH` para atualizações parciais):

```python
class UserViewSet(
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet,
):
    http_method_names = ["get", "patch"]
```

---

## 3. Estrutura de QuerySet (`queryset` + `get_queryset`)

### A. Declaração Obrigatória do Atributo de Classe `queryset`

- **OBRIGATÓRIO**: Toda classe `ViewSet` DEVE declarar explicitamente o atributo de classe `queryset = Model.objects.none()` (ou `Model.objects.all()`).
- **Motivo**: O DRF e geradores de documentação OpenAPI (`drf-spectacular`, Swagger) utilizam `queryset.model` para:
  1. Inferir automaticamente o `basename` no `router.register()` caso não seja passado explicitamente.
  2. Identificar o modelo de dados para geração de esquemas OpenAPI.
- **Regra**: O atributo de classe declara qual modelo o ViewSet gerencia (`queryset = Order.objects.none()`), enquanto o método `get_queryset(self)` aplica a filtragem dinâmica e as otimizações de runtime.

### B. Otimização Dinâmica no `get_queryset()`

O método `get_queryset()` DEVE centralizar o escopo do usuário autenticado e variará otimizações de ORM (`select_related`, `prefetch_related`) conforme a ação (`self.action`):

```python
class OrderViewSet(viewsets.GenericViewSet):
    queryset = Order.objects.none()  # Declaração do modelo gerenciado

    def get_queryset(self):
        queryset = Order.objects.filter(user=self.request.user)

        if self.action == "list":
            return queryset.select_related("user")

        if self.action == "retrieve":
            return queryset.select_related(
                "user",
                "payment",
            ).prefetch_related("items__product")

        return queryset
```

---

## 4. Rotas e URLs Aninhadas (Nested Resources)

Quando uma rota depende de um recurso pai (ex: `/api/orders/{order_pk}/items/`), agentes DEVEM seguir estritamente o padrão de extração, validação, filtragem e injeção do pai.

### A. Extração de `pk` Pai com Validação e Tratamento de Erros

- **Extrair via `self.kwargs`**: Obtenha a chave primária do pai a partir de `self.kwargs.get("order_pk")` (ou parâmetro configurado no router).
- **Validação e Erro HTTP 404 (NotFound)**: Se a chave pai estiver ausente, for de formato inválido (ex: UUID corrompido) ou o objeto pai não existir para o usuário autenticado, lance `rest_framework.exceptions.NotFound` (HTTP 404) ou `ValidationError` (HTTP 400).
- **Método Helper Centralizado (`_get_parent_order`)**: Crie um método privado para obter o pai com cache em instância (`self._parent_order`), evitando queries duplicadas durante o mesmo ciclo HTTP:

```python
from django.shortcuts import get_object_or_404
from rest_framework.exceptions import NotFound, ValidationError
from apps.orders.models import Order


def _get_parent_order(self) -> Order:
    if hasattr(self, "_parent_order"):
        return self._parent_order

    order_pk = self.kwargs.get("order_pk")
    if not order_pk:
        raise ValidationError({"order_pk": "O ID do pedido pai é obrigatório na URL."})

    try:
        # Garante o isolamento por usuário autenticado
        self._parent_order = get_object_or_404(
            Order.objects.filter(user=self.request.user),
            pk=order_pk,
        )
        return self._parent_order

    except (ValueError, TypeError):
        raise NotFound("Pedido pai não foi encontrado ou o formato do ID é inválido.")
```

### B. Filtragem do `get_queryset()` em Rotas Aninhadas

O `get_queryset()` DEVE filtrar os registros filhos pertencentes exclusivamente ao pai validado:

```python
def get_queryset(self):
    parent_order = self._get_parent_order()
    return OrderItem.objects.filter(order=parent_order).select_related("product")
```

### C. Injeção do Pai no `get_serializer_context()`

Para permitir que o Serializer execute validações com base nos dados do pai (ex: proibir adicionar itens a um pedido já concluído), injete o pai no contexto:

```python
def get_serializer_context(self):
    context = super().get_serializer_context()
    context["order"] = self._get_parent_order()
    return context
```

### D. Injeção do Pai no `perform_create()` ou `create()`

Ao criar o recurso filho, passe a instância pai para a Service Layer ou para o `serializer.save()`:

```python
# Opção 1: Delegação para a Service Layer (Recomendado)
def create(self, request, *args, **kwargs):
    parent_order = self._get_parent_order()
    serializer = self.get_serializer(data=request.data)
    serializer.is_valid(raise_exception=True)

    item = OrderItemService.create_item(
        order=parent_order,
        validated_data=serializer.validated_data,
    )

    output_serializer = OrderItemDetailSerializer(
        item, context=self.get_serializer_context()
    )
    return Response(output_serializer.data, status=status.HTTP_201_CREATED)


# Opção 2: Sobrescrita de perform_create
def perform_create(self, serializer):
    parent_order = self._get_parent_order()
    OrderItemService.create_item(
        order=parent_order,
        validated_data=serializer.validated_data,
    )
```

---

## 5. Seleção Dinâmica de Serializers (`get_serializer_class`)

Selecione serializadores distintos para cada ação, separando leitura e escrita:

```python
def get_serializer_class(self):
    if self.action == "list":
        return OrderListSerializer

    if self.action == "retrieve":
        return OrderDetailSerializer

    if self.action == "create":
        return OrderCreateSerializer

    if self.action in ["update", "partial_update"]:
        return OrderUpdateSerializer

    return self.serializer_class
```

---

## 6. Preservação de Métodos Auxiliares do DRF

Ao sobrescrever ou implementar ações manualmente, SEMPRE utilize os métodos nativos da infraestrutura do DRF:

- **Instanciar Serializer**: Use `serializer = self.get_serializer(data=request.data)` e `self.get_serializer_context()`.
- **Buscar Objeto por ID**: Use `instance = self.get_object()` (respeita `lookup_field`, `lookup_url_kwarg` e permissões).
- **Aplicar Filtros**: Use `queryset = self.filter_queryset(self.get_queryset())`.
- **Aplicar Paginação**: Use `page = self.paginate_queryset(queryset)` e `self.get_paginated_response(serializer.data)`.

---

## 7. Persistência e Delegação para Service Layer (`perform_create` vs `create`)

- **Somente alterar a gravação de dados**: Sobrescreva `perform_create(self, serializer)` ou `perform_update(self, serializer)` chamando a **Service Layer (`services.py`)**.
- **Alterar o fluxo HTTP completo (headers, status, resposta)**: Sobrescreva `create(self, request, *args, **kwargs)`.

```python
# Exemplo com perform_create chamando a Service Layer
def perform_create(self, serializer):
    OrderService.create_order(
        user=self.request.user,
        validated_data=serializer.validated_data,
    )
```

---

## 8. Ações Customizadas (`@action`)

Use o decorador `@action` para rotas fora do CRUD padrão:
- `detail=True`: Ação em um objeto específico (`POST /orders/{id}/cancel/`). Usa `self.get_object()`.
- `detail=False`: Ação na coleção inteira (`GET /orders/statistics/`). Usa `self.filter_queryset(self.get_queryset())`.

```python
from rest_framework.decorators import action
from rest_framework.response import Response


@action(detail=True, methods=["post"], url_path="cancel")
def cancel(self, request, pk=None):
    order = self.get_object()
    cancelled_order = OrderService.cancel_order(order)
    serializer = OrderDetailSerializer(
        cancelled_order, context=self.get_serializer_context()
    )
    return Response(serializer.data)
```

---

## 9. Ordem Estrutural Obrigatória da Classe `GenericViewSet`

1. **Atributos de Configuração**: `queryset`, `serializer_class`, `permission_classes`, `authentication_classes`, `throttle_classes`, `pagination_class`, `http_method_names`, `lookup_field`.
2. **Métodos Helper Privados**: `_get_parent_object()`.
3. **Métodos de QuerySet & Serializer**: `get_queryset()`, `get_serializer_class()`, `get_serializer_context()`, `get_permissions()`.
4. **Métodos de Controle HTTP / Manuais**: `list()`, `retrieve()`, `create()`, `update()`, `destroy()`.
5. **Métodos de Persistência**: `perform_create()`, `perform_update()`, `perform_destroy()`.
6. **Ações Customizadas (`@action`)**.

---

## 10. Exemplo Completo de ViewSet Aninhado (`OrderItemViewSet`)

Abaixo está o padrão recomendado de implementação para um ViewSet de rota aninhada (`/api/orders/{order_pk}/items/`):

```python
from django.shortcuts import get_object_or_404
from rest_framework import mixins, status, viewsets
from rest_framework.exceptions import NotFound, ValidationError
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from apps.orders.api.serializers import (
    OrderItemCreateSerializer,
    OrderItemDetailSerializer,
    OrderItemListSerializer,
)
from apps.orders.models import Order, OrderItem
from apps.orders.services import OrderItemService


class OrderItemViewSet(
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet,
):
    queryset = OrderItem.objects.none()
    permission_classes = [IsAuthenticated]
    http_method_names = ["get", "post", "delete"]
    serializer_class = OrderItemListSerializer

    # --- Métodos Helper Privados ---
    def _get_parent_order(self) -> Order:
        if hasattr(self, "_parent_order"):
            return self._parent_order

        order_pk = self.kwargs.get("order_pk")
        if not order_pk:
            raise ValidationError(
                {
                    "order_pk": "O ID do pedido pai é obrigatório na URL.",
                }
            )

        try:
            self._parent_order = get_object_or_404(
                Order.objects.filter(user=self.request.user),
                pk=order_pk,
            )
            return self._parent_order

        except (ValueError, TypeError):
            raise NotFound("Pedido pai não encontrado ou formato de ID inválido.")

    # --- Métodos de QuerySet & Serializer ---
    def get_queryset(self):
        parent_order = self._get_parent_order()
        return OrderItem.objects.filter(order=parent_order).select_related("product")

    def get_serializer_class(self):
        if self.action == "create":
            return OrderItemCreateSerializer

        if self.action == "retrieve":
            return OrderItemDetailSerializer

        return OrderItemListSerializer

    def get_serializer_context(self):
        context = super().get_serializer_context()
        context["order"] = self._get_parent_order()
        return context

    # --- Métodos de Controle HTTP ---
    def create(self, request, *args, **kwargs):
        parent_order = self._get_parent_order()
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        item = OrderItemService.create_item(
            order=parent_order,
            validated_data=serializer.validated_data,
        )

        output_serializer = OrderItemDetailSerializer(
            item, context=self.get_serializer_context()
        )
        return Response(output_serializer.data, status=status.HTTP_201_CREATED)
```
