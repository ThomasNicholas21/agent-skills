# Knowledge: Padrão Model Factory Mixins com **kwargs

---

## 1. Por que Evitar Chamadas Diretas a `Model.objects.create()` no Setup de Testes

Instanciar modelos diretamente com `Model.objects.create(param1=..., param2=...)` dentro do setup dos testes cria acoplamento excessivo. Caso o esquema do modelo mude (ex: inclusão de um novo campo obrigatório), dezenas de testes quebrarão simultaneamente.

---

## 2. O Padrão Model Factory Mixin

Centralize a criação de instâncias de teste em classes Mixin reutilizáveis localizadas em `apps/<app>/tests/mixins.py` (ou `factories.py`).

O método `create_<model>(**kwargs)` deve fornecer valores padrão inteligentes para todos os campos obrigatórios e permitir a sobrescrita de qualquer atributo via `**kwargs`:

```python
# apps/users/tests/mixins.py
from apps.users.models import User, Profile


class UserTestMixin:
    """Mixin centralizador de criacao de massa de dados do app users."""

    def create_user(self, **kwargs) -> User:
        defaults = {
            "email": f"user_{User.objects.count() + 1}@example.com",
            "is_active": True,
        }
        defaults.update(kwargs)
        return User.objects.create(**defaults)

    def create_profile(self, user=None, **kwargs) -> Profile:
        user_instance = user or self.create_user()
        defaults = {
            "user": user_instance,
            "bio": "Bio de teste",
        }
        defaults.update(kwargs)
        return Profile.objects.create(**defaults)
```

---

## 3. Uso do Mixin na Classe de Teste

```python
from django.test import TestCase
from apps.users.tests.mixins import UserTestMixin


class ProfileServiceTestCase(UserTestMixin, TestCase):
    def test_custom_profile_bio(self):
        # Sobrescreve apenas o campo bio relevante para este teste
        profile = self.create_profile(bio="Bio customizada")
        self.assertEqual(profile.bio, "Bio customizada")
```
