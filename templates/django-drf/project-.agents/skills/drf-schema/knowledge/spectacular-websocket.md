# Knowledge: Documentação de WebSockets com drf-spectacular-websocket
WebSockets não seguem o modelo HTTP tradicional. O envio e a recepção de mensagens assíncronas são mapeados usando `drf-spectacular-websocket`.

## 1. Configuração Inicial em `settings.py`
`drf_spectacular_websocket` deve ser posicionado **acima** de `drf_spectacular`:
```python
INSTALLED_APPS = [
    "drf_spectacular_websocket",
    "drf_spectacular",
    # ...
]
```

## 2. Tipos de Interação WebSocket (`type`)
- **`type='send'`**: Requisição de mensagem enviada pelo cliente com resposta esperada pelo servidor (Request/Response WebSocket).
- **`type='receive'`**: Evento emitido pelo servidor sem uma requisição direta do cliente (Broadcast/Event).

## 3. Padrão Decorador `@extend_ws_schema`
```python
from channels.generic.websocket import AsyncJsonWebsocketConsumer
from drf_spectacular_websocket.decorators import extend_ws_schema
from .serializers import ChatMessageInputSerializer
from .schemas import ChatMessageOutputSchema


class ChatConsumer(AsyncJsonWebsocketConsumer):
    @extend_ws_schema(
        type="send",
        request=ChatMessageInputSerializer,
        responses={200: ChatMessageOutputSchema},
    )
    async def receive_json(self, content, **kwargs):
        # Validação do JSON de entrada via serializer
        serializer = ChatMessageInputSerializer(data=content)
        serializer.is_valid(raise_exception=True)

        # Processamento e envio de resposta
        ...
```