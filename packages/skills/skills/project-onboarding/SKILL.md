---
name: project-onboarding
description: Sets up a new project for the AI workflow — creates AGENTS.md, mise.toml tasks, initializes CodeGraph, and seeds Engram memory. Optional/auxiliary skill.
---

# Project Onboarding

Sets up a new project following the team's AI workflow guide. Creates the
foundation files that the other skills and superpowers depend on. This is
an **optional/auxiliary** skill — the core 3 skills work without it, but
it ensures the project is properly configured for the full workflow.

## Prerequisites

This skill integrates tools from the team's AI workflow guide. See
`docs/tools-reference.md` for install commands and graceful degradation.

- **Required:** None (this skill sets up the prerequisites for others)
- **Recommended:** Engram (memory), CodeGraph (structural analysis), mise (task runner)

## When to Activate

- User asks to "onboard a project", "set up AI workflow", "initialize
  project for AI"
- Starting work on a repo that has no `AGENTS.md`
- After cloning a new repo that will use the AI workflow

## Workflow

### Phase 0: Pre-flight Check

Before creating anything, scan for existing configuration:

1. **Memory sync:** Call `mem_search` for prior onboarding context. Call
   `mem_context` for recent session history.
2. **Scan for existing files:**
   - `AGENTS.md` (or `CLAUDE.md`) at repo root
   - `docs/CONTEXT.md` or `docs/DOMAIN.md`
   - `docs/adr/` directory
   - `mise.toml` or `.mise/tasks/`
   - `.codegraph/` directory
   - `CHANGELOG.md`
3. **Report what exists vs what's missing.** Present a table:

| File | Status | Action |
|---|---|---|
| AGENTS.md | Found / Missing | Keep / Create |
| docs/CONTEXT.md | Found / Missing | Keep / Create stub |
| docs/adr/ | Found / Missing | Keep / Create |
| mise.toml | Found / Missing | Keep / Create |
| .codegraph/ | Found / Missing | Keep / Initialize |
| CHANGELOG.md | Found / Missing | Keep / Create |

**Do NOT overwrite existing files.** Only create what's missing. If a
file exists but is outdated, offer to update it — ask the user first
(golden rule: guard risky actions).

### Phase 1: Create `AGENTS.md`

If `AGENTS.md` doesn't exist, create it from the template in
`docs/agents-template.md`:

1. **Detect the stack:**
   - Language: check for `package.json` (Node/TS/JS), `pyproject.toml` /
     `requirements.txt` (Python), `go.mod` (Go), `Cargo.toml` (Rust),
     `*.csproj` (C#)
   - Framework: check dependencies for React, Next.js, NestJS, Django,
     FastAPI, Gin, Echo, etc.
   - Test runner: check for jest, vitest, pytest, go test, cargo test
   - Linter: check for eslint, ruff, golangci-lint, clippy
   - Type checker: check for tsc, mypy, go vet
2. **Detect git flow:**
   - Check for `staging` branch: `git branch -a | grep staging`
   - Check branch naming convention from recent branches
   - Check for ticket prefix in recent commit messages
3. **Fill in the template** with detected values. Present the filled
   template to the user for confirmation before writing.
4. **Write `AGENTS.md`** with the dated version marker:
   `<!-- Team standard: vYYYY.MM.DD -->`

If `CLAUDE.md` doesn't exist and the team uses Claude Code, offer to
create one that imports `AGENTS.md`:
```markdown
@AGENTS.md

## Claude Code

- Use plan mode for any change that touches more than a couple of files.
- Prefer the project's CodeGraph/ripgrep tooling over reading whole files.
```

### Phase 2: Set up `mise.toml`

If `mise.toml` doesn't exist, create it with canonical task definitions:

1. **Detect commands:**
   - Test: `npm test`, `pytest`, `go test ./...`, `cargo test`, etc.
   - Lint: `npm run lint`, `ruff check .`, `golangci-lint run`, etc.
   - Typecheck: `tsc --noEmit`, `mypy .`, `go vet ./...`, etc.
   - Build: `npm run build`, `python -m build`, `go build`, `cargo build`
2. **Create `mise.toml`:**

```toml
[tasks.test]
description = "Run the test suite"
run = "<detected test command>"

[tasks.lint]
description = "Run the linter"
run = "<detected lint command>"

[tasks.typecheck]
description = "Run the type checker"
run = "<detected typecheck command>"

[tasks.build]
description = "Build the project"
run = "<detected build command>"
```

3. If no tools are detected for a command, ask the user for it. Don't
   guess (golden rule: anti-sycophancy — don't rubber-stamp a bad guess).

### Phase 3: Initialize CodeGraph

If `.codegraph/` doesn't exist:

1. Check if `codegraph` is installed: `which codegraph`
2. If installed: `codegraph init`
3. If not installed: offer to install it:
   ```bash
   mise use --global npm:@colbymchenry/codegraph
   codegraph init
   ```
4. If the user declines, skip this step. The other skills will fall back
   to `rg` + `glob` for structural analysis.
5. Verify with `codegraph_status` (if the MCP tool is available) or
   `ls .codegraph/`.

### Phase 4: Seed Engram Memory

If Engram is available, seed the project's memory:

1. **Project inventory entry** (per the project-inventory pattern):
   - `mem_save` with:
     - `title`: "Project inventory: [project name]"
     - `type`: "architecture"
     - `content`: What/Why/Where format with project name, aliases,
       purpose, and local path
   - Pin it with `mem_pin` so it surfaces at the start of every session.

2. **Tech stack summary:**
   - `mem_save` with:
     - `title`: "Tech stack for [project name]"
     - `type`: "config"
     - `content`: What/Why/Where format with detected language, framework,
       test runner, linter, type checker

If Engram isn't available, skip this step. The workflow still functions —
context sync falls back to reading `docs/CONTEXT.md` and `docs/adr/`
directly.

### Phase 5: Create `docs/CONTEXT.md` (stub)

If `docs/CONTEXT.md` doesn't exist, create a stub for the
`building-domain-context` skill to fill later:

```markdown
# Domain Context

<!-- Version: vYYYY.MM.DD -->

## Ubiquitous Language

<!-- To be filled by the building-domain-context skill -->

## Entity Relationships

<!-- To be filled -->

## Business Rules

<!-- To be filled -->

## Architectural Decisions

<!-- See docs/adr/ for ADRs -->
```

Also create `docs/adr/` directory if it doesn't exist.

### Phase 6: Create `CHANGELOG.md`

If `CHANGELOG.md` doesn't exist, create it:

```markdown
# Changelog

## [Unreleased]
### Added
- Initial project onboarding: AGENTS.md, mise.toml, CodeGraph, domain context stub
```

### Phase 7: Verification

Verify all setup steps completed successfully:

1. **Run `mise tasks`** — confirm all tasks resolve and show the correct
   commands.
2. **Run `codegraph_status`** (or `ls .codegraph/`) — confirm the graph
   is built.
3. **Run `mem_context`** — confirm the project inventory and tech stack
   memories are seeded.
4. **Read `AGENTS.md`** — confirm it exists and has the dated version marker.
5. **Read `docs/CONTEXT.md`** — confirm the stub exists.

Report a summary:

```
Project Onboarding Complete:
- [x] AGENTS.md created (v2026.MM.DD)
- [x] mise.toml created (4 tasks: test, lint, typecheck, build)
- [x] CodeGraph initialized (.codegraph/)
- [x] Engram memory seeded (project inventory + tech stack)
- [x] docs/CONTEXT.md stub created
- [x] CHANGELOG.md created
- [!] [Any steps that were skipped or need manual attention]
```

### Phase 8: Handoff

Suggest next steps:

- **"Run `building-domain-context` to fill the `docs/CONTEXT.md` stub
  with your ubiquitous language."** — if the project has novel business
  logic.
- **"Run `brainstorming` to start designing a feature."** — if the user
  has a specific feature in mind.
- **"Run `architecture-scan` to check for existing tech debt."** — if
  the project has existing code.

## Degradation

| Tool Missing | Impact | Fallback |
|---|---|---|
| Engram | No memory seeding | Skip Phase 4. Context sync falls back to reading docs directly |
| CodeGraph | No structural graph | Skip Phase 3. Other skills fall back to `rg` + `glob` |
| mise | No canonical task definitions | Skip Phase 2. Other skills detect runner directly |
| Superpowers | No handoff | Suggest manual next steps based on the workflow guide |