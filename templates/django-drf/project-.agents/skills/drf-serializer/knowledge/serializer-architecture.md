# Knowledge: Arquitetura de Serializers no DRF e Escolha da Classe Base
## 1. As Quatro Camadas do Serializer
Um `Serializer` no Django REST Framework opera em quatro camadas bem definidas:
```text
Serializer
  ├── Camada de Entrada  ──> parsing → Python primitives → validation → validated_data
  ├── Camada de Saída    ──> instance → to_representation → dict → JSON
  ├── Camada de Persistência ──> .save() → create() / update()
  └── Camada de Relações ──> Primary Key / Slug / Hyperlinked / Nested Serializers
```

## 2. Comparativo de Classes Base de Serializer
| Classe Base | Finalidade | Responsabilidade do Agente |
| :--- | :--- | :--- |
| `serializers.ModelSerializer` | Entidades baseadas em Django Models | Usar quando a estrutura da API corresponde diretamente a um modelo Django. Gera automaticamente campos, validadores e `.create()`/`.update()` padrão. |
| `serializers.Serializer` | DTOs de Serviço / RPC / Payloads Genéricos | Usar quando a estrutura da API NÃO corresponde diretamente a um único modelo, para comandos de serviço, agregados ou DTOs customizados. |
| `serializers.HyperlinkedModelSerializer` | Entidades com navegação por URLs | Variante do `ModelSerializer` que representa identidades e relações por hyperlinks (exige `request` no contexto). |
| `serializers.BaseSerializer` | Serialização de Baixo Nível | Usar somente quando `Serializer` ou `ModelSerializer` não fornecerem o controle necessário. Evitar uso desnecessário. |

## 3. Separação Estrita de Responsabilidades
- **Serializer DEVE**:
  - Validar dados de entrada e transformá-los em `validated_data`.
  - Transformar instâncias e objetos Python em dicionários de representação de saída.
  - Coordenar a persistência simples e mapear o contrato da API.
- **Serializer NÃO DEVE**:
  - Conter regras de negócio complexas (delegar para Service/Domain).
  - Fazer chamadas de rede externas.
  - Executar consultas arbitrárias ao banco para montar respostas (delegar para `get_queryset()` da View).
  - Tratar requisições HTTP diretamente ou retornar `Response`.