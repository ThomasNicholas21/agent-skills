---
name: create-project-execution-rule-workflow
description: >-
  Workflow para inspeção e detecção de comandos de execução do projeto (venv, docker, migrações, servidores,
  health checks), debate com o usuário e geração da regra .agents/rules/project-execution.md.
  Use sempre que o usuário invocar /create-project-execution-rule-workflow ou solicitar configuração de execução.
---

# Workflow: Criação e Customização da Regra de Execução (create-project-execution-rule-workflow)

Este workflow orienta a inspeção de um repositório, o alinhamento de comandos com o usuário e a geração/customização da regra `.agent/rules/project-execution.md` específica do projeto.

---

## 1. Inspeção e Detecção do Repositório

1. **Detectar Gerenciador de Pacotes e Venv**:
   - Inspecione a presença de `uv.lock`, `poetry.lock`, `Pipfile`, `pyproject.toml` ou `requirements.txt` usando `rtk find`.
2. **Detectar Serviços e Contêineres**:
   - Inspecione `docker-compose.yml` ou `Dockerfile` para identificar dependências de banco de dados (PostgreSQL, MySQL), cache (Redis) e brokers (RabbitMQ).
3. **Detectar Módulo de Configuração e Entrypoints**:
   - Localize `manage.py`, `wsgi.py`, `asgi.py` e o diretório de configurações (`config/settings/` ou `settings.py`).
4. **Detectar Endpoints de Health Check**:
   - Busque rotas de status/saúde (`/health/`, `/ping/`, `/api/v1/status/`) no `urls.py`.

---

## 2. Debate e Alinhamento com o Usuário

1. Apresente ao usuário os comandos de execução detectados:
   - Comando de ambiente e virtualenv (`uv run`, `poetry run`, `.venv`).
   - Comando de migração de banco (`manage.py migrate`).
   - Comando do servidor HTTP (`manage.py runserver 0.0.0.0:8000`).
   - Comando de contêineres Docker (`docker compose up -d`).
   - Comandos de workers/serviços adicionais (Celery, Daphne, Redis).
2. Debata e confirme com o usuário as portas, variáveis de ambiente exigidas (`.env`) e particularidades locais.

---

## 3. Geração da Regra `.agent/rules/project-execution.md`

Após a aprovação do usuário, crie ou atualize a regra `.agent/rules/project-execution.md` no projeto contendo:
- **Resolução de Ambiente**: Comandos exatos com o gerenciador de pacotes do projeto.
- **Checagem e Aplicação de Migrações**: Instruções passo a passo.
- **Subida de Servidores e Workers**: Comandos de dev server, Celery e Docker Compose.
- **Validação de Runtime e Smoke Test**: Endpoints de health check e comandos de inspeção sem polling.
