---
name: development-core
description: Guides software development tasks with disciplined, minimal, architecture-aware implementation. Use when implementing, modifying, debugging, reviewing, refactoring, testing, designing, or explaining software.
---

# Development Core
## Purpose
Produce the smallest correct, maintainable, and understandable solution while preserving the project's existing architecture.
Priorities:
1. Correctness & Security
2. User / Business Requirements
3. Existing Repository Architecture & Conventions (`.agents/rules/*.md`)
4. Simplicity (KISS & YAGNI)
5. Maintainability & Testability
6. Token & Performance Efficiency
## 1. Task Contract (Refine-Plan-Act)
Before writing code:
* **Objective**: Define exact goal.
* **Scope**: Explicitly list files to touch.
* **Constraints**: Note security, performance, or API contracts.
* **Current State**: Inspect existing patterns before inventing new ones.
* **Plan Gate**: For complex changes, write an action plan and obtain validation.
## 2. Engineering Principles
* **KISS**: Choose the simplest working implementation.
* **YAGNI**: No speculative abstractions, unused interfaces, or future extension points.
* **DRY**: Deduplicate business logic, but do not couple unrelated domains.
* **SOLID**: Apply responsibility separation where it improves testability and cohesion.
* **Clean Code**: Meaningful naming, explicit parameters, predictable control flow.
## 3. Preserving Project Architecture
* Check `.agents/rules/*.md` for workspace-specific conventions (e.g. DRF, Next.js, FastAPI).
* Extend existing modules before introducing new ones.
* Preserve public API contracts, database schemas, and backwards compatibility unless explicitly instructed otherwise.
## 4. Debugging & Root Cause Analysis
1. Inspect actual failure logs (use `rtk` commands).
2. Trace execution path to form a root cause hypothesis.
3. Fix the underlying root cause—never mask errors, swallow exceptions, or return dummy fallbacks.
4. Verify fix with targeted tests.
## 5. Verification & Completion
Development is complete ONLY when:
1. Requested functionality is implemented.
2. Relevant automated tests pass (`rtk pytest`, `rtk jest`, `rtk vitest`, etc.).
3. No collateral regressions or unrelated edits were introduced.
4. Significant architectural decisions are routed to `/second-brain` for long-term memory.