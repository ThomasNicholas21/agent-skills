---
name: drf-serializer
description: >-
  Especialista em arquitetura de Serializers no DRF, validação em 3 níveis, campos relacionais
  e escrita aninhada manual com transaction.atomic.
---

# DRF Serializer Skill
Orienta a construção de Serializers e ModelSerializers no Django REST Framework para validação, representação e escrita transacional.

## Quando Ativar
- Criar `ModelSerializer` para endpoints diretamente vinculados a modelos Django.
- Criar `Serializer` genérico para payloads de serviços, comandos ou endpoints RPC.
- Configurar validações em 3 níveis (campo primitivo, `validate_<field>` e `validate`).
- Implementar escrita aninhada manual em `create()` e `update()` usando `transaction.atomic()`.
- Mapear relacionamentos (`PrimaryKeyRelatedField`, `SlugRelatedField`, Nested Serializers).

## Regra Estrita
> Proibido o uso de bibliotecas de escrita aninhada (ex: `drf-writable-nested`). Toda escrita aninhada deve ser implementada explicitamente em `create()` e `update()` dentro de `with transaction.atomic():`.

## Conhecimento (`knowledge/`)
1. [`knowledge/serializer-architecture.md`](./knowledge/serializer-architecture.md): Camadas do Serializer e escolha da classe base.
2. [`knowledge/pipeline-and-lifecycle.md`](./knowledge/pipeline-and-lifecycle.md): Pipeline de validação (`is_valid`, `validated_data`) e representação (`to_representation`).
3. [`knowledge/fields-and-relations.md`](./knowledge/fields-and-relations.md): Campos primitivos, `read_only`, `write_only` e campos relacionais.
4. [`knowledge/validation.md`](./knowledge/validation.md): Validação em 3 níveis.
5. [`knowledge/nested-serializers.md`](./knowledge/nested-serializers.md): Escrita aninhada manual em `create()` e `update()`.
6. [`knowledge/performance.md`](./knowledge/performance.md): Prevenção de N+1 em Nested Serializers.
7. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão e proibições.

## Exemplos (`examples/`)
- [`examples/model-serializer.md`](./examples/model-serializer.md): `ModelSerializer` com campos explícitos.
- [`examples/plain-serializer.md`](./examples/plain-serializer.md): `Serializer` genérico (DTO) para serviços/RPC.
- [`examples/manual-nested-writable.md`](./examples/manual-nested-writable.md): Escrita aninhada manual com `transaction.atomic()`.

## Checklist
1. **Classe Base**: `ModelSerializer` para modelos Django e `Serializer` para DTOs/RPC?
2. **Tipos de Campos**: Usou campos específicos (`EmailField`, `UUIDField`, `DecimalField`) em vez de genéricos?
3. **Escrita Aninhada**: Gravou sub-itens manualmente dentro de `with transaction.atomic():` sem libs mágicas?
4. **Níveis de Validação**: Campo único em `validate_<field>`, multi-campo em `validate`, e regras de banco no Model?
