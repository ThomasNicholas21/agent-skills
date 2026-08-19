# RTK — Terminal Efficiency
RTK is the default terminal interface when an equivalent command exists.
Its goal is to reduce terminal output and context usage without sacrificing
correctness.

## Core Rule
```text
RTK first → inspect output → escalate only when necessary
```
Prefer RTK for:
```text
read / ls / tree / find / grep / rg
git / diff / log
tests / lint / typecheck
docker / compose
python / pip / uv
npm / pnpm / npx
database / cloud CLIs
```

Common mappings:
```text
cat FILE          → rtk read FILE
ls DIR            → rtk ls DIR
tree DIR          → rtk tree DIR
find ...          → rtk find ...
grep ...          → rtk grep ...
rg ...            → rtk rg ...
git ...           → rtk git ...
git diff          → rtk diff
cat LOG           → rtk log LOG
cat JSON          → rtk json FILE
pytest            → rtk pytest
ruff              → rtk ruff
mypy              → rtk mypy
docker ...        → rtk docker ...
docker compose... → rtk docker compose ...
```
If an exact RTK wrapper exists, prefer it.

## Escalation
Never guess because output was compressed.
Use:
```text
1. RTK default
2. RTK verbose (-v / -vv)
3. rtk proxy <command>
4. native command
```
Escalate when:
* required information is missing;
* errors are incomplete;
* exact output is required;
* RTK does not support the command;
* debugging requires raw output.

## Integrity
* Preserve and respect exit codes.
* Never ignore errors.
* Never treat compressed output as complete evidence when details are missing.
* Correctness always overrides compression.

## Discovery
When unsure whether RTK supports a command:
```text
rtk --help
rtk <command> --help
```
Do not invent RTK syntax.

## Efficiency
Prefer targeted commands over broad output.
Good:
```text
rtk grep "pattern" src/
rtk read specific/file.py
rtk git diff -- path/to/file
rtk log specific.log
```
Avoid unnecessarily dumping:
```text
entire repositories
large logs
large JSON files
unrelated directories
full Git history
```
Read only what is required for the current task.

## Optional Optimization
Use RTK's compact modes only when they improve signal-to-noise:
```text
--ultra-compact
```
Do not use compression options when they hide information needed for
correctness.

## Diagnostics
Useful RTK commands:
```text
rtk gain
rtk gain --history
rtk discover
rtk session
rtk verify
```
Use these only when relevant; do not run them routinely.