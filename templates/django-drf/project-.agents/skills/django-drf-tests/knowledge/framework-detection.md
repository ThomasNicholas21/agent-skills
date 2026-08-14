# Knowledge: Detecção de Runner (Unittest Nativo vs Pytest) e Paralelismo

---

## 1. Regra de Detecção do Framework de Testes

O agente DEVE verificar qual executor de testes o repositório utiliza antes de escrever novos arquivos de teste:

```text
O repositório possui `pytest.ini`, `conftest.py` ou `pyproject.toml` com [tool.pytest.ini_options]?
  ├── SIM ──> Usar `pytest` + `pytest-django` + `pytest-xdist`.
  └── NÃO ──> Usar Django `unittest` (`django.test.TestCase` / `django.test.SimpleTestCase`).
```

> **Aviso**: É **PROIBIDO** introduzir `pytest`, `conftest.py` ou novas dependências de teste em um projeto que não utilize `pytest` previamente, a menos que o usuário solicite explicitamente a migração.

---

## 2. Execução Paralela

### A. Execução Paralela com Django Nativo (`unittest`)
```bash
python manage.py test --parallel 4
```
O Django cria bancos de teste separados por processo em execução.

### B. Execução Paralela com `pytest` (`pytest-xdist`)
```bash
pytest -n auto
```
Com `pytest-django` + `pytest-xdist`, cada worker recebe seu próprio banco de testes isolado (ex: `test_db_gw0`, `test_db_gw1`).

---

## 3. Paralelismo Exige Isolamento Total

- NUNCA compartilhe estado mutável entre testes executados em paralelo.
- NUNCA dependa de estruturas não ordenadas em parametrizações:
  - **Incorreto**: `@pytest.mark.parametrize("val", {"a", "b"})` (conjunto não ordenado quebra em múltiplos workers).
  - **Correto**: `@pytest.mark.parametrize("val", ["a", "b"])` (lista ordenada).
