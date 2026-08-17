---
name: create-pr-workflow
description: >-
  Workflow para geração automatizada de descrição de Pull Request com base no histórico Git,
  rotas/endpoints mapeados e respostas OpenAPI/Swagger, formatado estritamente conforme o gabarito
  pull_request_template.md com limite de 1500 caracteres. Use sempre que o usuário invocar /create-pr-workflow ou /create-pr.
---

# Workflow: Geração de Pull Request (create-pr-workflow)

Este workflow analisa o histórico de alterações no Git, mapeia novos e modificados endpoints, extrai as respostas de erro do Swagger OpenAPI e formata a descrição do PR baseada no gabarito `.github/pull_request_template.md`.

---

## 1. Varredura do Git e Mapeamento de Alterações

1. **Inspeção de Status e Diffs**:
   - Execute `rtk git status --short` e `rtk git diff --stat` para listar os arquivos modificados.
   - Execute `rtk git log -n 5 --oneline` para contextualizar as últimas alterações.
2. **Mapeamento de Endpoints e Rotas**:
   - Identifique novos endpoints criados e endpoints existentes modificados (`urls.py`, `views.py`, `viewsets.py`, `serializers.py`).
   - Mapeie o uso do Swagger OpenAPI (`schemas.py`, `@extend_schema_view`, `@extend_schema`) para identificar contratos de resposta e códigos de erro (`400`, `401`, `403`, `404`, `409`).
3. **Mapeamento de Testes**:
   - Inspecione a suíte de testes executada (`apps/<app>/tests/`).

---

## 2. Leitura do Gabarito de PR (`pull_request_template.md`)

1. Leia o gabarito `.github/pull_request_template.md` do repositório (ex: `z:/home/thomas/projects/work/revisa-mais-backend/.github/pull_request_template.md`).
2. Mantenha obrigatoriamente a estrutura das 4 seções do gabarito:
   - `## [Contexto]`
   - `## [Descrição]`
   - `## [Tipo]`
   - `## [Testes]`

---

## 3. Regras de Formatação e Limite de Caracteres

- **Limite de Tamanho**: Toda a descrição do PR DEVE ser concisa, de alto sinal e mantida estritamente **abaixo de 1500 caracteres**.
- **Seção `## [Descrição]`**:
  - Liste cada endpoint criado ou modificado no formato: `VERBO /rota/ - Usabilidade/Objetivo`.
  - Faça referência ao Swagger OpenAPI para detalhamento de respostas de erro (ex: *"Respostas e validações de erro (400, 401, 403, 404) estão documentadas via Swagger OpenAPI/Spectacular"*).
- **Seção `## [Tipo]`**: Marque com `[x]` o tipo da alteração (`Bug fix`, `New feature`, `Refactoring`, `Documentação`).
- **Seção `## [Testes]`**: Resuma brevemente os comandos de testes executados (`rtk pytest`) e resultados obtidos.

---

## 4. Disponibilização ao Usuário

1. Apresente o texto final do PR formatado na resposta para o usuário.
2. Salve o conteúdo gerado no arquivo `scratch/pr_description.md` para facilitar o uso no GitHub.
