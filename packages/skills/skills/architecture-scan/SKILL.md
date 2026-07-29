---
name: architecture-scan
description: Scans the codebase for tech debt — balls of mud, shallow modules, and DRY violations — then presents prioritized bottlenecks and hands off to TDD-driven refactoring via superpowers.
---

# Architecture Scan

Fights software entropy by proactively identifying tech debt, "balls of
mud," and shallow modules, then integrating the fixes into the Superpowers
strict TDD workflow.

## Prerequisites

This skill integrates tools from the team's AI workflow guide. See
`docs/tools-reference.md` for install commands and graceful degradation.

- **Required:** Superpowers plugin (for handoff to `using-git-worktrees`, `writing-plans`, `test-driven-development`)
- **Recommended:** CodeGraph (structural analysis), Engram (memory), context-mode (large output processing), ripgrep, eza, fd, bat

## Workflow

### Phase 0: Sync Context (Golden Rule — sync before starting)

Before scanning, recover prior context:

1. **Memory sync:** Call `mem_search` for prior architecture decisions,
   ADRs, or architecture scan results. Call `mem_context` for recent
   session history.
2. **Existing docs:** Read `docs/adr/` for prior architectural decisions.
   Read `docs/CONTEXT.md` for domain vocabulary — use these terms when
   describing bottlenecks, not raw code names.
3. **Scope decision:** If the user named a direction (module, subsystem,
   pain point), take it. Otherwise, walk `git log --oneline` to find
   hot spots — files that keep coming up in recent changes.

### Phase 1: The Investigation Phase

Scan the codebase (or a specified directory) looking for three categories
of architectural friction. Use the tools below; degrade gracefully when
a tool is missing.

#### 1a. Balls of Mud

Files or modules that are too long, handle too many concerns, or have too
many dependencies.

- **`codegraph_impact <symbol>`** — check dependency blast radius. A symbol
  whose impact depth is >3 levels and touches >10 files is a ball of mud
  candidate.
- **`codegraph_callees <symbol>`** — see what a module pulls in. A module
  that calls >20 distinct functions across >5 files is doing too much.
- **`eza --tree -L 3`** — structural overview. Directories with >15 files
  at one level may indicate a missing abstraction.
- **`rg "class |def |function |export "`** — count exports per file. Files
  with >10 exports are likely doing too much.
- **Fallback:** If CodeGraph isn't initialized, offer `codegraph init`. If
  unavailable, use `rg` to trace imports and `glob` to count files.

#### 1b. Shallow Modules

Interfaces that expose too much complexity rather than hiding it. A module
is shallow if its interface is nearly as complex as its implementation.

- **`codegraph_explore "<module name>"`** — examine the interface (exported
  symbols) vs the implementation (internal symbols). If the ratio of
  exported to internal symbols is close to 1:1, the module is shallow.
- **`codegraph_node <symbol> --includeCode`** — read the full source of a
  suspected shallow module. If the caller needs to understand the
  implementation to use the interface correctly, it's shallow.
- **Apply the deletion test:** "Would deleting this module concentrate
  complexity, or just move it?" A "yes, concentrates" answer means the
  module is genuinely deep and should be kept. A "just moves it" answer
  means it's shallow and can be deepened or inlined.
- **Fallback:** Use `read` to examine the file directly. Count exported
  symbols vs total symbols.

#### 1c. Duplication (DRY Violations)

Logic that violates DRY — repeated code blocks, copy-pasted patterns.

- **`rg "<pattern>"`** — search for repeated code patterns. Look for
  similar function signatures, identical error handling blocks, or
  duplicated validation logic.
- **`fd "<similar name>"`** — discover files with similar names across
  directories (e.g., `*validator*`, `*handler*` in multiple places).
- **`bat -p <file>`** — view files in plain mode for side-by-side mental
  comparison.
- **Fallback:** Use `grep` and `find` if `rg` and `fd` are unavailable.

#### Processing Large Results

If the scan produces large output (many files, many matches), use
`ctx_batch_execute` (context-mode) to run multiple search commands in
parallel and process results through the sandbox — only derived answers
enter context, not raw bytes. If context-mode is unavailable, pipe
through `rg` or `jq` to filter before reading.

### Phase 2: The Reporting Phase

Present a concise, prioritized list of **1 to 3** architectural bottlenecks
to the user.

For each bottleneck, provide:

- **Name** — using domain vocabulary from `CONTEXT.md` if available (e.g.,
  "the Order intake module" not "the FooBarHandler")
- **Category** — Ball of Mud / Shallow Module / Duplication
- **Files** — which files/modules are involved
- **Current state** — why the current architecture is causing friction
  (with specific metrics: dependency count, export count, duplication count)
- **Ideal state** — what the deepened/cleaned version looks like
- **Deletion test result** — would fixing this concentrate complexity or
  just move it?
- **ADR conflicts** — if a candidate contradicts an existing ADR, mark it
  clearly: "contradicts ADR-0007 — but worth reopening because..."

**Do NOT start refactoring yet.** Ask the user which bottleneck they want
to tackle first.

### Phase 3: The Integration Phase (Superpowers Handoff)

Once the user selects a target, immediately trigger the Superpowers
workflow:

1. **`using-git-worktrees`** (superpowers) — create a safe, isolated branch
   for the refactor. Never refactor on `main` or `staging`.
2. **`writing-plans`** (superpowers) — break the refactor down into 2-5
   minute tasks. Each task should be independently testable.
3. **`test-driven-development`** (superpowers) — enforce RED-GREEN-REFACTOR
   for every task in the plan. No existing code is deleted until a test
   covers its behavior.

**Discovering the test command:** Use `mise tasks` to find the project's
canonical test command. If mise isn't set up, detect the test runner
directly:
- Node: `npm test` or `npx jest` or `npx vitest`
- Python: `pytest` or `python -m pytest`
- Go: `go test ./...`
- Rust: `cargo test`

Announce the handoff: "Architecture scan complete. Target selected:
[bottleneck]. Transitioning to git-worktrees → writing-plans →
test-driven-development."

## Degradation

| Tool Missing | Impact | Fallback |
|---|---|---|
| CodeGraph | No structural dependency analysis | `rg` for imports, `glob` for file counts, `read` for interface inspection |
| context-mode | Large scan results enter context directly | Pipe through `rg`/`jq` to filter before reading |
| Engram | No memory sync or persistence | Read `docs/adr/` and `docs/CONTEXT.md` directly |
| mise | No canonical task discovery | Detect test runner from `package.json`, `pyproject.toml`, etc. |
| eza | No tree view | `ls -R` or `find . -type d` |
| ripgrep | Slower text search | `grep -r` |
| Superpowers | No TDD handoff | Enforce RED-GREEN-REFACTOR manually |