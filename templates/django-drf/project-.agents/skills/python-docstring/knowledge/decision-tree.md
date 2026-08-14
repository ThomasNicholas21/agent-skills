# Knowledge: Árvore de Decisão para Docstrings e Regras Estritas

---

## 1. Árvore de Decisão

```text
AO CRIAR OU MODIFICAR CÓDIGO PYTHON:

1. Trata-se de um Módulo, Classe ou Função/Método Público?
   ├── NÃO (ex: variável local, função helper privada autoevidente) ──> Docstring opcional.
   └── SIM ──> Exige docstring.

2. A operação é simples e autoevidente pelo nome e assinatura?
   ├── SIM ──> Usar One-line Docstring: """Verb in imperative form."""
   └── NÃO ──> Usar Multi-line Docstring.

3. O que incluir em uma Multi-line Docstring?
   ├── Linha 1: Resumo curto e imperativo.
   ├── Linha 2: Linha em branco.
   └── Linha 3+: Intenção, regras de negócio, efeitos colaterais e exceções públicas.
```

---

## 2. Regras Estritas de Proibição

1. **NUNCA** use verbos narrativos (`"Calculates..."`, `"Returns..."`) na primeira linha. Use imperativo (`"Calculate..."`, `"Return..."`).
2. **NUNCA** duplique os tipos declarados nas type hints dentro de blocos `Args: param (type)` sem necessidade real.
3. **NUNCA** explique o algoritmo linha por linha dentro da docstring. Foque na intenção pública.
4. **NUNCA** deixe de colocar ponto final no término da frase do resumo.
