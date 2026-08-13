---
name: test
description: Guides test creation, execution, TDD workflows, and root cause failure diagnosis using RTK test runners. Use when writing unit, integration, or E2E tests, fixing failing tests, or validating code quality.
---

# Testing & Quality Skill
## Purpose
Ensure code correctness, prevent regressions, and enforce quality guardrails using efficient RTK test execution and TDD principles.
## 1. Test Principles
* **Test Behavior, Not Implementation**: Focus tests on input/output contracts, public methods, and state changes.
* **TDD Loop (Red-Green-Refactor)**: Write a failing test first to establish requirement, write minimal code to make it pass, then clean up.
* **Deterministic & Isolated**: Tests must not rely on external non-mocked network states or random side-effects.
## 2. RTK Execution Standards
Always run test suites using RTK wrappers:
```bash
# Python
rtk pytest path/to/test_file.py
rtk ruff check .
rtk mypy .

# JavaScript / TypeScript
rtk jest
rtk vitest
rtk tsc --noEmit
```
* RTK suppresses pass noise and highlights failure stack traces.
* If an error occurs, analyze the stack trace completely before touching code. Never swallow exceptions or comment out broken assertions.
## 3. Failure Diagnosis Protocol
1. Read full failure traceback from `rtk pytest` / test log.
2. Identify whether failure is due to a broken assumption, bad test setup, or code bug.
3. Apply minimal fix to source code.
4. Rerun specific test command via RTK to confirm green state.