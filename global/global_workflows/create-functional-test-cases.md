# Workflow: Criar Casos de Testes Funcionais com Dados Mockados

Este workflow guia o agente no planejamento, geração de dados mockados e escrita de casos de teste funcionais cobrindo cenários de sucesso, erro, exceções e dados de borda.

---

## Passo 1: Análise da Funcionalidade e Mapeamento de Cenários
- Inspecione a classe ou endpoint a ser testado usando RTK (`rtk read <file>`).
- Mapeie os quatro cenários obrigatórios:
  1. **Cenário de Sucesso (Happy Path)**: Requisição válida com retorno de status esperado (ex: 200 OK ou 201 Created).
  2. **Cenário de Validação Sintática (Bad Request)**: Campos obrigatórios ausentes ou formatos inválidos (ex: 400 Bad Request).
  3. **Cenário de Regra de Negócio (Unprocessable Entity)**: Violação de estado de domínio (ex: estoque insuficiente, CPF duplicado -> 400 ou 422).
  4. **Cenário de Autenticação / Permissão**: Token ausente ou usuário sem acesso (ex: 401 Unauthorized / 403 Forbidden).

---

## Passo 2: Geração de Dados Mockados de Exemplo
- Invoque a skill `generate-mock-data` para criar a estrutura dos payloads e entidades mockadas com valores realistas (Faker `pt_BR`).
- Exemplo de dados de entrada:
```python
# Payload de exemplo para teste funcional
valid_payload = {
    "customer_cpf": "123.456.789-00",
    "items": [{"product_id": 1, "quantity": 2}],
    "payment_method": "PIX"
}
```

---

## Passo 3: Implementação da Suíte de Testes
- Utilize `django.test.TestCase` ou `rest_framework.test.APITestCase` para garantir isolamento rápido por rollback.
- Estruture os métodos de teste com o padrão AAA (Arrange, Act, Assert):

```python
from rest_framework.test import APITestCase
from rest_framework import status
from unittest.mock import patch

class OrderFunctionalTestCase(APITestCase):

    def setUp(self):
        # Configurar dados de fixtures de teste
        ...

    def test_create_order_success_happy_path(self):
        # 1. Arrange (Preparar)
        payload = generate_mock_user_payload()
        
        # 2. Act (Executar)
        response = self.client.post("/api/v1/orders/", payload, format="json")
        
        # 3. Assert (Verificar)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertIn("id", response.data)

    def test_create_order_fails_when_product_out_of_stock(self):
        # Teste de cenário de erro de domínio
        ...
```

---

## Passo 4: Execução e Validação via RTK
- Execute o teste imediatamente via RTK para confirmar a passagem verde da suíte:
```bash
rtk pytest path/to/test_file.py
```
