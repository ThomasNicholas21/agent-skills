---
name: test-scenario-builder
description: Estrutura casos de teste funcionais e de integração para Backend (payloads JSON, status HTTP e validação de schema) e Frontend (fluxo de UI, validações de formulário e respostas esperadas).
---

# Test Scenario Builder — Gerador de Casos de Teste Funcionais

## Objetivo

Gerar especificações e implementações de casos de teste ponta a ponta (Backend + Frontend) cobrindo tanto o caminho feliz (*Happy Path*) quanto casos de borda e validação de erros (*Edge Cases & Form Validation*).

---

## 1. Estrutura do Caso de Teste Backend (API / Endpoints)

Para cada endpoint ou funcionalidade, gerar os conjuntos de dados (payloads) e asserções:

### A. Caso 1: Caminho Feliz (Cadastro/Execução Completa)
* **Payload HTTP**: JSON com todos os campos obrigatórios e opcionais válidos.
* **Status HTTP Esperado**: `201 Created` ou `200 OK`.
* **Asserções de Resposta**:
  - Schema de retorno correto (ID gerado, timestamps, dados formatados).
  - Sem vazamento de dados sensíveis (ex: senhas hash não retornadas).
  - Persistência no banco confirmada.

### B. Caso 2: Validação de Campo / Dado Invalido (Ex: Telefone Errado)
* **Payload HTTP**: JSON com o campo alvo inválido (ex: `phone: "123"` ou `phone: "abc"`).
* **Status HTTP Esperado**: `400 Bad Request` ou `422 Unprocessable Entity`.
* **Asserções de Resposta**:
  - Estrutura de erro amigável (ex: `{"phone": ["Formato de telefone inválido."]}`).
  - Garantia de que NENHUM dado foi salvo no banco (Rollback da transação).

---

## 2. Estrutura do Caso de Teste Frontend (Formulários & Componentes UI)

Para a interface visual e integração com API:

### A. Caso 1: Fluxo de Sucesso no Formulário
* **Ações do Usuário**:
  1. Preencher todos os campos do formulário com dados válidos.
  2. Clicar no botão "Cadastrar" / "Enviar".
* **Asserções Esperadas na UI**:
  - Exibição de indicador de carregamento (*Loading spinner/button* disabled).
  - Exibição de notificação de sucesso (*Toast/Banner*).
  - Redirecionamento correto ou limpeza do formulário.

### B. Caso 2: Validação de Erro na Interface (Ex: Telefone Errado)
* **Ações do Usuário**:
  1. Preencher o campo de telefone com formato incorreto (ex: `123`).
  2. Tentar submeter ou desfocar o campo (*blur*).
* **Asserções Esperadas na UI**:
  - Exibição de mensagem de erro em linha abaixo do campo (*Inline Error Message*: "Telefone deve conter DDD e 9 dígitos").
  - Botão de envio desabilitado ou requisição bloqueada antes de chamar o backend.
  - Se a API retornar `400 Bad Request`, tratamento gracioso na UI exibindo o erro vindo do servidor.

---

## 3. Matriz de Cobertura de Testes (Checklist)

Ao montar a suíte de testes, sempre gerar:

| Categoria | Backend (Pytest / Jest / API) | Frontend (React Testing Library / Cypress / Vitest) |
| :--- | :--- | :--- |
| **Caso Feliz** | Payload 100% válido -> Status `201` + JSON | Preenchimento completo -> Toast de Sucesso |
| **Dado Invalido** | Payload com formato errado -> Status `400` | Input inválido -> Mensagem de erro em linha |
| **Campos Ausentes** | Payload sem campo obrigatório -> Status `400` | Tentar enviar vazio -> Alerta de campo obrigatório |
| **Autenticação** | Token ausente/expirado -> Status `401`/`403` | Sessão expirada -> Redirecionamento para Login |
