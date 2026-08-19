---
name: update-agents
description: >-
  Executa calibração de regras (.agents/rules/), skills e convenções ao importar templates
  para novos projetos ou projetos existentes. Acione com /update-agents ou /update-agents-workflow.
---

# Update Agents Onboarding Skill
Guia o agente na calibração de regras e habilidades em projetos que utilizam a pasta `.agents`.

## Procedimento de Execução

1. **Detecção do Repositório**:
   - Inspecione arquivos de configuração (`manage.py`, `pyproject.toml`, `settings.py`) com `rtk find` e `rtk read`.
   - Identifique se o projeto é novo ou existente com convenções já estabelecidas.

2. **Varredura de Padrões (Codebase)**:
   - Inspecione a presença de `services.py`, formato de ViewSets/Serializers, tipagem (mypy), docstrings e suíte de testes.

3. **Alinhamento com o Usuário**:
   - Apresente os padrões detectados e confirme a estratégia de calibração (baseada no repositório, entrevista ou híbrida).

4. **Geração & Adaptação de Regras**:
   - Utilize a `skill-creator` para gerar/atualizar regras em `.agents/rules/*.md`.

5. **Validação**:
   - Valide gatilhos `trigger: glob:` e apresente o resumo final das regras formalizadas.