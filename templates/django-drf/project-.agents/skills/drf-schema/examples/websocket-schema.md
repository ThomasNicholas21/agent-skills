# Example: Documentação WebSocket com drf-spectacular-websocket

```python
# apps/notifications/consumers.py
from channels.generic.websocket import AsyncJsonWebsocketConsumer
from drf_spectacular_websocket.schemas import extend_ws_schema
from rest_framework import serializers

class NotificationSendSchema(serializers.Serializer):
    action = serializers.CharField(default="subscribe")
    channel = serializers.CharField()

class NotificationReceiveSchema(serializers.Serializer):
    event = serializers.CharField()
    payload = serializers.DictField()

@extend_ws_schema(
    type="send",
    summary="Mensagem enviada pelo cliente ao conectar ou subscrever",
    request=NotificationSendSchema,
)
@extend_ws_schema(
    type="receive",
    summary="Mensagem de notificação enviada pelo servidor",
    responses={200: NotificationReceiveSchema},
)
class NotificationConsumer(AsyncJsonWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def receive_json(self, content):
        ...
```
