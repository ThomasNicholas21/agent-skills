# Global Agent Operating Directives (Always On)
These directives apply universally across all workspaces and sessions.

## 1. Primary Operating Baseline
For every task, follow progressive disclosure and minimum context:
1. **Scope & Identity**: Establish current workspace and repository boundaries via `/project-context`.
2. **Methodology**: Apply software engineering rigor via `/development-core`.
3. **Terminal Operations**: Filter all shell output via `/rtk`.
4. **Memory & History**: Route all persistent memory retrieval and storage via `/second-brain`.
5. **Specialized Tasks**: Activate `/feature`, `/refactor`, or `/test` according to task objective.

## 2. Mandatory Terminal Efficiency (RTK)
* **RTK First**: Always use RTK-supported commands (`rtk read`, `rtk grep`, `rtk find`, `rtk git`, `rtk pytest`, `rtk jest`, `rtk ruff`, etc.) for terminal operations to minimize context consumption.
* **Escalation**: Fallback to native commands ONLY if RTK does not support the action or filtered output loses crucial evidence needed for correctness.
* **Zero Guessing**: Run `rtk --help` when uncertain of supported syntax.

## 3. Persistent Memory Gateway (Obsidian Second Brain)
* **Routing Gateway**: Route all Vault operations through `/second-brain`. Do not manually duplicate Vault schemas or search logic.
* **Repo vs Vault Truth**: The current Git repository is the source of truth for **current implementation**. The Obsidian Second Brain vault is the source of truth for **historical context, decisions, and business knowledge**.
* **Auto-Persist**: Route durable architectural decisions, business rules, and session milestones to `/second-brain` (`/obsidian-save`, `/obsidian-project`).

## 4. Plan-Before-Execute Gate
* **Mandatory Plan & Approval**: Always present an explicit Action Plan before editing or implementing code. Show what will be done, explain the rationale (why), and wait for user confirmation before executing changes.
* **Execution**: Once approved, execute in atomic, minimal vertical slices and verify after each step.

## 5. Precedence & Anti-Drift
1. **Instruction Priority**: Explicit User Request > Workspace Rules (`.agents/rules/*.md`) > Workspace Skills (`.agents/skills/*`) > Global Rules (`GEMINI.md`).
2. **Scope Enforcement**: Implement the smallest change that satisfies requirements. Never introduce unrequested refactors, speculative abstractions, or cleanup.
3. **Verification**: Never declare a task complete without running empirical verification (tests, linting, or runtime checks).
4. **Explicit Directives & Approval**: Never perform actions, create files, execute refactorings, or modify code outside the explicit scope requested by the user. Always explain what will be done and why, and obtain approval before implementing.