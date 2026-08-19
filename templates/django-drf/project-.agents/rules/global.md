---
trigger: always_on
---

# Regras Globais do Repositório
Estas regras se aplicam a todas as interações com o repositório.

## 1. Analisar Antes de Planejar
Antes de propor ou implementar uma solução:
1. Analise o pedido, o código existente, a arquitetura e o contexto do projeto.
2. Busque no repositório antes de criar novos códigos, abstrações, utilitários ou padrões.
3. Consulte o Second Brain quando arquitetura, regras de negócio ou decisões anteriores forem aplicáveis.
4. Identifique ambiguidades, restrições, riscos e alternativas viáveis.
5. Se a solução envolver decisões arquiteturais, comportamentais ou não triviais, discuta as alternativas com o usuário ANTES de criar o plano de implementação.
6. Não escolha silenciosamente entre soluções materialmente distintas.
7. Não inicie a implementação até que a abordagem esteja acordada com o usuário.

## 2. Escopo & Simplicidade
- Implemente apenas o estritamente necessário para atender à solicitação.
- Prefira a solução mais simples alinhada à arquitetura existente.
- Não adicione abstrações, parâmetros, recursos ou infraestruturas especulativas.
- Reutilize código e padrões existentes antes de criar novos.
- Evite refatorações, limpezas, formatações ou renomeações fora do escopo.
- Nunca modifique arquivos fora do escopo obrigatório.
Aplique KISS, YAGNI e DRY pragmaticamente.

## 3. Terminal
- Use comandos RTK sempre que houver suporte: `rtk read`, `rtk grep`, `rtk find`, `rtk git`, `rtk pytest`, `rtk ruff`, etc.
- Use comandos nativos do shell apenas quando o RTK não puder executar a operação.
- Prefira comandos que minimizem saída e consumo de contexto.

## 4. Padrões de Código
- Código, variáveis, classes, funções e identificadores DEVEM ser em inglês.
- NÃO adicione docstrings a menos que explicitamente solicitado.
- NÃO adicione type hints a menos que explicitamente solicitado.
- Siga a formatação e convenções existentes no repositório.
- Nunca silencie exceções com blocos `except` vazios.
- Variáveis devem ser explícitas e não abreviadas.

## 5. Variáveis de Ambiente
Não adivinhe variáveis de ambiente, caminhos ou locais do cofre.
Use:
- `$OBSIDIAN_VAULT_PATH` → Raiz do Second Brain Vault ( use only if asked ).
- `$AGENT_SKILLS_DIR` → Hub de regras/skills do repositório ( use only if asked ).
- `$DAILIES_DIR` → Raiz de Dailies ( use only if asked ).
- `$DOC_DIR` → Raiz de Documentação ( use only if asked ).

## 6. Verificação
Antes e depois de alterações:
- Inspecione o estado do Git com RTK.
- Verifique se apenas os arquivos pretendidos foram alterados.
- Execute os testes e linters relevantes quando aplicável.
- Não declare conclusão sem verificar o resultado.

## 7. Second Brain
Quando contexto histórico, arquitetura, regras de negócio ou decisões anteriores importarem:
- Busque no Second Brain antes de decidir.
- Siga as decisões documentadas existentes.
- Não crie arquitetura conflitante.
- Persista novas decisões arquiteturais importantes quando apropriado.