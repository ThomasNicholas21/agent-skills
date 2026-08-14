---
trigger:
  glob: "**/*.py"
---

# Regras de Desenvolvimento: Convenções de Docstrings PEP 257

Ao criar ou modificar módulos, classes, métodos e funções públicas em Python, siga estritamente as convenções do PEP 257.

---

## 1. Módulos, Classes e Métodos Públicos
- **Módulos Públicos**: Todo módulo significativo DEVE possuir uma docstring de módulo no topo do arquivo.
- **Classes Públicas**: Toda classe DEVE possuir uma docstring descrevendo sua responsabilidade principal.
- **Funções e Métodos Públicos**: Toda função e método público DEVE possuir docstring.

---

## 2. Padrão Imperativo e Formatação
- **Modo Imperativo**: Resumos de docstring DEVEM usar verbos na forma imperativa (ex: `"Calculate the total amount."`, `"Retrieve a user by ID."`), NUNCA a forma narrativa (evite `"Calculates..."` ou `"Returns..."`).
- **One-line Docstrings**: Deve utilizar aspas duplas triplas `"""..."""` em uma única linha, iniciar com verbo imperativo e terminar com ponto final.
- **Multi-line Docstrings**: Deve possuir uma linha de resumo inicial, seguida de uma linha em branco e do corpo descritivo detalhado.

---

## 3. Intenção vs Implementação
- **Documentar Intenção**: A docstring DEVE responder a "Para que esta função existe?" e quais são suas regras/efeitos colaterais.
- **Não Duplicar Contratos de Tipo**: NUNCA repita a assinatura da função ou tipos de parâmetros na docstring quando eles já estiverem expressos via Type Hints.

---

## 4. Gatilho de Invocação de Skill

> *Para orientações avançadas, exemplos de docstrings multilinha e convenções de documentação de módulos/classes, **invoque a skill `python-docstring`**.*
