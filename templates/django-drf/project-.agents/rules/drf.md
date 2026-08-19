---
trigger:
  glob:
    - "**/{views,viewsets,serializers,schemas,urls,exceptions,consumers}*.py"
    - "**/{views,viewsets,serializers,schemas,urls,exceptions,consumers}/**/*.py"
---

# Arquitetura DRF

## Views vs ViewSets
- Use `APIView` para RPC, ações pontuais e fluxos customizados fora do CRUD padrão.
- Use `ModelViewSet`, `ReadOnlyModelViewSet` ou `GenericViewSet` para CRUD orientado a recursos.
- Não sobrescreva `list`, `create`, `retrieve`, `update` ou `destroy` para adicionar lógica de negócio.
- Para ViewSets, use `get_queryset`, `get_object`, `get_serializer_class`, `perform_create`, `perform_update` e `perform_destroy`.
- Documente APIViews e ViewSets com `@extend_schema_view` no nível da classe.

## Serializers
- Use `ModelSerializer` para CRUD de modelos, serializadores aninhados e funcionalidades específicas.
- Use `Serializer` para RPC, comandos, serviços, agregações ou payloads que não mapeiam 1:1 para modelos.
- Proibido o uso de bibliotecas de escrita aninhada (ex: `drf-writable-nested`).
- Implemente escritas aninhadas explicitamente em `create()` / `update()`.
- Envolva escritas aninhadas em `with transaction.atomic():`.
- Em serializadores aninhados filhos, não declare o objeto pai em `fields`.

## Validação
- Mantenha restrições de campos, mensagens de erro, códigos e validações de domínio no Model ou em validadores vinculados ao model.
- Deixe o `ModelSerializer` derivar a validação do model sempre que aplicável.

## URLs
- O app dono do recurso filho é dono de suas URLs.
- Não importe views filhas em apps pais apenas para montar rotas aninhadas.
- Use `path()` + `include()` e `nested_urls.py` para recursos aninhados.
- ViewSets aninhadas devem filtrar `get_queryset()` usando `self.kwargs.get("parent_pk")`.
- Criação aninhada deve usar `self.kwargs.get("parent_pk")` no `perform_create()`.
- Prefira `SimpleRouter`; especifique `basename` quando não houver `queryset` estático.

## Schemas / WebSockets
- `schemas.py` é reservado para serializers e schemas dedicados a OpenAPI/Swagger.
- ViewSets devem usar `@extend_schema_view`.
- Consumers do Channels devem usar `@extend_ws_schema` para documentação WebSocket.

## Skills
- `drf-view` → APIView / RPC / endpoints customizados.
- `drf-viewset` → ViewSets RESTful.
- `drf-serializer` → Serializers e escritas aninhadas.
- `django-drf-url` → Routers e URLs aninhadas.
- `drf-schema` → Schemas OpenAPI e WebSocket.
- `django-drf-tests` → Implementação de Testes.