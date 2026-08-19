---
name: save-project-brain
description: >
  Sincroniza o contexto persistente completo de um projeto com o Second Brain.
  Use ao salvar, atualizar ou reconstruir o conhecimento do projeto a partir
  do repositório, documentação, histórico do Git e contexto existente no Vault.
---

# Salvar Project Brain
Mantenha o **modelo completo de conhecimento do projeto**, não apenas as
alterações recentes.
O template do projeto define o schema. Toda seção relevante deve ser
auditada e preenchida sempre que sua informação puder ser determinada.
O gateway `second-brain` é responsável pelas regras de persistência,
propagação, indexação, logging e validação.
Esta skill é responsável pela **descoberta do projeto e pela completude
das informações**.

## 1. Inspecionar
Identifique o projeto e inspecione o repositório real.
Revise, conforme relevante:
- estrutura do repositório;
- código-fonte;
- arquitetura;
- dependências;
- configurações;
- requisitos de ambiente;
- banco de dados/schema;
- APIs e integrações;
- autenticação e autorização;
- tarefas em background;
- testes;
- deploy;
- Docker/CI;
- histórico do Git e alterações atuais;
- documentação;
- notas existentes do projeto;
- conhecimento relacionado no Vault.
Não dependa da memória da conversa quando houver evidências disponíveis
no repositório.

## 2. Auditar o Template
Leia a estrutura real do template/nota do projeto.
Para **cada seção**, determine seu estado:

```text
KNOWN    → preencher/atualizar
STALE    → atualizar
MISSING  → pesquisar/determinar
UNKNOWN  → marcar como TBD