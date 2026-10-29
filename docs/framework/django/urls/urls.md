# URLs Django
As `URLs` do Django são definidas para mapear requisições HTTP a funções específicas (as `views`) dentro da aplicação. Elas não têm limitação imposta pela framework, o que permite que o desenvolvedor organize rotas de maneira flexível para oferecer diversos serviços em uma aplicação web.

Como o Django é uma ferramenta full stack, suas respostas (responses) geralmente envolvem a renderização de templates HTML combinados com variáveis enviadas pelo contexto. No entanto, também é possível trabalhar com `APIs`, especialmente utilizando o `Django REST Framework` (DRF).

Em resumo, as `URLs` são pontes entre o cliente e o servidor. Funcionando da seguinte maneira:
- 1º: O cliente acessa uma URL no navegador ou via requisição HTTP.
- 2º: O Django busca no módulo principal de roteamento (`urls.py`, definido no `settings.py` via `ROOT_URLCONF`) por padrões que coincidam com essa `URL`.
- 3º: Ao encontrar esse padrão, ele executa a `View` que foi passada como parâmetro, e passa para essa view a request do cliente.
- 4º: A `View` processa essa requisição e retorna uma `response` que é renderizado para o cliente.


## Parâmetros
```python
from django.urls import path
from . import views

app_name='ecommerce'

urlpatterns = [
    path('produtos/<int:id>/', views.produto_detail, name='produto_detail', kwargs={'foo': 'bar'}),
]

```
- `url`: Padrão de URL a ser casado. Pode incluir parâmetros dinâmicos, como <int:id>, que será passado como argumento para a view.
- `view`: A função (ou classe baseada em view) que será executada se o padrão da `URL` for encontrado. Essa função recebe um objeto request e os parâmetros definidos na `URL`.
- `name`: Um nome identificador para essa rota. Útil para usar em templates ({% url 'produto_detail' id=1 %}) e para reverse `URL` resolution.
- `kwargs`: (Opcional) Um dicionário de argumentos adicionais que são passados para a view em tempo de definição, não pela `URL`. No exemplo acima, a view produto_detail receberia também foo="bar" como argumento.
- `app_name`: Essa variável é o identificador da URL do aplicativo. Ao utilizar `include` é possível nomear o aplicativo através do parâmetro `namespace`, que haje como um apelido. Ambos vão funcionar, e esses identificadores servem por exemplo, para fornecer o caminho absoluto daquela URL, onde diversas funções utilizam, como:
    - `django.urls.resolvers.URLResolver`: manipula a árvore de URLs.
    - `django.urls.reverse()`: manipula resolução por namespace.
    - `django.urls.include()`: manipula a reversão de URLs com base nos nomes definidos nos apps.

Quando a url é dinâmica, ou seja, recebe um valor como no exemplo acima, é importante saber que ela, por padrão, recebe somente os seguintes valores:
- `str`: ceita qualquer string sem barra `(/)`
    ```python
    path('produtos/<str:id>/', views.produto_detail, name='produto_detail'),
    ````
- `int`: Aceita apenas números inteiros
    ```python
    path('produtos/<int:id>/', views.produto_detail, name='produto_detail'),
    ````
- `slug`: Aceita letras, números, hífens e underlines `([a-zA-Z0-9_-]+)` no padrão ASCII
    ```python
    path('produtos/<slug:id>/', views.produto_detail, name='produto_detail'),
    ````
- `uuid`: Aceita apenas valores no formato `UUID: 8-4-4-4-12`
    ```python
    path('produtos/<uuid:id>/', views.produto_detail, name='produto_detail'),
    ````
- `path`: Aceita strings com `(/)` como `/produtos/roupas/camisa/verde/`
    ```python
    path('produtos/<path:id>/', views.produto_detail, name='produto_detail'),
    ````

## Projeto
- Aqui é possível visualizar como o `urls.py` desse projeto: [👉 clique aqui](https://github.com/ThomasNicholas21/ProjetoReceitas/blob/main/project/urls.py)

## Obs
Esse projeto está sendo feito para praticar habilidades técnicas e para aprimorar a resolução de problemas. A documentação utilizada para esse estudo foi:
- [Django Documentation 📚](https://docs.djangoproject.com/en/5.2/topics/http/urls/)
