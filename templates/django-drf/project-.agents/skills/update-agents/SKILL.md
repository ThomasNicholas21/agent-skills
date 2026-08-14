---
name: update-agents
description: >-
  Executa rotina interativa de onboarding e calibração de regras (.agents/rules/), skills e workflows
  ao importar templates de agentes para novos repositórios. Suporta modo de engenharia reversa para
  projetos existentes (analisando o projeto inteiro) ou entrevista interativa estilo grill-me. Use sempre
  que o usuário solicitar /update-agents ou /update-agents-workflow.
---

# Update Agents Onboarding Skill

Esta skill guia o agente na calibração interativa e determinística das regras e habilidades em projetos que acabaram de importar ou atualizar a pasta `.agents`.

---

## Procedimento de Execução

Ao ser ativado, o agente deve seguir o fluxo:

1. **Reconhecimento & Detecção de Código Existente**:
   - Execute `rtk find "*"` e inspecione arquivos de configuração (`manage.py`, `pyproject.toml`, `package.json`, etc.).
   - Se o projeto for existente, ofereça a opção de **Análise Total do Codebase** para extrair as convenções já praticadas.

2. **Varredura Completa do Codebase (Projetos Existentes)**:
   - Inspecione múltiplos apps/módulos para mapear a presença de `services.py`, formato de ViewSets, separação de Serializers, tipagem (mypy), docstrings e suíte de testes.

3. **Entrevista Interativa (Grill-Me) / Confirmação**:
   - Conduza a entrevista ou confirme com o usuário os padrões detectados antes de prosseguir.

4. **Invocação da `skill-creator`**:
   - Utilize as diretrizes da `skill-creator` (`.agents/skills/skill-creator/SKILL.md`) para gerar ou adaptar os arquivos em `.agents/rules/*.md`.

5. **Auditoria & Validação**:
   - Valide gatilhos `trigger: glob:` e apresente o resumo final das convenções formalizadas.
