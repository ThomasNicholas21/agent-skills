# Django ORM
ORM, ou Object-Relational Mapper, é uma técnica de mapeamento que permite relacionar objetos com os dados que eles representam, sendo uma alternativa para evitar a escrita direta de código SQL e tornar o desenvolvimento mais produtivo. No caso do Django, ele cria uma "ponte" entre a Programação Orientada a Objetos (POO) e o paradigma relacional dos bancos de dados.

Para iniciar a utilização do ORM do Django, é necessário, primeiramente, criar um model no app que está sendo desenvolvido. Ao criar o app, o próprio Django disponibiliza um arquivo chamado models.py, que é onde o Django reconhece quais tabelas serão criadas durante o desenvolvimento da aplicação. Em conjunto com comandos como `python manage.py makemigrations`e `python manage.py migrate`, o ORM do Django realiza essa criação no banco de dados utilizado.

Ao realizar essa migração, você cria a primeira versão do seu banco de dados, armazenada no arquivo `0001_initial.py`, que contém a migração responsável por aplicar a estrutura dos models ao banco de dados. Esse processo é repetido sempre que um model é criado ou alterado. Para aplicar as mudanças no banco, é necessário executar o comando `python manage.py migrate`.

Esse procedimento de migração trás inúmeras vantagens para o projeto de forma geral, por exemplo:
- `Controle de versão do banco de dados`
- `Automatização das mudanças`
- `Sincronização entre ambientes`
- `Integração com CI/CD`
- `Segurança na evolução do banco`
- `Testabilidade e previsibilidade`
- `Rollback de alterações (reversibilidade)`

**_migrate_ x _makemigrations_**
- `makemigrations`: gera os arquivos de migrações
- `migrate`: aplica os arquivos de migrações

**models**

Os models são o primeiro passo para que o Django realize o ORM entre o código e o banco de dados. É onde se utiliza POO para criar entidades e atributos no banco. Importando do módulo `django.db`, é possível utilizar outro módulo chamado `models`, o qual possui diversas classes responsáveis por definir e tipar atributos dentro do banco de dados, como no exemplo a seguir:
```python
from django.db import models


class Filho(models.Model):
    nome = models.CharField(max_length=64)
    idade = models.PositiveIntegerField()
    pai = modes.ForeignKey(
        Pai,
        on_delete=models.SET_NULL,
        null=True
    )
    ...

```
Nesse exemplo, a classe `Filho` herda de `Model` seus atributos e métodos, tornando-se uma entidade no banco de dados (somente após a migração). No módulo `models`, é possível utilizar outras classes que são responsáveis por definir o tipo de dado que os atributos receberão. Além disso, esses campos também aceitam parâmetros para configurar regras e padrões que os dados devem seguir.

Também é possível definir relações entre tabelas utilizando classes específicas que são responsáveis por se comunicar com outras entidades.

- **Campos Comuns (`Field Types`)**

| Campo                  | Descrição                                                                |
| ---------------------- | ------------------------------------------------------------------------ |
| `CharField`            | Campo de texto com limite de caracteres. Requer `max_length`.            |
| `TextField`            | Campo de texto sem limite definido. Ideal para descrições longas.        |
| `IntegerField`         | Armazena números inteiros positivos ou negativos.                        |
| `PositiveIntegerField` | Armazena somente inteiros positivos (>= 0).                              |
| `BooleanField`         | Armazena `True` ou `False`.                                              |
| `DateField`            | Armazena apenas datas (sem horário).                                     |
| `DateTimeField`        | Armazena data e hora.                                                    |
| `TimeField`            | Armazena apenas o horário.                                               |
| `EmailField`           | Campo de texto que valida se é um e-mail válido.                         |
| `URLField`             | Campo para URLs válidas.                                                 |
| `DecimalField`         | Armazena números decimais fixos. Requer `max_digits` e `decimal_places`. |
| `FloatField`           | Armazena números de ponto flutuante. Menos preciso que `DecimalField`.   |
| `SlugField`            | Armazena slugs (texto para URLs amigáveis).                              |
| `FileField`            | Armazena arquivos. Requer configuração de mídia.                         |
| `ImageField`           | Armazena imagens. Exige biblioteca Pillow instalada.                     |

- **Campos de Relacionamento**

| Campo             | Descrição                                                                                  |
| ----------------- | ------------------------------------------------------------------------------------------ |
| `ForeignKey`      | Cria um relacionamento muitos-para-um com outra tabela. Requer argumento `on_delete`.      |
| `OneToOneField`   | Relacionamento um-para-um. Uma instância está ligada diretamente a outra.                  |
| `ManyToManyField` | Relacionamento muitos-para-muitos. O Django cria uma tabela intermediária automaticamente. |


- **Parâmetros Comuns dos Campos**

| Parâmetro      | Aplicação                      | Descrição                                                                                                   |
| -------------- | ------------------------------ | ----------------------------------------------------------------------------------------------------------- |
| `max_length`   | `CharField`, `SlugField`, etc. | Define o número máximo de caracteres. Obrigatório em alguns campos.                                         |
| `null`         | Todos                          | Permite que o campo aceite `NULL` no banco de dados.                                                        |
| `blank`        | Todos                          | Permite que o campo seja deixado em branco nos formulários (nível de validação).                            |
| `default`      | Todos                          | Define um valor padrão caso não seja informado.                                                             |
| `choices`      | Campos de texto/inteiros       | Define um conjunto fixo de valores possíveis.                                                               |
| `unique`       | Todos                          | Garante que o valor seja único no banco de dados.                                                           |
| `primary_key`  | Todos                          | Define o campo como chave primária da tabela.                                                               |
| `verbose_name` | Todos                          | Nome legível do campo para uso em formulários/admin.                                                        |
| `help_text`    | Todos                          | Texto auxiliar exibido em formulários/admin.                                                                |
| `on_delete`    | `ForeignKey`, `OneToOneField`  | Define o comportamento quando o objeto relacionado é deletado (ex: `CASCADE`, `SET_NULL`, `PROTECT`, etc.). |

**OBS**: Lembrando que existe muitos outros Fields e Parâmetros que podem ser utilizados, e é essencial consultar a documentação oficial do Django para analisar qual vai ser a melhor opção dentro do projeto.

**Manager**

O manager é "criado" a partir do momento em que a classe definida herda de `models.Model`. Ao instanciar o model, é possível utilizar `Filho.objects`, que é a instanciação do manager no Django que é `django.db.models.Manager`. Ele é responsável por realizar operações e consultas SQL utilizando o ORM do Django. Dessa forma, torna-se possível realizar um SELECT, por exemplo, chamando o método `Filho.objects.get(nome="FOO")`. Ao executar esse procedimento, será retornado um `QuerySet`, uma vez que a `query` foi realizada.

`QuerySet` nada mais é do que uma coleção de dados, sendo o resultado de uma `query` executada no banco de dados.

É importante saber que o Manager pode ser personalizado, ou seja, pode ser utilizado para criar métodos de consulta de acordo com sua necessidade. Não só isso, mas tembém é importante notar que muitos métodos podem retornar o objeto diretamente ou `QuerySet`, por exemplo, `.filter()` retorna uma `QuerySet`, já `.get()` retorna o objeto diretamente.

- **Funções do Django ORM e Equivalente SQL**

| Django ORM                                     | SQL Equivalente                                         | Descrição                                                   |
| ---------------------------------------------- | ------------------------------------------------------- | ----------------------------------------------------------- |
| `Model.objects.all()`                          | `SELECT * FROM table;`                                  | Retorna todos os registros da tabela.                       |
| `Model.objects.get(pk=1)`                      | `SELECT * FROM table WHERE id = 1;`                     | Retorna um único registro com a chave primária informada.   |
| `Model.objects.filter(ativo=True)`             | `SELECT * FROM table WHERE ativo = true;`               | Filtra os registros com base na condição.                   |
| `Model.objects.exclude(ativo=False)`           | `SELECT * FROM table WHERE ativo != false;`             | Exclui registros que correspondem à condição.               |
| `Model.objects.order_by('nome')`               | `SELECT * FROM table ORDER BY nome ASC;`                | Ordena os resultados por um campo.                          |
| `Model.objects.order_by('-data_criacao')`      | `SELECT * FROM table ORDER BY data_criacao DESC;`       | Ordena em ordem decrescente.                                |
| `Model.objects.values('nome')`                 | `SELECT nome FROM table;`                               | Retorna uma QuerySet de dicionários com campos específicos. |
| `Model.objects.values_list('nome', flat=True)` | `SELECT nome FROM table;` (retorna lista simples)       | Lista com apenas os valores de um campo.                    |
| `Model.objects.count()`                        | `SELECT COUNT(*) FROM table;`                           | Conta o número de registros.                                |
| `Model.objects.exists()`                       | `SELECT EXISTS(SELECT 1 FROM table);`                   | Verifica se há registros que correspondem.                  |
| `Model.objects.first()`                        | `SELECT * FROM table ORDER BY id ASC LIMIT 1;`          | Retorna o primeiro registro.                                |
| `Model.objects.last()`                         | `SELECT * FROM table ORDER BY id DESC LIMIT 1;`         | Retorna o último registro.                                  |
| `Model.objects.latest('created_at')`           | `SELECT * FROM table ORDER BY created_at DESC LIMIT 1;` | Retorna o mais recente com base em um campo de data.        |
| `Model.objects.earliest('created_at')`         | `SELECT * FROM table ORDER BY created_at ASC LIMIT 1;`  | Retorna o mais antigo.                                      |
| `Model.objects.aggregate(Sum('valor'))`        | `SELECT SUM(valor) FROM table;`                         | Agregações como `SUM`, `AVG`, `MAX`, `MIN`.                 |
| `Model.objects.annotate(qtde=Count('itens'))`  | `SELECT COUNT(itens) AS qtde FROM table GROUP BY ...`   | Agrupamento com anotação de valor extra.                    |
| `Model.objects.select_related('autor')`        | `JOIN` (eager loading, 1-to-1 ou FK)                    | Otimiza acesso a FK com `INNER JOIN`.                       |
| `Model.objects.prefetch_related('tags')`       | `JOIN` simulado (2 queries)                             | Otimiza acesso a M2M ou FK reverso.                         |
| `Model.objects.update(status='ativo')`         | `UPDATE table SET status = 'ativo';`                    | Atualização em massa.                                       |
| `Model.objects.create(**kwargs)`               | `INSERT INTO table (...) VALUES (...);`                 | Criação de registro.                                        |
| `instance.delete()`                            | `DELETE FROM table WHERE id = ...;`                     | Deleção de registro.                                        |
| `Model.objects.bulk_create([...])`             | `INSERT INTO table (...) VALUES (...), (...), ...;`     | Criação em massa (eficiente).                               |
| `Model.objects.bulk_update([...])`             | `UPDATE table SET ... WHERE id = ...;`                  | Atualização em massa (desde 2.2+).                          |


- **Lookups mais úteis (filtros)**

| Lookup                         | Descrição                      | Exemplo Django                                      | SQL                               |
| ------------------------------ | ------------------------------ | --------------------------------------------------- | --------------------------------- |
| `exact`                        | Igual ao valor                 | `.filter(nome__exact='João')`                       | `WHERE nome = 'João'`             |
| `iexact`                       | Igual (case-insensitive)       | `.filter(nome__iexact='joão')`                      | `ILIKE` ou `LOWER(nome) = 'joão'` |
| `contains`                     | Contém substring               | `.filter(nome__contains='jo')`                      | `WHERE nome LIKE '%jo%'`          |
| `icontains`                    | Contém (case-insensitive)      | `.filter(nome__icontains='jo')`                     | `ILIKE '%jo%'`                    |
| `startswith`                   | Começa com                     | `.filter(nome__startswith='Jo')`                    | `LIKE 'Jo%'`                      |
| `istartswith`                  | Começa com (case-insensitive)  | `.filter(nome__istartswith='jo')`                   | `ILIKE 'jo%'`                     |
| `endswith`                     | Termina com                    | `.filter(nome__endswith='ão')`                      | `LIKE '%ão'`                      |
| `iendswith`                    | Termina com (case-insensitive) | `.filter(nome__iendswith='ÃO')`                     | `ILIKE '%ão'`                     |
| `in`                           | Está em uma lista              | `.filter(id__in=[1, 2, 3])`                         | `WHERE id IN (1,2,3)`             |
| `gt`, `gte`                    | Maior que, Maior ou igual      | `.filter(valor__gt=100)`                            | `> 100`                           |
| `lt`, `lte`                    | Menor que, Menor ou igual      | `.filter(valor__lte=50)`                            | `<= 50`                           |
| `range`                        | Entre dois valores             | `.filter(data__range=('2023-01-01', '2023-12-31'))` | `BETWEEN`                         |
| `isnull`                       | Verifica nulo                  | `.filter(pai__isnull=True)`                         | `IS NULL`                         |
| `regex`, `iregex`              | Expressão regular              | `.filter(nome__regex=r'^[A-Z]')`                    | `~` ou `REGEXP`                   |
| `date`, `year`, `month`, `day` | Filtros por partes da data     | `.filter(data__year=2024)`                          | `EXTRACT(YEAR FROM data)`         |
| `week_day`                     | Dia da semana (1=Dom)          | `.filter(data__week_day=2)`                         | `EXTRACT(DOW FROM data)`          |
| `search`                       | Pesquisa em `SearchVector`     | `.annotate(search=SearchVector(...))`               | `to_tsvector()` no PostgreSQL     |

**OBS**: Lembrando que existe muitos outros Fields e Parâmetros que podem ser utilizados, e é essencial consultar a documentação oficial do Django para analisar qual vai ser a melhor opção dentro do projeto.


## Projeto
- Aqui é possível visualizar como os templates estão sendo utilizados nesse projeto: 
    - [👉 clique aqui](https://github.com/ThomasNicholas21/ProjetoReceitas/blob/main/recipes/models.py)

## Obs
Esse projeto está sendo feito para praticar habilidades técnicas e para aprimorar a resolução de problemas. A documentação utilizada para esse estudo foi:
- [Django Documentation Model 📚](https://docs.djangoproject.com/en/5.2/intro/tutorial02/)
- [Django Documentation Fields📚](https://docs.djangoproject.com/pt-br/3.2/ref/models/fields/)
- [Django Documentation QuerySet📚](https://docs.djangoproject.com/pt-br/3.2/ref/models/querysets/)
