---
name: refactor
description: Guides safe, behavior-preserving code refactoring. Use when reorganizing code, improving module boundaries, eliminating technical debt, or optimizing performance without changing public API contracts.
---

# Refactoring Skill
## Purpose
Improve internal code structure, legibility, and maintainability without breaking public API contracts, introducing regressions, or altering external behavior.
## 1. Refactoring Directives
1. **Behavior Preservation**: External behavior and API contracts MUST remain identical.
2. **Test-Backed Safety**: Ensure tests are passing BEFORE starting refactoring. If test coverage is missing, write tests first via `/test`.
3. **Atomic Modifications**: Make small, incremental changes. Validate after every single change using RTK test commands.
4. **No Mixed Scope**: Do NOT mix refactoring with adding new features or fixing unrelated bugs.
## 2. Refactoring Workflow
### Step 1: Pre-Flight Check
* Run `rtk pytest` (or project test command) to confirm the baseline build is "green".
* Inspect target code and identify code smells (duplication, bloated functions, tight coupling).
### Step 2: Plan Refactoring Steps
* Define discrete refactoring steps (e.g. Extract Function → Move Class → Rename Interface).
### Step 3: Execute & Validate Incrementally
* Perform step 1 edit.
* Run tests via RTK.
* Check diff via `rtk git diff`.
* Repeat for subsequent steps.
### Step 4: Finalize & Record
* Confirm all tests pass cleanly.
* Log architectural changes or refactoring patterns to Second Brain via `/second-brain` -> `/obsidian-save`.