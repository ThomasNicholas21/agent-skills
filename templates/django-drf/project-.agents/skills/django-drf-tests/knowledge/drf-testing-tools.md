# Knowledge: Ferramentas de Teste do Django REST Framework
## 1. Ferramentas do DRF para Testes HTTP
O Django REST Framework fornece três ferramentas principais para simular requisições:
- `APIClient`: Cliente HTTP completo que simula requisições reais de um consumidor de API. Usar para testar endpoints e ViewSets.
- `APIRequestFactory`: Construtor de requisições direto para testar funções de View isoladamente sem passar pelo roteador.
- `force_authenticate(request_or_client, user=user)`: Autentica um usuário instantaneamente no cliente de teste sem precisar passar pelo fluxo completo de obtenção de token/senha.

## 2. Padrão de Teste de Endpoints com `APIClient`
```python
from rest_framework.test import APITestCase
from rest_framework import status
from django.urls import reverse
from apps.users.tests.factories import UserFactory


class OrderEndpointTestCase(APITestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user = UserFactory.create_user()
        cls.url = reverse("order-list")

    def test_create_order_authenticated_success(self):
        # 1. Autenticacao direta sem custo de hashing de senha
        self.client.force_authenticate(user=self.user)
        # 2. Requisicao HTTP
        response = self.client.post(self.url, data={"amount": "100.00"})
        # 3. Assercoes de status e contrato de resposta
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertIn("id", response.data)
```

## 3. Diretrizes para Testes de Endpoints
- **Usar `reverse()`**: NUNCA utilize URLs hardcoded em strings (ex: `"/api/v1/orders/"`). Use sempre `reverse("order-list")`.
- **Testar Status Codes Relevantes**: Teste `201` (Criação), `400` (Validação), `401` (Não Autenticado), `403` (Sem Permissão) e `404` (Não Encontrado).
- **Validar `response.data`**: Verifique as chaves e valores retornados no JSON da resposta, não apenas o código de status HTTP.