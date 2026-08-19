# Example: Composição de URLs Modulares no URLconf Raiz (Composition Root)
Este exemplo demonstra o arquivo de rotas principal do projeto (`core/api/urls.py` ou `config/urls.py`) funcionando como **Composition Root**. Ele inclui os arquivos de rotas dos apps de forma totalmente desacoplada, sem que os apps precisem importar uns aos outros.

```python
# core/api/urls.py
from django.urls import include, path

urlpatterns = [
    # Rotas diretas de cada módulo de domínio
    path("clients/", include("features.clients.api.urls")),
    path("products/", include("features.products.api.urls")),
    # Rotas aninhadas compartilhando o prefixo "clients/" declaradas pelo app filho "calculations"
    path("clients/", include("features.calculations.api.nested_urls")),
    # Rotas de chat compartilhando o prefixo "chat/" declaradas por cada submódulo
    path("chat/", include("features.chats.rooms.api.urls")),
    path("chat/", include("features.chats.messages.api.urls")),
    path("chat/", include("features.chats.documents.api.urls")),
]
```