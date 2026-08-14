# Knowledge: Pirâmide de Testes e Responsabilidade por Camada no Django/DRF

---

## 1. Pirâmide de Testes no Django & DRF

A distribuição de testes em um projeto Django + DRF deve respeitar a pirâmide de testes:

```text
       / \          End-to-End (E2E) ──> Poucos testes, lentos, fluxo completo
      /   \         Integration / ViewSet ──> HTTP status, autenticação, rotas
     /     \        Serializer / Service ──> Transformação, regras de negócio
    /_______\       Model / Validation / Utils ──> Base da pirâmide, rápida, determinística
```

---

## 2. Responsabilidades de Teste por Camada

| Camada | O que Testar | Exige Banco? | Exige HTTP? |
| :--- | :--- | :--- | :--- |
| **Validation / Utils** | Funções puras, sanitização, regras sintáticas | Não | Não |
| **Service** | Regras de negócio, cálculos, orquestração de domínio | Depende | Não |
| **Model / QuerySet** | Constraints do banco, métodos do model, managers, `select_related` | Sim | Não |
| **Serializer** | Parsing de entrada, validações de 3 níveis, representação de saída | Geralmente Sim | Não |
| **ViewSet / API** | Status HTTP (`200`, `201`, `400`, `401`, `403`, `404`), permissões, headers, contratos de resposta | Geralmente Sim | Sim |
| **Integration** | Interação real entre múltiplos componentes (API ──> Service ──> DB) | Sim | Sim |

---

## 3. Diretriz de Separação de Testes

> **Regra de Ouro**: Teste cada camada estritamente em sua responsabilidade. NUNCA crie testes de ViewSet HTTP para validar regras de negócio complexas que pertencem à camada de Service. NUNCA acesse o banco de dados em testes de utilitários que não necessitam de persistência.
