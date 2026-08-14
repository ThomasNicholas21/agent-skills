# Knowledge: Pipeline de Entrada, Saída e Ciclo de Vida do Serializer

---

## 1. Pipeline de Entrada (Desserialização & Validação)

Ao processar dados enviados pelo cliente (`request.data`), o fluxo interno do Serializer segue esta ordem:

```text
request.data
   │
   ▼
Serializer(data=...)
   │
   ▼
.is_valid()
   ├── Field.to_internal_value() ──> Converte tipos primitivos para objetos Python
   ├── Field Validators           ──> Executa regras declarativas de campo (ex: max_length, validators)
   ├── validate_<field_name>()    ──> Validação customizada de campo único
   └── validate(attrs)            ──> Validação cruzada entre múltiplos campos
   │
   ▼
.validated_data                   ──> Dados aprovados prontos para consumo
   │
   ▼
.save()
   ├── instance é None  ──> create(validated_data)
   └── instance existe ──> update(instance, validated_data)
```

### Regras do Pipeline de Entrada
- NUNCA acesse `.validated_data` antes de chamar `.is_valid()`.
- NUNCA salve dados não validados através do Serializer.
- Ao chamar `.save()`, o DRF decide automaticamente se invocará `create()` ou `update()` com base na presença de `instance`.

---

## 2. Pipeline de Saída (Serialização & Representação)

Ao converter uma instância do modelo ou objeto Python em JSON:

```text
Model Instance / Python Object
   │
   ▼
to_representation(instance) ──> Converte objeto em dict com valores primitivos
   │
   ▼
dict
   │
   ▼
DRF Renderer ──> JSON
```

### Regras do Pipeline de Saída
- `to_representation()` deve ser utilizado **exclusivamente** para customizar a representação visual de saída.
- NUNCA utilize `to_representation()` para efetuar validação de `request.data` ou persistência no banco.

---

## 3. Uso do Atributo `self.context`

Os serializers recebem contexto externo através do argumento `context`:

```python
serializer = UserSerializer(data=request.data, context={"request": request, "view": self})
```

- Acessível dentro do Serializer via `self.context`.
- Deve ser utilizado quando o Serializer precisa de informações externas ao objeto serializado (ex: `self.context['request'].user`).
- Evite acessar globais diretamente dentro do Serializer.
