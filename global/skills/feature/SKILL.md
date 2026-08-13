---
name: feature
description: Guides end-to-end feature implementation with requirement analysis, Plan-Before-Execute gate, vertical slice coding, and auto-persistence to Obsidian Second Brain. Use when creating new functionality, adding endpoints, components, or modules.
---

# Feature Implementation Skill
## Purpose
Implement new features completely and cleanly without scope drift, breaking existing systems, or losing architectural decisions.
## 1. Feature Lifecycle (Refine - Plan - Act - Persist)
### Step 1: Refine (Requirements & Context)
* Clarify user story, acceptance criteria, and edge cases.
* Inspect project conventions in `.agents/rules/*.md` and existing code patterns using `/project-context`.
* Query historical decisions via `/second-brain` -> `/obsidian-find` if business rules are ambiguous.
### Step 2: Plan (Plan-Before-Execute Gate)
* For non-trivial features, create a step-by-step Action Plan:
  1. Files to create/modify.
  2. Data models, API contracts, or domain logic affected.
  3. Verification strategy (unit/integration tests).
* Present plan and obtain approval before writing code.
### Step 3: Act (Incremental Implementation)
* Implement in minimal vertical slices (e.g. Model → Service → API/UI).
* Apply KISS, YAGNI, and DRY principles (`/development-core`).
* Keep edits tight; do not perform unrelated cleanup.
### Step 4: Verify & Persist
* Run test suite via RTK (`rtk pytest`, `rtk jest`, `rtk vitest`).
* Inspect git changes via `rtk git diff`.
* Save new architectural decisions or feature milestone to Obsidian Second Brain via `/second-brain` -> `/obsidian-save`.