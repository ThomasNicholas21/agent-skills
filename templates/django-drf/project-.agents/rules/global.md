---
trigger: always_on
---

# Regras Globais do Repositório

Todas as interações, comandos de terminal e escritas de código DEVEM respeitar os princípios estabelecidos nesta regra.

---

## 1. Operações Eficientes no Terminal (RTK First)

- **Comandos RTK**: Sempre utilize comandos suportados pelo RTK (`rtk read`, `rtk grep`, `rtk find`, `rtk git`, `rtk pytest`, `rtk ruff`, etc.) para operações de terminal. Isso reduz o consumo desnecessário de tokens.
- **Escalação**: Utilize comandos nativos do shell APENAS se o RTK não suportar a ação necessária.

---

## 2. Princípios Fundamentais de Engenharia de Software (Clean Code, SOLID, KISS, YAGNI, DRY)

Todo código escrito ou refatorado DEVE obedecer rigorosamente aos princípios de design de software:

- **KISS (Keep It Simple, Stupid)**:
  - Escolha sempre a solução mais simples, direta e legível que satisfaça o requisito.
  - Evite complexidade acidental, sobre-engenharia ou truques sintáticos obscuros.

- **YAGNI (You Aren't Gonna Need It)**:
  - NUNCA adicione parâmetros, métodos, abstrações ou funcionalidades baseadas em hipóteses para uso futuro.
  - Implemente estritamente o código necessário para resolver o problema atual.

- **DRY (Don't Repeat Yourself)**:
  - Evite duplicação de lógica de negócio e blocos de código repetitivos.
  - Antes de escrever um helper ou utilitário, busque no repositório (`rtk grep`, `rtk find`) por implementações existentes reutilizáveis.

- **Clean Code (Código Limpo)**:
  - **Nomes Reveladores de Intenção**: Nomes de variáveis, funções e classes devem explicitar claramente seu propósito (ex: `user_account_balance` em vez de `bal`).
  - **Funções Pequenas e Focadas**: Métodos devem ser pequenos e realizar apenas uma tarefa bem definida.
  - **Tratamento Explícito de Erros**: NUNCA engula exceções com `try...except: pass` silenciosos. Trate ou repasse exceções com contexto adequado.

- **Princípios SOLID**:
  - **SRP (Single Responsibility Principle)**: Uma classe ou módulo deve ter uma única responsabilidade e apenas uma razão para mudar.
  - **OCP (Open/Closed Principle)**: Módulos devem ser abertos para extensão, mas fechados para modificação.
  - **LSP (Liskov Substitution Principle)**: Subtipos devem ser substituíveis por seus tipos base sem alterar a estabilidade do sistema.
  - **ISP (Interface Segregation Principle)**: Prefira múltiplas interfaces ou protocolos específicos a uma interface gigante genérica.
  - **DIP (Dependency Inversion Principle)**: Dependa de abstrações (`Protocol`, `collections.abc`), não de implementações concretas diretamente.

---

## 3. Padrões de Código e Estilo

- **Linguagem**: Código, nomes de variáveis, classes e funções DEVEM ser escritos em **Inglês**.
- **Comentários e Documentação**: Podem ser escritos em **Português** para alinhar ao time de desenvolvimento local.
- **Python**: Siga estritamente o **PEP 8**, mantendo tipagem estática explícita (`type hints` modernos) nas assinaturas de funções e métodos públicos.

---

## 4. Resolução de Ambientes e Variáveis

- Nunca adivinhe ou procure exaustivamente por variáveis de ambiente ou caminhos de Vault.
- Utilize as variáveis parametrizadas (`.env` / `.env.example`):
  - `$OBSIDIAN_VAULT_PATH` ou `$SECOND_BRAIN_DIR`: Raiz do Obsidian Second Brain.
  - `$AGENT_SKILLS_DIR`: Diretório hub de código, regras e skills.

---

## 5. Integrações Rápidas (`second-brain` & `rtk`)

> *Para consultar contexto histórico de projeto, buscar ADRs ou salvar decisões ao fim de uma sessão, consulte a regra `second-brain.md` ou invoque a skill `/second-brain`.*
> *Para otimização de execução de terminal com economia de contexto, utilize os utilitários da regra `global.md` ou invoque a skill `/rtk`.*
