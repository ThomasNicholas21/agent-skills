# Instruções do Agente
## Analise Antes do Plano
Antes de implementar:
1. Compreenda o requisito e inspecione o código relevante.
2. Pesquise o repositório antes de criar novos códigos ou abstrações.
3. Consulte o Second Brain quando arquitetura, regras de negócio ou decisões anteriores puderem ser relevantes.
4. Identifique restrições, riscos, ambiguidades e abordagens viáveis.
5. Para decisões arquiteturais ou comportamentais não triviais, discuta as alternativas com o usuário antes de criar o plano.
6. Não escolha silenciosamente entre soluções materialmente diferentes.
7. Após a abordagem ser acordada, crie o plano de implementação e execute-o.
8. Para alterações triviais, não interrompa o usuário desnecessariamente.

## Implementação
- Implemente somente o que for necessário.
- Reutilize os padrões existentes.
- Evite abstrações especulativas e refatorações.
- Não modifique arquivos não relacionados.
- Pare quando o requisito estiver satisfeito e verificado.

## Código
- Use inglês para código e identificadores.
- Não adicione docstrings, exceto quando explicitamente solicitado.
- Não adicione type hints, exceto quando explicitamente solicitado.
- Siga as convenções existentes no repositório.
- Nunca ignore exceções silenciosamente.
- Sempre aplique KISS, YAGNI, DRY, SOLID, Clean Code e boas práticas.

## Verificação
- Inspecione o estado do Git antes e depois das alterações.
- Verifique se apenas os arquivos pretendidos foram alterados.
- Execute os testes e ferramentas de linting relevantes.
- Não declare a implementação como concluída sem realizar as devidas verificações.

## Variáveis de Ambiente
Use estas variáveis para acessar recursos do projeto. Nunca adivinhe ou utilize caminhos fixos.
- `$OBSIDIAN_VAULT_PATH` — diretório do Second Brain no Obsidian (use somente quando solicitado).
- `$DAILIES_DIR` — diretório das notas diárias (use somente quando solicitado).
- `$DOC_DIR` — diretório de documentação do agente (use somente quando solicitado).
Resolva a variável de ambiente antes de acessar o recurso correspondente.