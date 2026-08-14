---
trigger: always_on
---

# Regras de Execução do Projeto (Project Execution)

Esta regra orienta a inicialização, execução do servidor de desenvolvimento, aplicação de migrações e validação de runtime no repositório.

---

## 1. Resolução do Ambiente e Gerenciador de Pacotes

Antes de executar qualquer comando de execução no repositório:
1. **Identifique o Gerenciador de Dependências**:
   - `uv`: Utilize `uv run python manage.py ...` (Preferencial se `uv.lock` existir).
   - `poetry`: Utilize `poetry run python manage.py ...`.
   - `pipenv`: Utilize `pipenv run python manage.py ...`.
   - `virtualenv`: Ative o ambiente em `.venv/` ou `venv/` antes de rodar comandos `python`.

2. **Variáveis de Ambiente (`.env`)**:
   - Garanta que o arquivo `.env` existe (copie de `.env.example` se necessário).
   - Nunca execute servidores ou comandos com credenciais de produção no ambiente local.

---

## 2. Aplicação de Migrações e Validação de Banco

Antes de subir o servidor de desenvolvimento ou rodar a suíte de testes:
- **Verificar Migrações Pendentes**: Execute `python manage.py migrate --check` ou `python manage.py showmigrations`.
- **Aplicar Migrações**: Execute `python manage.py migrate` quando houver migrações pendentes.
- **Checagem de Schema**: Execute `python manage.py makemigrations --check --dry-run` para garantir que os modelos não possuem alterações pendentes de migração.

---

## 3. Execução do Servidor de Desenvolvimento e Serviços

1. **Servidor HTTP Django**:
   - Execute o servidor local via `python manage.py runserver 0.0.0.0:8000`.
   - Para processos em segundo plano (dev servers), utilize a ferramenta `run_command` com `IsDaemon=true` ou `WaitMsBeforeAsync=2000`.
2. **Serviços de Segundo Plano (Workers / Cache / WebSockets)**:
   - **Redis / Database**: Verifique se os contêineres Docker estão ativos via `docker compose ps` ou suba os serviços via `docker compose up -d redis db`.
   - **Celery Worker**: Suba via `celery -A config worker -l info`.
   - **Channels / ASGI**: Suba via `daphne -b 0.0.0.0 -p 8000 config.asgi:application`.

---

## 4. Validação de Runtime (Health Check & Smoke Test)

Após subir o servidor ou serviços:
1. **Inspeção de Logs**: Verifique se o processo iniciou limpo sem exceções na inicialização.
2. **Smoke Test HTTP**: Teste o endpoint de checagem (`/health/` ou `http://localhost:8000/`) usando `read_url_content` ou `curl` via RTK para confirmar status `200 OK`.
3. **Não Fazer Polling Infinito**: Nunca execute loops de `sleep` no terminal. Utilize os mecanismos de notificação do sistema ou timer de background.
