# Arquivos Estáticos Django
Para aplicações web, arquivos estáticos são recursos que não mudam ou raramente mudam, servidos diretamente para o navegador do usuário. Arquivos estáticos englobam:
    - HTML
    - CSS
    - Imagens
    - JavaScript
    - Icones, Fontes e outros

No Django, arquivos estáticos são servidos através do módulo `django.contrib.staticfiles` que vem nativamente instalado no `INSTALLED_APPS` que está no arquivo `settings.py`, oferecendo um mecanismo robusto para gerenciar e servir esses arquivos, tanto em desenvolvimento quanto em produção.

Atuação dos arquivos estáticos no Django é essencial para apresentação do front-end da framework, que seriam os templates aonde o Django é responsável por servir esses arquivos. Agora para produção, no qual ele não é responsável, essa tarefa é delegada ao servidor ( Nginx, Apache ...) que será utilizado.

Pensando nisso, o Django oferece uma forma de fornecer esses arquivos a esses servidores, através do seguinte comando:
```bash
python manage.py collectstatic
```
Esse comando irá coletar todos os arquivos estáticos reconhecido pela framework, e para isso deve-se realizar as configurações adequadas e evitar colisão de nomes (técnica para evitar: namespace: consiste em colocar os arquivos dentro de pastas como `global` ou `partials`, para que assim o Django reconheça que o arquivo possui o mesmo nome porém está em pasta diferente.).

## Configuração
Para configurar, o Django oferece 3 formas:
- **STATIC_URL**
    - `Teoria`: STATIC_URL define a URL base a partir da qual os arquivos estáticos serão servidos no navegador. É o prefixo de URL que você usará nos seus templates para referenciar seus arquivos estáticos.
    - `Atuação`: Quando você usa a tag de template {% static 'caminho/do/arquivo.css' %} em seus templates Django, ela gera uma URL completa combinando o valor de STATIC_URL com o caminho/do/arquivo.css. Por exemplo, se STATIC_URL = '/static/' e você tem um arquivo my_app/static/my_app/style.css, a tag {% static 'my_app/style.css' %} gerará a URL /static/my_app/style.css.
    - `Importância`: É fundamental para que o navegador saiba onde buscar os arquivos estáticos. Ele é usado tanto em desenvolvimento (pelo runserver) quanto em produção (pelo servidor web).
```python
STATIC_URL = 'static/'
```
- **STATICFILES_DIRS**
    - `Teoria`: STATICFILES_DIRS é uma tupla ou lista de strings que define diretórios adicionais onde o aplicativo django.contrib.staticfiles deve procurar por arquivos estáticos. Por padrão, o Django já procura por arquivos estáticos dentro de uma pasta static/ em cada um dos seus aplicativos (apps) instalados. STATICFILES_DIRS permite que você inclua diretórios que estão fora da estrutura de um aplicativo específico, como um diretório static/ na raiz do seu projeto.
    - `Atuação`: Durante o desenvolvimento, o runserver usa STATICFILES_DIRS para encontrar arquivos estáticos nesses locais adicionais. Em produção, quando você executa o comando python manage.py collectstatic, esses diretórios são rastreados para copiar os arquivos estáticos para o STATIC_ROOT.
    - `Importância`: Proporciona flexibilidade para organizar seus arquivos estáticos fora da estrutura dos aplicativos, o que é útil para arquivos estáticos globais do projeto.
```python
STATICFILES_DIRS = [
    BASE_DIR / 'base_static',
]
```
- **STATIC_ROOT**
    - `Teoria`: STATIC_ROOT é o caminho absoluto para o diretório onde o comando de gerenciamento collectstatic irá coletar todos os arquivos estáticos para implantação. Este diretório é o destino final para todos os arquivos estáticos do seu projeto (provenientes dos aplicativos e dos STATICFILES_DIRS).
    - `Atuação`: Este setting é essencial para ambientes de produção. Quando você executa python manage.py collectstatic, o Django copia todos os arquivos estáticos de todos os seus INSTALLED_APPS e dos diretórios listados em STATICFILES_DIRS para o local especificado por STATIC_ROOT. Após a coleta, o servidor web (Nginx, Apache, etc.) é configurado para servir diretamente os arquivos a partir deste STATIC_ROOT através da STATIC_URL.
    - `Importância`: Em produção, o Django não serve arquivos estáticos diretamente. STATIC_ROOT é o ponto central onde todos os arquivos estáticos são reunidos para serem servidos de forma otimizada por um servidor web. É crucial não configurar STATIC_ROOT para o mesmo diretório de STATICFILES_DIRS ou para um diretório que contenha código-fonte do seu projeto, pois o collectstatic pode sobrescrever arquivos.
```python
STATIC_ROOT = BASE_DIR / 'static'
```
## Obs
Esse projeto está sendo feito para praticar habilidades técnicas e para aprimorar a resolução de problemas. A documentação utilizada para esse estudo foi:
- [Django Documentation 📚](https://docs.djangoproject.com/en/5.2/howto/static-files/)
