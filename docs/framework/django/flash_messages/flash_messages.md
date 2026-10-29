# URLs Django
As mensagens no Django, conhecidas como "Flash Messages", são utilizadas como uma forma de sinalizar algo para o usuário que está utilizando a aplicação, seja ele anônimo ou autenticado. Sendo possível configurar das seguinte maneira: `DEBUG`, `INFO`, `SUCCESS`, `WARNING` e `ERROR`.

Como o Django provê mensagens baseadas cookies e session, permite que seja armazenado na request e retorne no display para o request seguinte. Sendo ele dependente dos MiddleWares:
- `django.contrib.messages.middleware.MessageMiddleware`
- `django.contrib.sessions.middleware.SessionMiddleware`

Essas mensagens possuem um nivel de prioridade pré definido, porém é possível altera-los na configuração da seguinte maneira:
```python
from django.contrib.messages import constants as messages

MESSAGE_TAGS = {
    messages.INFO: "",
    50: "critical",
}
```

Para utilizar é necessário colocar nas views da seguinte maneira:
```python
messages.debug(request, "%s SQL statements were executed." % count)
messages.info(request, "Three credits remain in your account.")
messages.success(request, "Profile details updated.")
messages.warning(request, "Your account expires in three days.")
messages.error(request, "Document deleted.")
```

Ela irá aparecer nos Templates da seguinte maneira:
```python
{% if messages %}
<ul class="messages">
    {% for message in messages %}
    <li{% if message.tags %} class="{{ message.tags }}"{% endif %}>{{ message }}</li>
    {% endfor %}
</ul>
{% endif %}
```

Ao configurar as tags no arquivo principal, é possível configurar a classe que estará sendo utilizada para estilizar a mensagem:
```python
MESSAGE_TAGS = {
    constants.DEBUG: 'message-debug', # CSS
    constants.ERROR: 'message-error',
    constants.INFO: 'message-info',
    constants.SUCCESS: 'message-success',
    constants.WARNING: 'message-warning',
}
```

## Projeto
- Aqui é possível visualizar como o as flash messagens foram configuradas desse projeto: [👉 clique aqui]()

## Obs
Esse projeto está sendo feito para praticar habilidades técnicas e para aprimorar a resolução de problemas. A documentação utilizada para esse estudo foi:
- [Django Documentation 📚](https://docs.djangoproject.com/pt-br/5.2/ref/contrib/messages/)
