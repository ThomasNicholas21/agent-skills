---
name: python-docstring
description: >-
  Especialista em convenções de documentação Python PEP 257, docstrings de linha única e multilinha,
  focadas em intenção e regras de negócio.
---

# Python Docstring Skill (PEP 257)
Orienta a escrita de docstrings em Python seguindo a PEP 257, priorizando a intenção da API sem duplicar type hints.

## Quando Ativar
- Documentar módulos, classes, métodos ou funções públicas em Python (quando solicitado).
- Refatorar docstrings existentes para o padrão imperativo da PEP 257.
- Decidir entre docstrings de linha única (*one-line*) ou multilinha (*multi-line*).

## Conhecimento (`knowledge/`)
1. [`knowledge/pep257-conventions.md`](./knowledge/pep257-conventions.md): Regras de forma imperativa, aspas triplas e estruturação.
2. [`knowledge/intent-vs-implementation.md`](./knowledge/intent-vs-implementation.md): Documentar intenção e regras sem repetir tipos ou código.
3. [`knowledge/decision-tree.md`](./knowledge/decision-tree.md): Árvore de decisão e checklist.

## Exemplos (`examples/`)
- [`examples/one-line.md`](./examples/one-line.md): Docstring de linha única.
- [`examples/multi-line.md`](./examples/multi-line.md): Docstring multilinha com regras de negócio e pré-condições.
- [`examples/module-and-class.md`](./examples/module-and-class.md): Docstrings de módulo e classe.

## Checklist
1. **Forma Imperativa**: Começa com verbo no imperativo (ex: `"Calculate..."`, `"Retrieve..."`)?
2. **Sem Redundância**: Evitou repetir tipos que já constam nos type hints?
3. **Foco em Intenção**: Explica o "porquê" e o comportamento público em vez do algoritmo linha por linha?
4. **Formatação PEP 257**: Usa `"""..."""` e separa o resumo com uma linha em branco em docstrings multilinha?
