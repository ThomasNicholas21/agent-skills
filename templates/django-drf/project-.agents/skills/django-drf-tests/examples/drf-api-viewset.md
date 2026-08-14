# Example: Teste de Endpoint DRF com APITestCase, force_authenticate e assertNumQueries

```python
from rest_framework.test import APITestCase
from rest_framework import status
from django.urls import reverse
from apps.orders.tests.mixins import OrderTestMixin


class OrderViewSetTestCase(OrderTestMixin, APITestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user = cls.create_user(email="buyer@example.com")
        cls.other_user = cls.create_user(email="other@example.com")
        cls.user_order = cls.create_order(user=cls.user)
        cls.url = reverse("order-list")

    def test_list_orders_authenticated_and_num_queries(self):
        # 1. Autenticacao direta sem custo de hashing
        self.client.force_authenticate(user=self.user)

        # 2. Verificacao de performance ORM (preve N+1)
        with self.assertNumQueries(2):
            response = self.client.get(self.url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data["results"]), 1)

    def test_list_orders_unauthenticated_forbidden(self):
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
```
