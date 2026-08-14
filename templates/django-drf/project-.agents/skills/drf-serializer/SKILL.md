---
name: drf-serializer
description: >-
  Especialista em arquitetura de Serializers e ModelSerializers no DRF, validação em 3 níveis,
  campos relacionais e escrita aninhada manual com transaction.atomic.
---

# DRF Serializer Skill

Esta habilidade orienta a construção de Serializers e ModelSerializers no Django REST Framework para validação, representação e escrita transacional de dados.

---

## Quando Ativar Esta Skill

Ative esta skill quando a tarefa envolver:
- Criar `ModelSerializer` para endpoints diretamente vinculados a modelos Django.
- Criar `serializers.Serializer` genéricos para payloads de serviços, comandos ou endpoints RPC.
- Configurar validações em 3 níveis (campos primitivos específicos, `validate_<field>` e `validate`).
- Implementar escrita aninhada manual (1:N ou N:N) nos métodos `create()` e `update()` usando `transaction.atomic()`.
- Mapear relacionamentos através de `PrimaryKeyRelatedField`, `SlugRelatedField` ou `Nested Serializer`.

---

## Regra Proibitiva

- É estritamente proibido utilizar bibliotecas terceiras de escrita aninhada (ex: `drf-writable-nested`). Toda escrita aninhada deve ser feita manualmente nos métodos `create()` e `update()` com `transaction.atomic()`.

---

## Índice de Conhecimento Profundo (`knowledge/`)

1. [`knowledge/serializer-architecture.md`](./knowledge/serializer-architecture.md): As 4 camadas do Serializer e comparativo de classes base.
2. [`knowledge/pipeline-and-lifecycle.md`](./knowledge/pipeline-and-lifecycle.md): Pipeline de entrada (`is_valid`, `validated_data`, `.save`), saída (`to_representation`) e `self.context`.
3. [`knowledge/fields-and-relations.md`](./knowledge/fields-and-relations.md): Campos primitivos, argumentos (`read_only`, `write_only`, `source`), `SerializerMethodField` e `PrimaryKeyRelatedField`.
4. [`knowledge/validation.md`](./knowledge/validation.md): Validação em 3 níveis (campo, `validate_<field>` e `validate`).
5. [`knowledge/nested-serializers.md`](./knowledge/nested-serializers.md): Escrita aninhada manual em `create()` e `update()` com `transaction.atomic()`.
6. [`knowledge/performance.md`](./knowledge/performance.md): Prevenção de N+1 em `Nested Serializers` via `select_related`/`prefetch_related`.
7. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão e regras estritas de proibição.

---

## Exemplos de Código (`examples/`)

- [`examples/model-serializer.md`](./examples/model-serializer.md): `ModelSerializer` com campos explícitos.
- [`examples/plain-serializer.md`](./examples/plain-serializer.md): `Serializer` genérico (DTO) para serviços/RPC.
- [`examples/manual-nested-writable.md`](./examples/manual-nested-writable.md): Escrita aninhada manual usando `transaction.atomic()`.

---

## Checklist de Implementação de Serializer

1. **Escolha da Classe Base**: Usou `ModelSerializer` para modelos Django e `serializers.Serializer` para serviços/RPC?
2. **Campos Específicos**: Utilizou `EmailField`, `UUIDField`, `DecimalField` em vez de `CharField` ou `FloatField` genéricos?
3. **Escrita Aninhada Manual**: Gravou sub-itens manualmente dentro de `with transaction.atomic():` sem usar libs mágicas?
4. **Validadores no Nível Correto**: Regras de 1 campo em `validate_<field>`, regras multi-campo em `validate`, e regras de banco no Model?
