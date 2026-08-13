# Framework de Avaliação de Soluções e Tomada de Decisão Arquitetural

Este guia orienta o raciocínio do `solution-architect` na formulação e comparação de abordagens técnicas.

---

## 1. Critérios Universais de Avaliação

Ao comparar soluções para um problema, utilize a seguinte matriz de trade-offs:

| Critério | Perguntas de Avaliação |
|---|---|
| **Simplicidade (KISS/YAGNI)** | A solução é a mais simples que resolve o problema real sem abstrações prematuras? |
| **Manutenibilidade & SOLID** | O código resultante é fácil de alterar, testar e estender por outros desenvolvedores? |
| **Desempenho & Recursos** | A abordagem evita gargalos (como N+1 queries, vazamento de memória ou bloqueio de threads)? |
| **Testabilidade** | É possível testar as regras de negócio de forma determinística e isolada (unitária/integração)? |
| **Alinhamento com o Repositório** | Respeita as convenções de `.agents/rules/*.md` e a arquitetura existente do projeto? |

---

## 2. Modelo de Apresentação de Solução (Template)

```markdown
### 💡 Abordagem 1: [Nome da Solução]

#### Descrição
Breve explicação de como a solução funciona.

#### Prós e Contras
- 🟢 **Vantagens**:
  - Ganhos de desacoplamento e clareza de testes.
- 🔴 **Desvantagens**:
  - Requer a criação de 2 novos arquivos (`services.py`, `serializers.py`).

#### Boas Práticas Envolvidas
- Aplicação do padrão **Service Layer** ([pattern-service-layer]) e **Clean Architecture**.

#### Como Implementar
- **Arquivo a Modificar**: `app/api/views.py`
- **Arquivo a Criar**: `app/services.py`
```

---

## 3. Registro no Obsidian Second Brain (ADRs)

Toda decisão arquitetural acordada com o usuário deve ser gravada na nota do projeto em `$OBSIDIAN_VAULT_PATH/Projects/<Projeto>.md` na seção `## Key Decisions` ou como nota individual de decisão (ADR) em `Knowledge/`.
