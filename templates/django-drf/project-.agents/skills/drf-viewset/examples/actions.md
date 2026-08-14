# Example: ViewSet com Ações Customizadas (@action)

```python
from rest_framework import viewsets, permissions, status
from rest_framework.decorators import action
from rest_framework.response import Response
from apps.users.models import User
from apps.users.serializers import UserSerializer, SetPasswordSerializer


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAdminUser]

    @action(detail=True, methods=["post"], serializer_class=SetPasswordSerializer)
    def set_password(self, request, pk=None):
        """
        Acao em nivel de objeto (detail=True). Rota: POST /users/{pk}/set_password/
        """
        user = self.get_object()
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        user.set_password(serializer.validated_data["password"])
        user.save(update_fields=["password"])
        return Response({"status": "senha alterada com sucesso"}, status=status.HTTP_200_OK)

    @action(detail=False, methods=["get"])
    def recent(self, request):
        """
        Acao em nivel de colecao (detail=False). Rota: GET /users/recent/
        """
        recent_users = self.get_queryset().order_by("-date_joined")[:10]
        serializer = self.get_serializer(recent_users, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
```
