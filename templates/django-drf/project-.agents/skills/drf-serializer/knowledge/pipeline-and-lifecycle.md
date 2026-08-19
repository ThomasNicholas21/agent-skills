# Knowledge: Pipeline e Ciclo de Vida do Serializer

## 1. Pipeline de Entrada (Desserialização & Validação)
```text
request.data → Serializer(data=...) → .is_valid()
  ├── Field.to_internal_value()    → Converte tipos primitivos
  ├── Field Validators             → Regras de campo declarativas
  ├── validate_<field_name>(value) → Validação de campo único
  └── validate(attrs)              → Validação cruzada multi-campo
  → .validated_data                → Dados aprovados para .save() / create() / update()
```

## 2. Pipeline de Saída (Serialização)
```text
instance → Serializer(instance) → .data
  ├── to_representation(instance)  → Mapeia objeto para dict Python
  ├── SerializerMethodField        → Executa get_<field>(self, obj)
  └── JSONRenderer                 → Renderiza dict como JSON response
```

## 3. Contexto (`self.context`)
Passe `request` e dados contextuais via `context={"request": request}` para acessar `self.context["request"].user` dentro do serializer.