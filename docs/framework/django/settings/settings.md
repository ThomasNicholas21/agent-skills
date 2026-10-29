# Settings Django
O arquivo `settings.py` é responsável por realizar toda a configuração utilizada dentro da aplicação do Django. Sendo assim, é considerado o cérebro que orquestra operações e comportamentos dentro do projeto django.

Basicamente, ele dita como o projeto Django vai se comportar. Isso inclui desde quais aplicativos (apps) estão instalados, passando por detalhes de conexão com o banco de dados, chaves de segurança, configurações de templates, até o fuso horário da aplicação.

O arquivo manage.py é essencial em um projeto, pois ele é responsável por apontar para o arquivo `settings.py` que é o coração da aplicação. Ele carrega da seguinte maneira:
```python
def main():
    # O environ é responsável por apontar para settings.py
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'project.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
```

## Importância
- `Configuração Centralizada:` Ele agrupa todas as configurações em um único local, facilitando a gestão e a manutenção do projeto. Sem ele, teria que espalhar essas configurações por diversos arquivos, tornando o desenvolvimento e a depuração muito mais complexos.
- `Flexibilidade e Adaptabilidade:` Permite que o projeto se adapte a diferentes ambientes (desenvolvimento, teste, produção) simplesmente alterando as configurações apropriadas. Por exemplo, pode-se usar um banco de dados SQLite para desenvolvimento e PostgreSQL para produção.
- `Segurança:` Contém configurações críticas como SECRET_KEY, que é usada para proteger sessões e cookies. Manter essas informações seguras e bem configuradas é fundamental para a integridade da aplicação.
- `Controle de Comportamento:` Define o comportamento da aplicação em diversos aspectos, como a forma como as URLs são roteadas, onde os arquivos estáticos são servidos, como o log é gerado, entre outros.
- `Modularidade:` Permite que você adicione ou remova funcionalidades (apps) de forma simples, apenas incluindo ou removendo-os da lista INSTALLED_APPS.

## Configurações
```python
BASE_DIR = Path(__file__).resolve().parent.parent
```
- `BASE_DIR`: Essa variável global tem como finalidade apontar para o diretório do projeto aonde se encontra o arquivo `manage.py`, podendo ela ser personalizável de acordo com sua aplicação. Não só isso, como também é possível criar novos caminhos para estar trabalhando com arquivos `MEDIA` e `STATIC`.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/ref/settings/)

---

```python
SECRET_KEY = 'django-insecure-3vrls_vd_+tgx3b-&5z(3fxi_u=gt%0hh98v^h*s46uvoad&)'

DEBUG = True

ALLOWED_HOSTS = [
    'localhost', '127.0.0.1',
]
```
- `SECRET_KEY`: Essa variável é responsável pela segurança da aplicação, utilizadas principalmente nas `sessions`, `cookies`, `CSRF`, `autenticação` e outras funcionalidades que necessitam de proteção.
- `DEBUG`: Essa configuração aceita booleanos, e define se durante o desenvolvimento irá aparecer o erro no navegador. Caso esteja em produção, o ideal é deixar como falso, pois pode fornecer informações sensíveis, deixando a aplicação vulnerável.
- `ALLOWED_HOSTS`: Essa variável é responsável por definir quais domínios/IPs a aplicação pode servir, o mesmo serve para proteger a aplicação contra ataques. Quando `DEBUG` é `False` deve ter hosts definidos na aplicação.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/howto/deployment/checklist/#critical-settings)

---

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```
- `INSTALLED_APPS`: Essa variável é responsável por informar a aplicação quais aplicativos são conhecidos pelo django e deve ser informado um caminho reconhecido. Alguns aplicativos vem de forma nativa da própria Framework.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/ref/settings/#installed-apps)

---

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```
- `MIDDLEWARE`: O middleware é o software que se encontra entre o sistema operacional e os aplicativos nele executados. Essencialmente, o middleware funciona como uma camada oculta de tradução, permitindo a comunicação e o gerenciamento de dados para aplicativos distribuídos. No django é possível criar o próprio middleware, deve-se colocar da seguinte maneira:
```python
MIDDLEWARE = [
    ...
    'meu_app.meu_modulo.minha_func_ou_class'
]
```
Aqui basicamente funciona assim: "Entre cada request e response, execute esse código aqui!"
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/topics/http/middleware/)

---

```
ROOT_URLCONF = 'project.urls'
```
- `ROOT_URLCONF`: Essa variável serve para informar qual módulo que contém a configuração principal das `URLs` da aplicação. Normalmente esse módulo já é criado de forma nativa ao iniciar o projeto.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/ref/settings/#root-urlconf)

---
```python
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```
- `TEMPLATES`: Essa variável é responsável por definir quais templates vão ser utilizados na aplicação, nativamente o `Django` oferece os templates e seu próprio backend para fornecer esse serviço, porém é adptável, sendo possível utilizar `Jinja`. Além disso, é possível configurar diretórios para o `Django` saber aonde procurar os templates e também é possível definir `context_processors`, que basicamente são funções globais que são fornecidas em todos os templates.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/ref/settings/#root-urlconf)

---

```python
WSGI_APPLICATION = 'project.wsgi.application'
```
- `WSGI_APPLICATION`: Essa variável é muito importante para configuração do servidor da aplicação, não só para desenvolvimento, quanto para produção.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/ref/settings/#wsgi-application)

---

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
```
- `DATABASES`: Dicionário que define as configurações do banco de dados usado no projeto `Django`, a `engine` define o backend que será utilizado para se comunicar com o database desejado, nativamente vem com sqlite3, porém é possível utilizar: postegresql, mysql, sqlite3 e oracle. `Name` define qual caminho do arquivo do banco. Com BASE_DIR / 'db.sqlite3', o SQLite será salvo no diretório base do projeto.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/ref/settings/#databases)

---

```python
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': (
            'django.contrib.auth.password_validation'
            '.UserAttributeSimilarityValidator'
            ),
    },
    {
        'NAME': (
            'django.contrib.auth.password_validation'
            '.MinimumLengthValidator'
            ),
    },
    {
        'NAME': (
            'django.contrib.auth.password_validation'
            '.CommonPasswordValidator'
            ),
    },
    {
        'NAME': (
            'django.contrib.auth.password_validation'
            '.NumericPasswordValidator'
            ),
    },
]

```
- `AUTH_PASSWORD_VALIDATORS``: Lista de validadores usados para reforçar a segurança das senhas.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/ref/settings/#auth-password-validators)

---

```python
LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True
```
- `LANGUAGE_CODE`: Define o idioma padrão do projeto. 'en-us' significa inglês americano. Pode ser alterado para 'pt-br' para português do Brasil.
- `TIME_ZONE`: Fuso horário padrão da aplicação. 'UTC' é o padrão universal; pode ser alterado para 'America/Sao_Paulo' por exemplo.
- `USE_I18N`: Ativa a internacionalização (i18n), permitindo que o Django suporte vários idiomas.
- `USE_TZ`: Habilita o uso de fuso horário (timezone-aware datetimes) para os objetos DateTimeField.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/topics/i18n/)

---

```python
STATIC_URL = 'static/'
STATIC_ROOT = BASE_DIR / 'static_files'
STATICFILES_DIRS = [
    BASE_DIR / 'base_static'
]
```
- `STATIC_URL`: URL base para acessar os arquivos estáticos (CSS, JS, imagens) no navegador.
- `STATIC_ROOT`: Diretório onde os arquivos estáticos serão coletados com o comando collectstatic (normalmente usado em produção).
- `STATICFILES_DIRS`: Lista de diretórios onde o Django irá procurar arquivos estáticos adicionais durante o desenvolvimento.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/howto/static-files/)

---

```python
MEDIA_URL = 'media/'
MEDIA_ROOT = BASE_DIR / 'media'
```
- `MEDIA_URL`: URL base para servir arquivos enviados pelos usuários (ex: imagens de perfil, documentos).
- `MEDIA_ROOT`: Caminho onde os arquivos de mídia enviados pelos usuários serão armazenados.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/ref/settings/#media-root)

---

```python
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
```
- `DEFAULT_AUTO_FIELD`: Define o tipo padrão do campo id (chave primária) nos modelos criados. 'BigAutoField' é um inteiro de 64 bits que evita problemas com grandes volumes de dados.
- **Documentação:** [👉 📚](https://docs.djangoproject.com/en/5.2/ref/settings/#default-auto-field)

---

## Projeto
- Aqui é possível visualizar como o `settings.py` desse projeto: [👉 clique aqui](https://github.com/ThomasNicholas21/ProjetoReceitas/blob/main/project/settings.py)

## Obs
Esse projeto está sendo feito para praticar habilidades técnicas e para aprimorar a resolução de problemas. A documentação utilizada para esse estudo foi:
- [Django Documentation 📚](https://docs.djangoproject.com/en/5.2/)
