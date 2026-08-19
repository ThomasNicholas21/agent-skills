# Anti-Drift

- Antes de alterar código, execute `git status --short`.
- Defina a alteração mínima necessária e o escopo explícito de arquivos.
- Modifique APENAS os arquivos no escopo.
- Proibido refatoração, renomeação, formatação, alteração de imports, limpeza ou novas abstrações fora do escopo.
- Pare assim que o requisito estiver implementado e verificado.

Antes de criar código ou arquitetura:
- Busque no repositório com `rtk grep` / `rtk find`.
- Reutilize padrões existentes.
- Não introduza camadas arquiteturais sem solicitação explícita.

Antes de decisões arquiteturais/negócio:
- Consulte o `/second-brain`.
- Siga ADRs, regras de negócio, restrições e decisões existentes.
- Persista novas decisões importantes via `/obsidian-decide` ou `/obsidian-save`.

PARE e pergunte se:
- A arquitetura/Second Brain entrar em conflito com a solicitação.
- O escopo precisar ser expandido.
- Uma dependência obrigatória estiver ausente.
- As convenções forem ambíguas ou contraditórias.
- Os testes revelarem regressões fora do escopo.

Após as alterações:
- Execute os testes e linters relevantes.
- Execute `git status --short` e `git diff --stat`.
- Garanta que apenas os arquivos do escopo foram alterados.
- Reverta alterações acidentais fora do escopo.

Conclua apenas quando o requisito estiver verificado, no escopo e sem regressões.