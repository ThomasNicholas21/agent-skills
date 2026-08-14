# Knowledge: Performance de Testes, Prevenção de N+1 e Otimizações de Banco

---

## 1. Verificação de Performance de Banco (`assertNumQueries`)

Endpoints e serviços críticos DEVEM validar a quantidade exata de consultas ORM executadas para garantir que alterações futuras não introduzam problemas de consulta N+1 (`select_related` ou `prefetch_related` ausentes):

```python
def test_order_list_query_count(self):
    self.client.force_authenticate(user=self.user)
    # Valida que listar pedidos executa no maximo 3 queries (auth + order collection + prefetch items)
    with self.assertNumQueries(3):
        response = self.client.get(self.url)
    self.assertEqual(response.status_code, 200)
```

No `pytest-django`, utilize a fixture `django_assert_num_queries`:
```python
def test_order_list_queries(django_assert_num_queries, client, user):
    client.force_authenticate(user=user)
    with django_assert_num_queries(3):
        client.get("/api/orders/")
```

---

## 2. Reutilização de Banco de Dados de Testes

Durante o desenvolvimento local, evite a destruição e recriação lenta do banco de dados a cada teste:

- **Django Native**: `python manage.py test --keepdb`
- **Pytest**: `pytest --reuse-db` (ou `pytest --reuse-db --create-db` quando houver alterações em migrations)

---

## 3. Otimização de Password Hashing em Testes

O algoritmo padrão de hash de senhas (Argon2 / PBKDF2) é propositalmente lento para segurança. Em suítes de teste com muitos testes de autenticação, configure um hasher ultrarrápido (`MD5PasswordHasher`) nas configurações de ambiente de teste:

```python
# settings/test.py
PASSWORD_HASHERS = [
    "django.contrib.auth.hashers.MD5PasswordHasher",
]
```

---

## 4. Otimização de I/O de Arquivos (`InMemoryStorage`)

Para testes que realizam upload ou manipulação de arquivos de mídia, utilize `InMemoryStorage` para evitar escrita real em disco:

```python
# settings/test.py
STORAGES = {
    "default": {"BACKEND": "django.core.files.storage.InMemoryStorage"},
}
```
