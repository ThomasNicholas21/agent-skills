# Templates Django
Templates no Django são arquivos que separam a lógica de apresnetação da lógica de negócio. Eles possuem HTML com lacunas aonde dados dinâmicos podem ser inseridos e onde você controla esse fluxo, ele possui sua própria linguagem chamado Django Template Lenguage (DTL). O mesmo é processado pelo motor de template do Django que está configurado no coração do mesmo na seguinte variável:
```python
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
            'debug': True,
            'loaders': [
                'django.template.loaders.filesystem.Loader',
                'django.template.loaders.app_directories.Loader',
            ],
            'string_if_invalid': 'Template inválido: %s',
            'autoescape': True,
        },
    },
]
```
O `Backend` representa o caminho do módulo do Django que irá processar o template que no caso é da própria framework `Django`, porém ele possui compatibilidade com outros motores como Jinja2 e outros que estão disponíveis na documentação do próprio Django.
Já `DIRS` representa os diretórios que o Django vai procurar por templates para estar processando, e `APP_DIRS` sinaliza ao `Django` que os aplicativos criados possuem templates para serem renderizados.
Agora `OPTIONS` fornece diversas opções de configuração para os templates, sendo eles:
- `context_processors`: sendo esse o mais comum, essa configuração serve para disponibilizar a todos os templates variáveis da aplicação que vão ser utilizadas.
- `debug`: um `boolean` que ser para mostrar informações detalhadas de erros.
- `loader`: uma lista que especifica ao Django aonde encontrar os arquivos de template
- `string_if_invalid`: uma string que será usada em um valor inválido no template, ótimo para identificar caso haja, por exemplo, variável definida.
- `autoescape`: um booleano que indica se a escape automático de caracteres especiais deve ser ativado. Isso é importante para evitar ataques de cross-site scripting (XSS).
Importante que consulte a documentação antes de utilizar, que possui mais detalhes e limitações, que poderá ser validada de acordo com cada aplicação.

## Principais Componentes da Linguagem de Template Django (DTL)
- **Variáveis:** Permitem exibir dados. São delimitadas por chaves duplas: `{{ nome_da_variavel }}`.
    - Exemplo: Se você passar um contexto `{'nome': 'João'}` para o template, `{{ nome }}` renderizará `João`.
    - Você pode acessar atributos de objetos ou itens de dicionários usando um ponto: `{{ usuario.nome }}`, `{{ produto.preco }}`, `{{ dicionario.chave }}`.

- **Tags:** Executam alguma lógica. São delimitadas por `{% %}`. Elas podem ser "tags de bloco" (que exigem uma tag de fechamento, como `{% if %} ... {% endif %}`) ou "tags simples". As tags controlam loops, condicionais, herança de template, etc.

- **Filtros:** Modificam a exibição das variáveis. São usados com o caractere pipe `|` dentro de uma variável.
    - Exemplo: `{{ variavel|upper }}` transforma o valor de `variavel` para maiúsculas. `{{ data|date:"d/m/Y" }}` formata uma data.

## Tags utilizadas
- `include`
A tag `include` permite que você carregue e renderize outro template dentro do template atual. Isso é útil para reutilização de código e organização. Pense em componentes de UI que aparecem em várias páginas, como cabeçalhos, rodapés ou cards de produtos. Esse componentes podem ser feito em `partials` e serem incluídos aonde devem ser renderizados Ficando da seguinte maneira:
  - `{% include 'caminho/do/template.html' %}`
  - **Como funciona:** O conteúdo do template incluído é inserido no local onde a tag `include` é colocada. O template incluído tem acesso ao mesmo contexto do template que o incluiu.
  - **Benefícios:**
      - **Modularidade:** Divide templates grandes em partes menores e mais gerenciáveis.
      - **Reutilização:** Evita a duplicação de código.
      - **Manutenção:** Se um componente muda, você só precisa atualizá-lo em um lugar.

- `block` e `extends` (Herança de Templates)
Essas duas tags trabalham juntas para implementar a poderosa **herança de templates**, um dos conceitos mais importantes no Django. A herança permite que você construa um template base que define a estrutura comum do seu site e, em seguida, crie templates filhos que herdam essa estrutura e apenas preenchem ou modificam partes específicas.
    - `extends`
        - A tag `extends` declara que o template atual "estende" (herda de) outro template. É a primeira coisa que você deve colocar em um template filho. Ficando da seguinte maneira:
            - `{% extends 'caminho/do/template_pai.html' %}`
        - **Como funciona:** Quando o Django processa um template com `extends`, ele primeiro carrega o template pai. O template filho então `substitui` ou `adiciona` conteúdo em `block` definidos no template pai.
    - `block`
        - A tag `block` define uma área ou seção de conteúdo no template base que pode ser preenchida ou substituída por templates filhos. Ficando da seguinte maneira:
            -  `{% block nome_do_bloco %} Conteúdo padrão (opcional) {% endblock nome_do_bloco %}`
        - **Como funciona:**
            - No template pai, você define `block`s para as áreas que você espera que os templates filhos personalizem (e pode colocar conteúdo padrão que será usado se o filho não sobrescrever o bloco).
            - No template filho, você usa a mesma tag `block` com o mesmo `nome_do_bloco` para inserir o conteúdo específico daquele template.
        - **Benefícios da Herança:**
            - `Consistência`: Garante que todas as suas páginas tenham a mesma estrutura (cabeçalho, rodapé, barra lateral, etc.).
            - `Menos Código Repetitivo`: Você define a estrutura uma vez no template base.
            - `Fácil Manutenção`: Alterações na estrutura geral do site são feitas apenas no template base.


- `for` (Loop)
A tag `for` permite que você itere sobre uma lista ou qualquer objeto iterável que você passe para o template. Aplicando da seguinte maneira:
```html
{% for item in lista_de_itens %}
    {{ item.atributo }}
{% empty %}
    <p>Nenhum item encontrado.</p>
{% endfor %}
```
  - **Variáveis especiais dentro do loop `for`:**
    - `forloop.counter`: O índice da iteração atual (1-baseado).
    - `forloop.counter0`: O índice da iteração atual (0-baseado).
    - `forloop.revcounter`: O número de itens restantes na iteração (contagem regressiva, 1-baseado).
    - `forloop.revcounter0`: O número de itens restantes na iteração (contagem regressiva, 0-baseado).
    - `forloop.first`: True se for a primeira iteração.
    - `forloop.last`: True se for a última iteração.
    - `forloop.parentloop`: Para loops aninhados, dá acesso ao objeto `forloop` do loop pai.
  - **Exemplo:**

    ```html
    <ul>
    {% for fruta in frutas %}
        <li>{{ fruta }} {% if forloop.last %}(Última){% endif %}</li>
    {% empty %}
        <li>Nenhuma fruta na lista.</li>
    {% endfor %}
    </ul>
    ```


- `if`, `elif`, `else` (Condicionais)
As tags `if`, `elif`, `else` permitem que você execute blocos de código condicionalmente, com base no valor de uma variável ou na avaliação de uma expressão. Aplicando da seguinte maneira:
```html
{% if variavel %}
    {% elif outra_variavel == "algum_valor" %}
    {% else %}
    {% endif %}
```
  - **Operadores disponíveis:**
    - Igualdade: `==`, `!=`
    - Comparação: `>`, `<`, `>=`, `<=`
    - Lógicos: `and`, `or`, `not`
    - Membership: `in` (para verificar se um item está em uma lista)
    - Verificação de vazio: `if variavel` (é True se a variável não estiver vazia/nula/False)

## Projeto
- Aqui é possível visualizar como os templates estão sendo utilizados nesse projeto: 
    - [👉 clique aqui](https://github.com/ThomasNicholas21/ProjetoReceitas/tree/main/base_templates)
    - [👉 clique aqui](https://github.com/ThomasNicholas21/ProjetoReceitas/tree/main/recipes/templates/recipes)

## Obs
Esse projeto está sendo feito para praticar habilidades técnicas e para aprimorar a resolução de problemas. A documentação utilizada para esse estudo foi:
- [Django Documentation Templates📚](https://docs.djangoproject.com/pt-br/3.2/topics/templates/)
- [Django Documentation Templates Language📚](https://docs.djangoproject.com/pt-br/3.2/ref/templates/language/)
- [Django Documentation Templates Tags📚](https://docs.djangoproject.com/pt-br/3.2/ref/templates/builtins/#ref-templates-builtins-tags)

