---
name: drf-schema
description: >-
  Especialista em documentação OpenAPI/Swagger utilizando drf-spectacular em HTTP (REST)
  e drf-spectacular-websocket em Django Channels. Cria arquivos schemas.py e aplica @extend_schema_view.
---

# DRF Schema Skill (`schemas.py` & DRF Spectacular)

Esta habilidade orienta a criação de arquivos `schemas.py` e a documentação completa de APIs HTTP e WebSockets utilizando `drf-spectacular` e `drf-spectacular-websocket`.

---

## Quando Ativar Esta Skill

Ative esta skill quando a tarefa envolver:
- Criar arquivos `schemas.py` para declaração de Schemas/Serializers dedicados à documentação OpenAPI/Swagger.
- Decorar `ViewSets` com `@extend_schema_view` e `APIViews` com `@extend_schema`.
- Definir respostas por código de status HTTP (`200`, `201`, `400`, `401`, `403`, `404`) com `summary`, `description` e `tags`.
- Documentar endpoints de lista aninhada/árvore (`children`) que não pertencem ao `serializers.py` padrão.
- Documentar mensagens enviadas e recebidas em WebSockets (Django Channels) via `@extend_ws_schema`.

---

## Índice de Conhecimento Profundo (`knowledge/`)

1. [`knowledge/spectacular-http.md`](./knowledge/spectacular-http.md): Uso de `schemas.py`, `@extend_schema_view` e `@extend_schema` para APIs REST.
2. [`knowledge/spectacular-websocket.md`](./knowledge/spectacular-websocket.md): Documentação de WebSockets usando `drf-spectacular-websocket` e `@extend_ws_schema`.

---

## Exemplos de Código (`examples/`)

- [`examples/http-schema.md`](./examples/http-schema.md): `schemas.py` com respostas customizadas e `@extend_schema_view` em ViewSets.
- [`examples/websocket-schema.md`](./examples/websocket-schema.md): Documentação de Consumer de WebSocket com `@extend_ws_schema` (`type='send'` e `type='receive'`).

---

## Checklist de Implementação de Schemas

1. **Arquivo Dedicated `schemas.py`**: Schemas exclusivos para documentação Swagger (ou resumos hierárquicos) foram isolados em `schemas.py`?
2. **`@extend_schema_view` no topo da ViewSet**: A ViewSet possui o decorador especificando as ações (`list`, `create`, `retrieve`, etc.) com `tags`, `summary`, `description` e `responses`?
3. **WebSockets Decorados**: Consumers do Django Channels utilizam `@extend_ws_schema(type="send"|"receive", ...)`?
