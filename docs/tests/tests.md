# Tests
Existem diversos tipos de testes, porém, o foco deste módulo será o **teste unitário** (ou **teste de unidade**). Para isso, precisamos inicialmente entender o principal módulo de testes do Python, o `unittest`.

Inspirado no JUnit, o `unittest` tem como finalidade testar pequenas porções do código, como funções, classes, variáveis, APIs e outros componentes isolados.

A aplicação de testes unitários traz inúmeros benefícios para o desenvolvimento, entre eles:

- Descoberta eficiente de bugs
- Maior facilidade na documentação do código
- Facilidade na refatoração
- Maior integridade e confiabilidade do código

Esses benefícios promovem uma melhor eficiência não apenas no código, mas também nos processos de integração e entrega contínua (CI/CD).

Além disso, os testes unitários podem ser utilizados tanto com TDD (*Test-Driven Development* — desenvolvimento orientado por testes), quanto após o desenvolvimento do código. No entanto, o ideal é que sejam desenvolvidos junto com o código, pois, ao deixar para depois, pode haver uma grande quantidade de funcionalidades acumuladas sem cobertura de testes, o que aumenta o esforço e a complexidade para garantir a qualidade do sistema.

## Casos de erros
Casos de erro devem ser analisados dentro do contexto da aplicação, levando em consideração regras de negócio, lógica de validação, tratamento de exceções e verificação de limites.

Devem ser analisadas todos os casos, tanto o de sucesso quanto o de falha. Normalmente é utilizado ferramentas como excel, notion, clickup, jira e entre outros.

## Assertions
**Assertions** ou **asserções** são uma forma de *afirmar* que determinada condição é verdadeira em tempo de execução. No Python, isso pode ser feito com a palavra-chave `assert`, que verifica se a condição fornecida é verdadeira. Caso não seja, uma exceção do tipo `AssertionError` é levantada.

Isso permite aplicar a chamada **programação defensiva**, ajudando a tornar o código mais confiável e fácil de manter. Exemplo com `assert`:

```python
def soma():
    assert 2 + 2 == 3, 'Cálculo errado'
```

Por baixo dos panos, isso equivale a:

```python
if not 2 + 2 == 3:
    raise AssertionError('Cálculo errado')
```

---

### `unittest` e asserções

Ao utilizar o módulo `unittest`, temos uma série de métodos de asserção disponíveis através da classe base `TestCase`. Esses métodos são preferíveis ao uso direto do `assert`, pois fornecem mensagens de erro mais descritivas e se integram melhor com ferramentas de testes.

Abaixo estão os principais métodos de asserção fornecidos por `unittest`:

| Método                      | Avalia se              | Novo em |
| --------------------------- | ---------------------- | ------- |
| `assertEqual(a, b)`         | `a == b`               |         |
| `assertNotEqual(a, b)`      | `a != b`               |         |
| `assertTrue(x)`             | `bool(x) is True`      |         |
| `assertFalse(x)`            | `bool(x) is False`     |         |
| `assertIs(a, b)`            | `a is b`               | 3.1     |
| `assertIsNot(a, b)`         | `a is not b`           | 3.1     |
| `assertIsNone(x)`           | `x is None`            | 3.1     |
| `assertIsNotNone(x)`        | `x is not None`        | 3.1     |
| `assertIn(a, b)`            | `a in b`               | 3.1     |
| `assertNotIn(a, b)`         | `a not in b`           | 3.1     |
| `assertIsInstance(a, b)`    | `isinstance(a, b)`     | 3.2     |
| `assertNotIsInstance(a, b)` | `not isinstance(a, b)` | 3.2     |


## Mocks
Mock é utilizado para simular, em um cenário de teste, objetos reais da aplicação. Nas linguagens de programação, normalmente se utilizam *frameworks* para isso. No caso do Python, isso não é diferente: utilizam-se `unittest` e `pytest` em diversos cenários.

Esses *frameworks* utilizam `Mocks` para testar a aplicação de diversas formas. Por exemplo, no `unittest`, é utilizado o módulo `unittest.mock` para se criar objetos mockados para teste.

Como por exemplo:

```python
from unittest.mock import Mock, patch
import requests

def get_users():
    response = requests.get('https://api.exemplo.com/users')
    return response.json()

@patch('requests.get')
def test_get_users(mock_get):
    mock_get.return_value.json.return_value = [{'id': 1, 'name': 'João'}]

    result = get_users()

    mock_get.assert_called_once_with('https://api.exemplo.com/users')
    assert result == [{'id': 1, 'name': 'João'}]
```

* `patch` atua como uma função decoradora, uma classe decoradora ou como *context manager*. Essa funcionalidade irá criar um objeto `Mock` que será desfeito quando o teste for finalizado.


### Mocks com `Pytest`

Por mais que o `pytest` utilize `unittest.mock` por baixo dos panos, ele fornece *plugins* e funcionalidades que tornam o teste em Python mais fácil.

No caso de Mocks, é importante instalar o seguinte plugin:

```cmd
pip install pytest-mock
```

Isso possibilita utilizar o `mocker` da seguinte maneira:

```python
import pytest
import requests

def get_data():
    return requests.get('https://api.exemplo.com/data').json()

def test_get_data(mocker):  # ao instalar o plugin, consegue-se utilizar o mocker como um parâmetro
    mock_get = mocker.patch('requests.get')
    mock_get.return_value.json.return_value = {'valor': 42}

    result = get_data()

    mock_get.assert_called_once()
    assert result == {'valor': 42}
```

## Fixtures
As fixtures são recursos reutilizáveis dentro dos testes que são utilizados de diversas formas, por exemplo: simular a conexão com banco de dados, fornecer configurações para cada teste e outros casos. Elas são executadas antes de cada teste e possuem vários casos de uso.

Para utilizar fixtures no `pytest`, é necessário utilizar `@pytest.fixture` para criar uma função que atua como tal. Depois disso, deve-se passar o nome da função como parâmetro no teste.

Alguns exemplos:

- `Setup`: fornece objetos para facilitar o teste, sendo executada antes de cada teste

```python
import pytest

@pytest.fixture
def dados_usuario():
    print("🔧 Criando dados do usuário (SETUP)")
    return {"nome": "Piquituxu", "idade": 25}

def test_nome(dados_usuario):
    assert dados_usuario["nome"] == "Piquituxu"

def test_idade(dados_usuario):
    assert dados_usuario["idade"] == 25
```

- `Teardown`: faz uma limpeza **depois** de cada teste

```python
import pytest

@pytest.fixture
def arquivo_temp():
    print("📂 Abrindo arquivo temporário (SETUP)")
    f = open("teste.txt", "w")
    yield f  # Aqui roda o teste
    print("🧽 Fechando arquivo (TEARDOWN)")
    f.close()

def test_escrita(arquivo_temp):
    arquivo_temp.write("linha de teste")
    arquivo_temp.flush()
    assert not arquivo_temp.closed
```

## unittest
O `unittest` é considerado tanto um módulo quanto um framework de testes que já vem integrado ao Python. Ele permite a automação de testes, o compartilhamento de configurações, execução de códigos de inicialização e finalização para os testes, agregação de testes em coleções e independência entre os testes e o framework de relatórios.

- `definição de contexto de teste`
    - Uma definição de contexto de teste representa a preparação necessária pra performar um ou mais testes, além de quaisquer ações de limpeza relacionadas. Isso pode envolver, por exemplo, criar bancos de dados proxy ou temporários, diretórios ou iniciar um processo de servidor.

- `caso de teste`
    - Um test case é uma unidade de teste individual. O mesmo verifica uma resposta específica a um determinado conjunto de entradas. O unittest fornece uma classe base, TestCase, que pode ser usada para criar novos casos de teste.

- `Suíte de Testes`
    - Uma test suite é uma coleção de casos de teste, conjuntos de teste ou ambos. O mesmo é usado para agregar testes que devem ser executados juntos.

- `test runner`
    - Um test runner é um componente que orquestra a execução de testes e fornece o resultado para o usuário. O runner pode usar uma interface gráfica, uma interface textual ou retornar um valor especial para indicar os resultados da execução dos testes.

# Projeto
Esse projeto será utilizado `unittest` e `pytest`, será utilizado como uma forma de aprender e aprofundar mais no ambiente de teste. Foi utilizado as seguintes referências:
- [Unittest Documentation 📚](https://docs.python.org/pt-br/3.13/library/unittest.html#assert-methods)
- [Pytest Documentation 📚](https://docs.pytest.org/en/stable/index.html)

