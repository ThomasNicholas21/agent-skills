# Knowledge: Campos Primitivos, Argumentos e Relacionamentos em Serializers
## 1. Seleção de Campos Primitivos
Utilize sempre o tipo de campo mais específico possível fornecido pelo DRF:
| Tipo de Dado | Campo Recomendado | Regra do Agente |
| :--- | :--- | :--- |
| Email | `EmailField` | Não usar `CharField` para emails |
| UUID | `UUIDField` | Não usar `CharField` para UUIDs |
| URL | `URLField` | Não usar `CharField` para URLs |
| Valores Financeiros | `DecimalField(max_digits=10, decimal_places=2)` | **PROIBIDO** usar `FloatField` |
| Opções / Enums | `ChoiceField(choices=...)` | Não usar `CharField` para seleções fixas |
| Estruturas Dinâmicas | `DictField` ou `JSONField` | Usar `JSONField` apenas quando o schema for verdadeiramente dinâmico |

## 2. Argumentos Fundamentais dos Campos
- `read_only=True`: Campo presente na saída (output), ignorado na entrada (input). Usar para IDs, valores calculados e datas de auditoria.
- `write_only=True`: Campo aceito na entrada (input), omitido na saída (output). Usar para senhas, segredos e tokens.
- `required=True/False`: Define se a chave deve obrigatoriamente existir no JSON enviado.
- `allow_null=True`: Permite o valor `null` no JSON.
- `allow_blank=True`: Permite string vazia `""` (aplicável a campos de texto).
- `source`: Redireciona o campo para outro atributo ou navegação do objeto (ex: `source="user.email"`).
- `SerializerMethodField`: Campo somente de leitura cujo valor é gerado por um método `get_<field_name>(self, obj)`. Usar apenas para valores derivados/calculados na saída.

## 3. Campos de Relacionamento (`Relational Fields`)
Para representar relacionamentos entre entidades Django:
- `PrimaryKeyRelatedField`: Representa a relação apenas pelo ID da chave primária (ex: `{"user": 42}`). Padrão para escrita e payloads compactos.
- `SlugRelatedField`: Representa a relação através de um campo único legível (ex: `{"user": "joao_silva"}`).
- `HyperlinkedRelatedField`: Representa a relação por meio da URL absoluta do recurso (ex: `{"user": "https://api.domain.com/users/42/"}`).
- `StringRelatedField`: Representa a relação invocando `str(instance)`. Somente de leitura (`read_only=True`).
- `HyperlinkedIdentityField`: Representa a URL da própria entidade. Somente de leitura (`read_only=True`).