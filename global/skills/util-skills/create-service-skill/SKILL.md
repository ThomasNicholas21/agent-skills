---
name: create-service-skill
description: >
  Meta-Habilidade para Criação Automática de Skills de Serviço (Service Skill Generator).
  Recebe uma solicitação ou prompt do usuário (ex: "crie uma skill para consumo do serviço AWS S3" ou "skill para gateway de pagamento Stripe")
  e gera a estrutura completa da nova habilidade com YAML frontmatter, variáveis de ambiente necessárias,
  instruções procedimentais, tratamento de exceções e snippets executáveis.
metadata:
  category: meta
---

# Meta-Skill: Create Service Skill (Gerador de Skills de Serviço)

Esta meta-habilidade capacita o agente local ou global a criar novas habilidades (*skills*) de integração de serviços de forma automatizada e padronizada.

---

## Fluxo de Geração de uma Skill de Serviço

Ao receber uma requisição do tipo *"Crie uma skill para utilizar o serviço X"*:

### 1. Extração de Requisitos
- **Nome da Skill**: slug curto em minúsculas (ex: `service-s3-storage`, `service-stripe-payment`).
- **Escopo**: Identificar se a skill será local (`.agents/skills/<nome>/SKILL.md`) ou global (`global/skills/<nome>/SKILL.md`).
- **Variáveis de Ambiente**: Mapear secrets exigidos (ex: `AWS_ACCESS_KEY_ID`, `STRIPE_SECRET_KEY`).
- **Casos de Uso**: Listar ações operacionais primárias (ex: upload, download, cancelamento, webhook).

### 2. Estrutura Padrão Gerada (`SKILL.md`)

```markdown
---
name: <slug-da-skill>
description: >
  Habilidade operacional para integração e manipulação do serviço <Nome do Serviço>.
  Fornece diretrizes de configuração, variáveis de ambiente, idempotência, tratamento de exceções e exemplos de uso.
metadata:
  category: service-integration
---

# Skill: Integrador <Nome do Serviço>

Esta habilidade orienta a implementação e consumo do serviço **<Nome do Serviço>** no projeto.

---

## 1. Variáveis de Ambiente Exigidas

Antes de utilizar a integração, certifique-se de que as variáveis abaixo estão configuradas no ambiente local (`.env`) ou no container:

```bash
<SERVICO>_API_KEY=your_key_here
<SERVICO>_SECRET=your_secret_here
```

---

## 2. Padrão de Integração na Service Layer

Todas as chamadas para o serviço DEVEM ser encapsuladas em uma classe de serviço no arquivo `services.py` (ou módulo equivalente), NUNCA diretamente em views ou controllers:

```python
import logging
from django.conf import settings

logger = logging.getLogger(__name__)

class ServiceClient:

    @classmethod
    def execute_action(cls, payload: dict) -> dict:
        try:
            # Lógica da integração
            ...
        except Exception as e:
            logger.error(f"Erro ao comunicar com serviço: {e}")
            raise
```

---

## 3. Diretrizes de Resiliência e Tratameno de Erros
- Implementar timeout explícito em chamadas HTTP (máximo 5s).
- Tratar retries exponenciais para erros temporários (códigos 5xx ou timeout).
- Registrar logs estruturados sem expor tokens ou dados sensíveis.
```

### 3. Escrita do Arquivo
- Salvar o arquivo `SKILL.md` no diretório de destino correspondente.
- Notificar o usuário com o caminho do arquivo gerado e orientações de uso.
