---
name: create-pr-workflow
description: >-
  Gera descrição concisa de Pull Request a partir de alterações do Git, endpoints afetados,
  regras de validação, testes e documentação OpenAPI. Mantém a descrição estritamente abaixo de 1500 caracteres.
---

# Workflow de Criação de PR
Utilize para `/create-pr-workflow` ou `/create-pr`.

## 1. Analisar Alterações
Inspecione o estado real do repositório antes de escrever o PR:
- Execute `rtk git status --short`.
- Execute `rtk git diff --stat`.
- Inspecione o diff relevante.
- Execute `rtk git log -n 5 --oneline` para contexto.
- Leia `.github/pull_request_template.md` (se existir).
Não deduza alterações da memória.

## 2. Mapear Endpoints
Identifique **todos os endpoints criados ou modificados**:
- Método HTTP e rota completa (`METHOD /rota/ - Objetivo`).
- Objetivo e regras de validação/negócio relevantes.
- Autenticação, permissões e códigos de resposta esperados.
- Testes relacionados.
Não liste endpoints não relacionados nem invente rotas.

## 3. OpenAPI / Swagger & Testes
- Inspecione decorators e schemas OpenAPI para identificar contratos e validações.
- Mencione validações importantes no PR e aponte para o Swagger/OpenAPI para o contrato completo.
- Se testes foram executados, reporte o comando e o resultado real (nunca afirme que passaram sem executar).

## 4. Gerar Descrição do PR
Preserve a estrutura de `.github/pull_request_template.md` quando existir.
A descrição final DEVE:
- Ter **estritamente menos de 1500 caracteres**.
- Listar **todos os endpoints afetados** no formato `METHOD /rota/ - Objetivo`.
- Mencionar validações e regras de negócio essenciais.
- Resumir testes relevantes e resultados reais.
- Priorizar informações de alto sinal e evitar detalhes óbvios de implementação.

## 5. Validação
Antes de apresentar ao usuário:
1. Conte os caracteres finais.
2. Se `>= 1500`, resuma e conte novamente.
3. Garanta que a descrição final tenha `< 1500 caracteres`.
4. Apresente o resultado final no chat.