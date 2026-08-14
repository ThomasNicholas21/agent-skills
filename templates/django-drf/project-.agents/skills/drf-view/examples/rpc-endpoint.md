# Example: APIView Limpa para Endpoint RPC

Este exemplo demonstra a implementação de um endpoint RPC de ação única com `APIView`.
Ele utiliza atributos de política (`permission_classes`, `parser_classes`, `throttle_classes`), valida o payload de entrada via serializador e retorna o resultado diretamente sem a necessidade de um serializador de saída extra e sem poluição de decoradores de documentação.

```python
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status, permissions, parsers
from rest_framework.throttling import UserRateThrottle

from apps.authentication.serializers import VerifyOtpSerializer
from apps.authentication.services import AuthService


class VerifyOtpAPIView(APIView):
    permission_classes = [permissions.AllowAny]
    parser_classes = [parsers.JSONParser]
    throttle_classes = [UserRateThrottle]

    def post(self, request, *args, **kwargs):
        # 1. Instanciar e validar serializador de entrada
        serializer = VerifyOtpSerializer(
            data=request.data, context={"request": request}
        )
        serializer.is_valid(raise_exception=True)

        # 2. Executar lógica de negócio na camada de serviço
        token_data = AuthService.verify_otp(
            phone=serializer.validated_data["phone"],
            code=serializer.validated_data["code"],
        )

        # 3. Retornar resposta
        return Response(token_data, status=status.HTTP_200_OK)
```
