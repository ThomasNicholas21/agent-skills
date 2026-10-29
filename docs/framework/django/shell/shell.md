# Django Shell
O Django Shell é uma ferramente utilizada no terminal que oferece e permite que você faça interações de forma direta com seu Projeto. Dessa forma, o seu projeto é pré-carregado para que seja possível acessar todas as configurações, models, aplicativos por todo seu projeto.

Em essência o Django Shell é um REPL ( Read-Eval-Print Loop ) que inicializa todos os componentes da sua aplicação. Tornando-o incrivelmente útil para o desenvolvimento, depiração e administração do projeto como um todo, trazendo os seguintes benefícios e utilidades:
- Teste de código
- Interação com banco de dados
- Depuração
- Administração e Manutenção
- Facilidade ao explorar o Projeto

Para executar, deve-se rodar no terminal o seguinte comando.
```cmd
python manage.py shell
```
Para utilização, segue alguns exemplos:

- **Importando Modelos e Criando Objetos**

Primeiro, precisamos importar os modelos dos seus aplicativos.

```python
# Dentro do shell
>>> from meuapp.models import Produto, Categoria

# Criando instâncias de modelos
>>> c = Categoria.objects.create(nome='Eletrônicos')
>>> p1 = Produto.objects.create(nome='Smartphone X', preco=1200.00, categoria=c)
>>> p2 = Produto.objects.create(nome='Notebook Pro', preco=3500.00, categoria=c)

# Verificando se foram criados (o __str__ do modelo ajuda aqui)
>>> c
<Categoria: Eletrônicos>
>>> p1
<Produto: Smartphone X>
```


- **Consultando Objetos com o ORM**

Use os métodos do `objects` para recuperar dados do banco.

```python
# Todos os produtos
>>> produtos = Produto.objects.all()
>>> for p in produtos:
...     print(p.nome, p.preco)
...
Smartphone X 1200.00
Notebook Pro 3500.00

# Filtrando produtos
>>> produtos_caros = Produto.objects.filter(preco__gt=1500)
>>> produtos_caros
<QuerySet [<Produto: Notebook Pro>]>
>>> produtos_caros[0].nome
'Notebook Pro'

# Obtendo um único objeto
>>> smartphone = Produto.objects.get(nome='Smartphone X')
>>> smartphone.preco
Decimal('1200.00')

# Acessando relacionamentos
>>> smartphone.categoria.nome
'Eletrônicos'
```


- **Atualizando e Deletando Objetos**

```python
# Atualizando um objeto
>>> smartphone.preco = 1150.00
>>> smartphone.save() # Lembre-se de salvar!
>>> Produto.objects.get(nome='Smartphone X').preco # Verificando a mudança
Decimal('1150.00')

# Deletando um objeto
>>> Notebook = Produto.objects.get(nome='Notebook Pro')
>>> Notebook.delete()
(1, {'meuapp.Produto': 1}) # Retorna o número de objetos deletados e o tipo

# Tentando acessar algo que foi deletado
>>> Produto.objects.all()
<QuerySet [<Produto: Smartphone X>]>
```


- **Acessando Configurações e Funções do Django**

Você pode acessar suas configurações e até mesmo funções de seus aplicativos.

```python
# Acessando configurações do settings.py
>>> from django.conf import settings
>>> settings.DEBUG
True # Ou False, dependendo da sua configuração

# Testando uma função de um utilitário (se você tiver um arquivo utils.py, por exemplo)
# Imagine que você tem um arquivo meuapp/utils.py com uma função 'calcular_desconto'
# >>> from meuapp.utils import calcular_desconto
# >>> calcular_desconto(100, 0.1)
# 90.0
```

## Obs
Esse projeto está sendo feito para praticar habilidades técnicas e para aprimorar a resolução de problemas. A documentação utilizada para esse estudo foi:
- [Django Documentation Model 📚](https://docs.djangoproject.com/en/5.2/ref/contrib/gis/tutorial/#:~:text=shell%3A)

