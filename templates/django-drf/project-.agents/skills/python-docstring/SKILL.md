---
name: python-docstring
description: >-
  Especialista em convenções de documentação Python PEP 257, docstrings de linha única e multilinha,
  e documentação focada em intenção e regras de negócio.
---

# Python Docstring Skill (PEP 257)

Esta habilidade orienta a escrita de docstrings em Python seguindo rigorosamente as convenções da PEP 257, priorizando a clareza da intenção da API e evitando redundâncias com o sistema de type hints.

---

## Quando Ativar Esta Skill

Ative esta skill quando a tarefa envolver:
- Documentar novos módulos, classes, métodos ou funções públicas em Python.
- Refatorar docstrings existentes para o padrão imperativo da PEP 257.
- Decidir quando utilizar docstrings de linha única (*one-line*) ou multilinha (*multi-line*).
- Definir o nível de documentação necessário sem duplicar informações fornecidas por type hints.

---

## Índice de Conhecimento Profundo (`knowledge/`)

1. [`knowledge/pep257-conventions.md`](./knowledge/pep257-conventions.md): Regras de forma imperativa, aspas duplas triplas e estruturação.
2. [`knowledge/intent-vs-implementation.md`](./knowledge/intent-vs-implementation.md): Documentar intenção e regras de negócio sem repetir tipos ou código.
3. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão para necessidade de docstrings e checklist.

---

## Exemplos de Código (`examples/`)

- [`examples/one-line.md`](./examples/one-line.md): Exemplo de docstring de linha única limpa.
- [`examples/multi-line.md`](./examples/multi-line.md): Exemplo de docstring multilinha com regras de negócio e pré-condições.
- [`examples/module-and-class.md`](./examples/module-and-class.md): Docstrings no nível de módulo e classe.

---

## Checklist de Implementação de Docstrings

1. **Forma Imperativa**: O resumo começa com verbo na forma imperativa (ex: `"Calculate..."`, `"Retrieve..."`)?
2. **Sem Redundância de Tipos**: Evitou declarar tipos de parâmetros na docstring quando os type hints já existem na assinatura?
3. **Foco em Intenção**: A docstring explica o "porquê" e o comportamento público em vez de explicar o algoritmo linha por linha?
4. **Formatação PEP 257**: Utiliza aspas duplas triplas `"""..."""` e separa a primeira linha do resumo por uma linha em branco em docstrings multilinha?
