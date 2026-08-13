---
name: solution-architect
description: >-
  Analisa problemas técnicos e arquiteturais consultando o Obsidian Second Brain e o código do repositório.
  Formula 2 a 3 soluções estruturadas com vantagens, desvantagens, boas práticas e plano de implementação,
  conduzindo um debate para a escolha da melhor abordagem.
metadata:
  category: architecture
  pattern-type: consultant
---

# Skill: Solution Architect & Problem Solver

Esta habilidade atua como um **Arquiteto de Soluções Principal e Consultor Técnico**. Diante de qualquer problema, desafio de engenharia ou necessidade de funcionalidade, ela analisa o repositório ativo via RTK e o histórico do **Obsidian Second Brain**, gerando de 2 a 3 abordagens distintas de solução com análise rigorosa de vantagens, desvantagens, boas práticas e passos de implementação.

---

## ⚙️ Resolução Mandatória de Caminhos & Variáveis de Ambiente

Ao iniciar a análise de um problema, o agente DEVE consultar as variáveis de ambiente parametrizadas (`.env.example`):

| Variável de Ambiente | Caminho Resolvido | Descrição e Finalidade |
|---|---|---|
| `$OBSIDIAN_VAULT_PATH` | `/mnt/c/Users/thoma/Meus Documentos/obsidian-second-brain-vault` | Raiz oficial do cofre central do Obsidian Second Brain. |
| `$OBSIDIAN_VAULT_DIR` / `$SECOND_BRAIN_DIR` | `/mnt/c/Users/thoma/Meus Documentos/obsidian-second-brain-vault` | Aliases da raiz do cofre Obsidian. |
| `$AGENT_SKILLS_DIR` | `/home/thomas/projects/agent-skills` | Raiz do repositório hub de código, regras e skills. |
| `$DOC_DIR` | `$AGENT_SKILLS_DIR/docs` | Base de conhecimento e catálogos (`design-patterns/INDEX.md`). |

---

## 🔍 Fluxo de Trabalho em 5 Etapas

### 1. Inspeção de Contexto (Git + Vault + RTK)
- **Inspeção do Repositório (RTK)**: Executar `rtk find`, `rtk grep` e `rtk read` para mapear os arquivos afetados, stack tecnológica e padrões atuais.
- **Consulta ao Second Brain**: Pesquisar a nota mestre do projeto (`Projects/<Projeto>.md`), regras do cofre (`_CLAUDE.md`), decisões passadas (`Knowledge/`, `ADRs`) e aprendizados históricos.

### 2. Formulação de 2 a 3 Abordagens de Solução
Apresentar opções de design contrastantes (ex: Abordagem Mínima/Direta vs Abordagem Desacoplada com Service/Repository vs Abordagem Assíncrona/Event-Driven).

### 3. Matriz Comparativa de Vantagens e Desvantagens
Para **CADA** solução proposta, detalhar obrigatoriamente:
- 🟢 **Vantagens (Pros)**: Ganhos em manutenção, desacoplamento, performance, facilidade de teste ou velocidade de entrega.
- 🔴 **Desvantagens (Cons)**: Complexidade adicional, acoplamento, esforço de migração ou potencial de sobre-engenharia.
- 🛡️ **Conformidade com Boas Práticas**: Aplicação de SOLID, Clean Architecture, GoF/Service Patterns, prevenção de N+1 e princípios DRY.
- 🛠️ **Plano de Implementação (Como Fazer)**: Estrutura de arquivos a criar/modificar e trechos de código (Antes vs Depois).

### 4. Recomendação Fundamentada & Debate com Usuário
- Indicar qual das opções é a **recomendada como melhor prática** para a realidade atual do projeto.
- Convidar o usuário para debater e aprovar a abordagem preferida (*Plan-Before-Execute Gate*).

### 5. Registro da Decisão no Second Brain
Após a aprovação da abordagem pelo usuário, registrar a solução como uma decisão técnica (ADR) em `$OBSIDIAN_VAULT_PATH/Knowledge/` ou na nota do projeto via `/obsidian-decide` ou `/save-project-brain`.

---

## 📚 Referências e Frameworks de Avaliação

- [Matriz de Decisão Arquitetural e Critérios de Escolha](./references/solution-framework.md)
