---
trigger: always_on
---

# Regras de Anti-Drift, Scope Lock e Barreira de Segurança

Esta regra atua como barreira de segurança contínua (*Always On*), restringindo o escopo de modificação, exigindo consulta ao Second Brain, verificação pelo estado real do Git e estabelecendo condições estritas de parada.

---

## 1. Scope Lock (Bloqueio de Escopo)

Antes de efetuar qualquer alteração no código:
1. **Identifique o Objetivo Estrito**: Defina o menor conjunto possível de alterações necessárias para atender ao requisito.
2. **Defina os Arquivos do Escopo**: Identifique os arquivos que DEVEM ser alterados.
3. **Isolamento de Escopo**: NUNCA modifique arquivos fora do escopo definido.
4. **Sem Refatoração Não Solicitada**: É **PROIBIDO** renomear símbolos não relacionados, reorganizar imports em arquivos não modificados, aplicar limpezas estéticas ou reformatar código adjacente.
5. **Encerramento Imediato**: Assim que o objetivo for atendido e verificado, PARE imediatamente. Não adicione abstrações para requisitos hipotéticos futuros.

---

## 2. Condições Estritas de Parada (Stop Conditions)

PARE imediatamente a execução e solicite instrução ou esclarecimento ao usuário se:
- O requisito solicitado conflitar com a arquitetura estabelecida do repositório ou com decisões registradas no Second Brain.
- A implementação exigir a modificação de arquivos não relacionados fora do escopo inicial.
- Uma dependência técnica necessária estiver ausente.
- As convenções do código existente forem ambíguas ou contraditórias.
- A verificação de testes revelar quebras de comportamento em módulos fora do escopo.

---

## 3. Consulta ao Second Brain e Preservação Arquitetural

### A. Consulta de Contexto Histórico no Second Brain (Search-Before-Create)
Antes de tomar decisões de arquitetura, assumir regras de negócio ou implementar novas funcionalidades:
1. **Buscar no Cofre (`/second-brain`)**: Consulte o Obsidian Second Brain via `/obsidian-find <termo>` ou `/second-brain` para resgatar decisões arquiteturais (ADRs), restrições de negócio e históricos do projeto (`/obsidian-project`).
2. **Respeitar Decisões Históricas**: Se uma regra ou decisão de arquitetura já estiver documentada no Second Brain, siga-a estritamente. NUNCA crie soluções contraditórias ao histórico registrado no cofre.
3. **Persistência de Marcos**: Ao concluir refinamentos de arquitetura ou soluções complexas, registre os marcos de volta no cofre via `/obsidian-decide` ou `/obsidian-save`.

### B. Busca Prévia no Repositório (Audit Before Invention)
Antes de criar qualquer novo arquivo, classe, função, serviço, manager, utility ou camada arquitetural:
1. **Busca Prévia no Código**: Execute busca no repositório (`rtk grep`, `rtk find`) para verificar se já existe uma implementação, utilitário ou padrão equivalente.
2. **Reaproveitamento de Padrões**: Reutilize as abstrações e padrões existentes no repositório.
3. **Não Invente Arquitetura**: É **PROIBIDO** introduzir novas camadas arquiteturais (services, repositories, use cases) a menos que explicitamente solicitado pelo usuário.

---

## 4. Verificação de Escopo pelo Estado Real do Git

O agente NUNCA deve confiar na própria memória para validar se manteve o escopo; deve consultar a autoridade do estado do Git:

- **Antes da Alteração**: Inspecione o estado inicial do repositório via `rtk git status` ou `git status --short`.
- **Após a Alteração**: Execute `git status --short` e `git diff --stat`.
- **Validação de Diffs**: Confirme que APENAS os arquivos do escopo foram alterados. Se arquivos não relacionados tiverem sido modificados acidentalmente, reverta as alterações não autorizadas antes de prosseguir.

---

## 5. Critérios de Conclusão da Tarefa (Completion Criteria)

A tarefa é considerada concluída APENAS quando todos os critérios forem atendidos:
1. O requisito solicitado foi totalmente implementado e verificado empiricamente via testes (`rtk pytest`) ou linting.
2. O contexto histórico do Second Brain e as diretrizes da arquitetura foram respeitados.
3. O resultado de `git status --short` reflete estritamente os arquivos previstos no escopo.
4. Nenhuma refatoração, limpeza estética ou dependência não solicitada foi introduzida.
5. A suíte de testes relevante passou sem regressões.