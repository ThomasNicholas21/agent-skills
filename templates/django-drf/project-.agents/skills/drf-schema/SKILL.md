---
name: drf-schema
description: >-
  Especialista em documentação OpenAPI/Swagger com drf-spectacular (REST) e drf-spectacular-websocket
  (Django Channels). Cria schemas.py dedicados e aplica @extend_schema_view.
---

# DRF Schema Skill (`schemas.py` & Spectacular)
Orienta a criação de arquivos `schemas.py` e a documentação OpenAPI/Swagger de APIs HTTP e WebSockets.

## Quando Ativar
- Criar arquivos `schemas.py` para declaração de Schemas/Serializers dedicados à documentação OpenAPI.
- Decorar `ViewSets` com `@extend_schema_view` e `APIViews` com `@extend_schema`.
- Definir respostas por código HTTP (`200`, `201`, `400`, `401`, `403`, `404`) com `tags`, `summary` e `description`.
- Documentar mensagens enviadas e recebidas em WebSockets via `@extend_ws_schema`.

## Conhecimento (`knowledge/`)
1. [`knowledge/spectacular-http.md`](./knowledge/spectacular-http.md): Uso de `schemas.py`, `@extend_schema_view` e `@extend_schema`.
2. [`knowledge/spectacular-websocket.md`](./knowledge/spectacular-websocket.md): Documentação WebSocket com `drf-spectacular-websocket`.

## Exemplos (`examples/`)
- [`examples/http-schema.md`](./examples/http-schema.md): `schemas.py` com respostas customizadas e `@extend_schema_view`.
- [`examples/websocket-schema.md`](./examples/websocket-schema.md): Documentação de Consumer WebSocket com `@extend_ws_schema`.

## Checklist
1. **Arquivo `schemas.py`**: Schemas dedicados à documentação foram isolados em `schemas.py`?
2. **`@extend_schema_view`**: A ViewSet possui decorador especificando as ações (`list`, `create`, etc.) com `tags`, `summary` e `responses`?
3. **WebSockets**: Consumers do Channels utilizam `@extend_ws_schema`?
