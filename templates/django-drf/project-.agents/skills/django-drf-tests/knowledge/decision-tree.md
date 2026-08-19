# Knowledge: Árvore de Decisão para Testes e Regras Estritas de Proibição
## 1. Árvore de Decisão para Construção de Testes
```text
AO CRIAR OU MODIFICAR UM TESTE EM DJANGO / DRF:
1. O repositório já possui pytest configurado (pytest.ini / pyproject.toml / conftest.py)?
   ├── SIM ──> Usar sintaxe pytest + pytest-django (@pytest.mark.django_db).
   └── NÃO ──> Usar sintaxe Django unittest (SimpleTestCase / TestCase / APITestCase).
2. O teste necessita de acesso ao banco de dados (ORM)?
   ├── NÃO ──> Usar SimpleTestCase (ou omitir @pytest.mark.django_db). Execução ultrarrápida.
   └── SIM ──> Usar TestCase / APITestCase (ou @pytest.mark.django_db).
3. O teste necessita validar um comportamento de commit real ou lock transacional?
   ├── SIM ──> Usar TransactionTestCase (ou @pytest.mark.django_db(transaction=True)).
   └── NÃO ──> USAR TestCase PADRÃO (isola cada teste com rollback atômico).
4. Os testes da mesma classe compartilham massa de dados imutável?
   └── SIM ──> Usar @classmethod def setUpTestData(cls) para criar os dados apenas 1 vez.
5. Trata-se de um endpoint de API crítico?
   └── SIM ──> Adicionar assertNumQueries(...) para garantir ausencia de N+1.
```

## 2. Regras Estritas de Proibição
1. **NUNCA** force o uso de `pytest` em um projeto que não utilize `pytest` previamente. Respeite o framework de teste adotado pelo repositório.
2. **NUNCA** instancie modelos diretamente com `Model.objects.create(...)` espalhados nos testes. Use sempre o padrão **Model Factory Mixins** com `create_<model>(**kwargs)`.
3. **NUNCA** use `TransactionTestCase` como classe padrão de testes. Use `TestCase` com rollback atômico.
4. **NUNCA** acesse o banco de dados em testes de utilitários ou validadores puros. Use `SimpleTestCase`.
5. **NUNCA** construa o fluxo completo de login/autenticação em testes cuja finalidade seja apenas validar regras de negócio de um endpoint. Use `force_authenticate(user=user)`.