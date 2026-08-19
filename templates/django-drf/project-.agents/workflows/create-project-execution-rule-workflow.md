---
name: create-project-execution-rule-workflow
description: >-
  Detecta comandos de execução do projeto, valida com o usuário e cria .agents/rules/project-execution.md.
  Use para /create-project-execution-rule-workflow ou ao configurar comandos de runtime do projeto.
---

# Workflow de Execução do Projeto
Utilize para descobrir e documentar os comandos necessários para rodar o projeto localmente.

## 1. Analisar
Inspecione o repositório antes de propor comandos (usando RTK):
- Gerenciador de pacotes e ambiente (`uv`, `poetry`, `pip`, `.venv`).
- Entrypoints do projeto (`manage.py`, `wsgi.py`, `asgi.py`).
- Configurações de runtime (`.env.example`, `pyproject.toml`, `docker-compose.yml`, `Dockerfile`, `Makefile`).
- Infraestrutura (PostgreSQL, Redis, RabbitMQ, etc.).
- Workers e agendadores (Celery, etc.).
- Endpoints de health check e smoke tests.

Obtenha os comandos a partir do repositório. Não deduza comandos apenas por serem comuns no Django.
**Não modifique arquivos durante a análise.**

## 2. Validar com o Usuário
Apresente o fluxo detectado:
- **Ambiente**: Gerenciador de pacotes, virtualenv, variáveis necessárias.
- **Infraestrutura**: Docker, banco de dados, cache, mensageria.
- **Aplicação**: Instalação de dependências, migrations, servidor de desenvolvimento/ASGI/WSGI.
- **Workers**: Comandos de background workers (se houver).
- **Verificação**: Comandos de health check e testes rápidos.

Peça confirmação ao usuário antes de gerar o arquivo de regra.

## 3. Gerar a Regra
Após confirmação, crie ou atualize `.agents/rules/project-execution.md` contendo apenas comandos exatos e específicos do projeto:
- Comandos de ambiente e sincronização de dependências.
- Comandos de inicialização de infraestrutura e serviços.
- Comandos de migração e banco de dados.
- Comandos para iniciar a aplicação e workers.
- Comandos de verificação e validação de runtime.

## 4. Segurança & Escopo
- Nunca invente comandos e nunca exponha segredos de `.env`.
- Não assuma Docker ou Celery se o projeto não utilizar.
- Nunca execute comandos destrutivos sem aprovação explícita.
- Esta regra documenta **apenas execução do projeto** (não inclua regras de estilo, arquitetura ou testes gerais).