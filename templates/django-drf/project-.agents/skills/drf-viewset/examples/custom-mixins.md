# Example: GenericViewSet com Composição Fina de Mixins
```python
from rest_framework import viewsets, mixins, permissions
from apps.reports.models import AuditLog
from apps.reports.serializers import AuditLogSerializer


class AuditLogViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    viewsets.GenericViewSet,
):
    """
    ViewSet que habilita estritamente a listagem (list) e a criacao (create),
    sem expor retrieve, update ou destroy.
    """

    queryset = AuditLog.objects.all()
    serializer_class = AuditLogSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
```