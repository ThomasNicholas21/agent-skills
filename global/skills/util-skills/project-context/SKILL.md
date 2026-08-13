---
name: project-context
description: Establishes and maintains the relevant context of the current software project. Use when understanding a repository, starting project work, recovering project conventions or decisions, determining where a change belongs, or preparing project initialization or knowledge persistence.
---

# Project Context

## Purpose

Establish the minimum reliable context required to work correctly on the current repository without wasting tokens on irrelevant files.

The current repository is the **source of truth for current implementation**.
The Obsidian Second Brain is the **source of truth for historical decisions, context, and business rules**.

---

## 1. Skill Responsibilities

This skill handles:
* Identifying repository root and Git boundaries.
* Discovering workspace-level rules in `.agents/rules/*.md` and workflows in `.agents/workflows/*.md`.
* Progressively exploring directory structure as needed.
* Separating current implementation state from historical Vault notes.

This skill does NOT handle:
* Code refactoring or engineering principles (delegated to `/development-core`).
* Terminal output compression (delegated to `/rtk`).
* Obsidian vault file schema or note formatting (delegated to `/second-brain`).

---

## 2. Progressive Context Discovery

Do not scan the whole codebase upfront. Discover context in levels:

```text
Level 0: Workspace root & Git identity
Level 1: Key manifest files (package.json, pyproject.toml, Cargo.toml, Makefile)
Level 2: Workspace rules (.agents/rules/*.md) & architecture entry points
Level 3: Target module files & direct dependencies
```

Stop as soon as sufficient evidence is gathered to make a correct implementation decision.

---

## 3. Workspace Rules & Conventions

Always check for repository-level rules:
* `.agents/rules/*.md` (e.g. `architecture.md`, `style-guide.md`)
* `.agents/workflows/*.md` (custom project automations)

Workspace-specific rules override generic global preferences.

---

## 4. Repo State vs Obsidian Memory

| Aspect | Current Repository | Obsidian Second Brain |
| :--- | :--- | :--- |
| **Scope** | Code, tests, configs, build scripts | Architecture decisions, business rules, prior discussions |
| **Truth Authority** | **Current implementation state** | **Historical context & business rationale** |

When historical notes conflict with current code, current repository code takes precedence for questions about what the code currently does. Use `/second-brain` to investigate why a divergence occurred.
