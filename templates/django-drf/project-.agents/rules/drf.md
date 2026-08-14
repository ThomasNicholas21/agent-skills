---
trigger:
  glob:
    - "**/{views,viewsets,serializers,schemas,urls,exceptions,consumers}*.py"
    - "**/{views,viewsets,serializers,schemas,urls,exceptions,consumers}/**/*.py"
---

# Regras de Desenvolvimento: DRF Architecture, Views, ViewSets, Serializers, OpenAPI Schemas e URLs

Ao construir ou modificar APIs e WebSockets no Django REST Framework, siga estritamente estas diretrizes de arquitetura, separação de responsabilidades, roteamento e documentação.

---

## 1. Separação Explícita: Views (`APIView`) vs ViewSets (`ModelViewSet`)

- **Views (`APIView`)**:
  - **Quando usar**: Para rotas específicas, endpoints RPC/função (ex: `/orders/checkout/`, `/auth/verify-token/`), operações de ação única ou fluxos customizados que não seguem o ciclo de vida CRUD padrão.
  - **Regra**: Utilize `@extend_schema` diretamente acima dos métodos HTTP (`get`, `post`, `put`, `patch`, `delete`).

- **ViewSets (`ModelViewSet`, `ReadOnlyModelViewSet`, `GenericViewSet`)**:
  - **Quando usar**: Para gerenciamento de recursos RESTful padrão baseados em entidades/modelos (operações CRUD).
  - **Regra de Ouro**: É **PROIBIDO** sobrescrever métodos de ação de rota (`list`, `create`, `retrieve`, `update`, `destroy`) para inserir lógica customizada. Toda a lógica DEVE ser delegada aos métodos nativos do ciclo de vida (`get_queryset`, `get_object`, `get_serializer_class`, `perform_create`, `perform_update`, `perform_destroy`).
  - **Decorador**: Utilize obrigatoriamente `@extend_schema_view` no topo da classe ViewSet.

---

## 2. Separação Explícita: Serializer vs ModelSerializer

- **`ModelSerializer`**:
  - **Quando usar**: Para CRUDs padrão e endpoints diretamente vinculados a um `Django Model`.
  - Herda automaticamente campos, tipos e mensagens de validação do modelo.

- **`Serializer` (Plain `serializers.Serializer`)**:
  - **Quando usar**: Para fluxos específicos de serviços, RPC payloads, comandos assíncronos, agregação de múltiplos dados ou payloads customizados sem vínculo direto de tabela 1:1.

---

## 3. Escrita Aninhada Manual em Serializers (Sem Libs Mágicas)

- **Regra Estrita**: É **PROIBIDO** utilizar bibliotecas externas mágicas de escrita aninhada (ex: `drf-writable-nested` ou `writable-nested-serializer`).
- **Implementação Manual**: Toda gravação de objetos aninhados (1:N ou N:N) DEVE ser feita de forma **manual e explícita** nos métodos `create(self, validated_data)` e `update(self, instance, validated_data)` do Serializer.
- **Transacionalidade**: Envolva toda gravação aninhada obrigatoriamente em `with transaction.atomic():`.

---

## 4. Mensagens de Erro e Validação no Nível do Model

- **Centralização no Model**: Mensagens de erro de validação, limites de campos, códigos de erro e regras de restrição DEVEM ser definidos no **Model** (ou em validadores customizados vinculados ao modelo).
- **Herança Automática**: Como o `ModelSerializer` consome as regras do modelo, ele assumirá automaticamente as mensagens de erro customizadas, mantendo os contratos de resposta de erro padronizados e DRY.

---

## 5. Roteamento e Posse de URLs (Resource Ownership & Rotas Aninhadas)

- **Resource Ownership**: O app que possui o recurso filho DEVE ser o dono da definição de URL desse recurso. É **PROIBIDO** que um app pai importe Views ou ViewSets de um app filho apenas para criar rotas aninhadas.
- **Rotas Aninhadas Nativas**: Utilizar o padrão nativo do Django `path()` + `include()` com o arquivo `nested_urls.py` no app filho (ex: `<uuid:client_pk>/calculations/`).
- **Isolamento de Escopo no ViewSet**: Toda ViewSet aninhada DEVE filtrar obrigatoriamente `get_queryset()` usando o parâmetro `parent_pk` de `self.kwargs` e salvar em `perform_create()` utilizando `self.kwargs["parent_pk"]`.
- **Routers**: Utilizar `SimpleRouter` como padrão, especificando `basename` quando a ViewSet não possuir o atributo estático `queryset`.

---

## 6. Módulo `schemas.py` & Integração com DRF Spectacular (HTTP + WebSockets)

### A. Arquivo `schemas.py`
- Reservado exclusivamente para declarar **Serializers e Schemas dedicados à documentação OpenAPI / Swagger** via `drf-spectacular`.

### B. Padrão de Decoradores HTTP (`@extend_schema_view` & `@extend_schema`)
- **Em ViewSets**: Aplicar `@extend_schema_view` no topo da classe decorando cada ação (`list`, `create`, `retrieve`, `update`, `partial_update`, `destroy`, `@action`).

### C. Documentação e Validação de WebSockets (`drf-spectacular-websocket`)
- Utilizado nos métodos dos Consumers do Django Channels via decorador `@extend_ws_schema`.

---

## 7. Gatilhos de Invocação de Skill

> *Para construir rotas RPC ou views customizadas com `APIView`, **invoque a skill `drf-view`**.*
> *Para implementar ViewSets RESTful e gerenciar o ciclo de vida nativo de recursos, **invoque a skill `drf-viewset`**.*
> *Para criar `ModelSerializer`, `Serializer` genérico ou escrita aninhada manual, **invoque a skill `drf-serializer`**.*
> *Para organizar rotas modulares, routers DRF ou rotas aninhadas, **invoque a skill `drf-django-url`**.*
> *Para definir `schemas.py`, decoradores `@extend_schema_view` ou documentação de WebSockets, **invoque a skill `drf-schema`**.*