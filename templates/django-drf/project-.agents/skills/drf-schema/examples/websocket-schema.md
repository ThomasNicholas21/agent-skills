# Example: Documentação e Validação de WebSocket com drf-spectacular-websocket

### Arquivo `apps/chat/api/websocket/serializers.py` (Validação de Entrada):

```python
from rest_framework import serializers


class ChatMessageInputSerializer(serializers.Serializer):
    room_id = serializers.UUIDField()
    message = serializers.CharField(max_length=1000)
```

### Arquivo `apps/chat/api/websocket/schemas.py` (Schema de Resposta Swagger):

```python
from rest_framework import serializers


class ChatMessageOutputSchema(serializers.Serializer):
    id = serializers.UUIDField()
    sender = serializers.CharField()
    message = serializers.CharField()
    timestamp = serializers.DateTimeField()
```

### Arquivo `apps/chat/api/websocket/consumers.py` (Consumer do Django Channels):

```python
from channels.generic.websocket import AsyncJsonWebsocketConsumer
from drf_spectacular_websocket.decorators import extend_ws_schema
from .serializers import ChatMessageInputSerializer
from .schemas import ChatMessageOutputSchema


class ChatConsumer(AsyncJsonWebsocketConsumer):
    @extend_ws_schema(
        type="send",
        request=ChatMessageInputSerializer,
        responses={
            200: ChatMessageOutputSchema,
            400: "Payload JSON Inválido",
        },
    )
    async def receive_json(self, content, **kwargs):
        serializer = ChatMessageInputSerializer(data=content)
        if not serializer.is_valid():
            await self.send_json({"error": serializer.errors}, close=False)
            return

        # Lógica de broadcast ou envio de mensagem
        response_data = {
            "id": "msg-123",
            "sender": self.scope["user"].username,
            "message": serializer.validated_data["message"],
            "timestamp": "2026-08-14T12:00:00Z",
        }
        await self.send_json(response_data)
```
