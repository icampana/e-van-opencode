# @e-van/skills

Workflow skills for OpenCode, Claude Code & Superpowers: domain context,
architecture scan, evidence-first development, and project onboarding.

## Overview

Four skills that extend the [superpowers](https://github.com/obra/superpowers)
plugin with domain-driven design, architecture review, evidence-first
development, and project setup workflows. Each skill enforces the team's
golden rules and integrates with the team's standard toolchain
(CodeGraph, Engram, context-mode, mise, modern Unix tools).

| Skill | Type | Purpose |
|---|---|---|
| `building-domain-context` | Core | DDD ubiquitous language before brainstorming |
| `architecture-scan` | Core | Tech debt detection + TDD refactor handoff |
| `running-the-gauntlet` | Core | Evidence-first development for high-stakes code |
| `project-onboarding` | Optional | Project setup following the AI workflow guide |

## Skill Chain

The skills chain with superpowers skills in this order:

```
project-onboarding (optional, once per project)
    │
    ▼
building-domain-context  ──►  brainstorming (superpowers)  ──►  writing-plans (superpowers)
    │                                                              │
    ▼                                                              ▼
architecture-scan  ──►  using-git-worktrees (superpowers)  ──►  test-driven-development (superpowers)
    │                                                              │
    ▼                                                              ▼
    (reports bottlenecks)                                    running-the-gauntlet
                                                                   │
                                                                   ▼
                                                           EVIDENCE.md + mem_save
```

## Prerequisites

### Required

- **[Superpowers](https://github.com/obra/superpowers)** plugin — all core
  skills hand off to `brainstorming`, `writing-plans`, `using-git-worktrees`,
  and `test-driven-development`.

**OpenCode** — add to your `opencode.json`:

```json
{
  "plugin": [
    "superpowers@git+https://github.com/obra/superpowers.git"
  ]
}
```

**Claude Code** — install via marketplace:

```
/plugin marketplace add anthropics/claude-plugins-official
/plugin install superpowers@claude-plugins-official
```

### Recommended

These tools enhance the skills but are not required. Each skill degrades
gracefully when a tool is missing — see `docs/tools-reference.md` for
fallbacks.

| Tool | Install | What it unlocks |
|---|---|---|
| [CodeGraph](https://www.npmjs.com/package/@colbymchenry/codegraph) | `mise use --global npm:@colbymchenry/codegraph` + `codegraph init` per project | Structural code analysis (dependency graphs, symbol lookups) |
| [Engram](https://github.com/Gentleman-Programming/engram) | `brew install gentleman-programming/tap/engram` | Persistent memory across sessions |
| [context-mode](https://github.com/mksglu/context-mode) | `mise use --global npm:context-mode` | Sandboxed code execution + FTS5 knowledge base |
| [mise](https://mise.jdx.dev) | `brew install mise` | Canonical task runner (`mise tasks`) |
| ripgrep, bat, eza, fd | `brew install ripgrep bat eza fd` | Modern Unix tools for fast search and file viewing |

One-shot recommended tools install:

```bash
brew install mise ripgrep bat eza fd
mise use --global npm:@colbymchenry/codegraph npm:context-mode
brew install gentleman-programming/tap/engram
```

## Installation

### Option 1: npx CLI Installer (copies skills into project)

The installer auto-detects your client (OpenCode, Claude Code, or
`.agents/` cross-agent standard) based on which config directory exists.
You can override with `--client`.

**OpenCode (auto-detected if `.opencode/` exists):**

```bash
npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git
```

Copies to `.opencode/skills/`.

**Claude Code:**

```bash
npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git --client claude
```

Copies to `.claude/skills/`.

**Cross-agent (`.agents/` — works with Claude Code, Cursor, Cline, etc.):**

```bash
npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git --client agents
```

Copies to `.agents/skills/`.

Flags:
- `--client <c>` — target client: `opencode`, `claude`, or `agents` (default: auto-detect)
- `--force` — overwrite existing skill directories
- `--list` — list available skills without installing
- `--path <dir>` — target project root (default: cwd)
- `--core-only` — skip the optional `project-onboarding` skill

### Option 2: OpenCode Plugin (auto-discover, zero copies)

Add to your `opencode.json`:

```json
{
  "plugin": [
    "superpowers@git+https://github.com/obra/superpowers.git",
    "@e-van/skills@git+https://github.com/icampana/e-van-opencode.git"
  ]
}
```

Skills stay in `node_modules` and auto-update on reinstall. They cannot be
customized per-project.

### Option 3: Claude Code Marketplace Plugin

```
/plugin marketplace add icampana/e-van-opencode
/plugin install e-van-skills@e-van-skills
```

Skills stay in the plugin cache and auto-update on reinstall.

### Option 4: Symlink (for this repo)

Already configured via symlinks in `.opencode/skills/` pointing to
`packages/skills/skills/*`. Use `sync-config.sh --symlink` to sync to
`~/.config/opencode/skills/`.

## Skills

### building-domain-context (Core)

**Triggers:** "grill me on the domain", "define the terms", starting a new
project/epic with novel business logic.

**Workflow:**
1. Sync context (Engram + CodeGraph + existing docs)
2. Grilling phase — ask 1-2 targeted questions at a time, no code
3. Glossary phase — extract ubiquitous language (nouns/verbs)
4. Documentation phase — write `docs/CONTEXT.md`, create ADRs if needed
5. Memory phase — `mem_save` the glossary
6. Handoff to `brainstorming` → `writing-plans`

### architecture-scan (Core)

**Triggers:** "review architecture", "find tech debt", "refactor",
"architecture scan".

**Workflow:**
1. Sync context (Engram + ADRs + CONTEXT.md)
2. Investigation — scan for balls of mud, shallow modules, DRY violations
   using CodeGraph + ripgrep + eza
3. Reporting — present 1-3 prioritized bottlenecks (current vs ideal)
4. Hard stop — ask user which to tackle
5. Handoff to `using-git-worktrees` → `writing-plans` → `test-driven-development`

### running-the-gauntlet (Core)

**Triggers:** "prove it works", "run the gauntlet", core feature
implementation, high-stakes code (money, auth, data integrity, concurrency).

**Workflow:**
1. Sync context (Engram for prior specs/evidence)
2. Spec phase — write concrete spec, **hard stop** for Yes/No approval
3. TDD loop — strict RED → GREEN → REFACTOR
4. Gauntlet phase — 6 checks: full suite, suite health (random order),
   changed-line coverage, types & lint, mutation testing, real execution
5. Evidence phase — generate `EVIDENCE.md` with raw numbers, `mem_save` evidence

### project-onboarding (Optional/Auxiliary)

**Triggers:** "onboard a project", "set up AI workflow", "initialize project
for AI", starting work on a repo with no `AGENTS.md`.

**Workflow:**
1. Pre-flight check — scan for existing config files
2. Create `AGENTS.md` from template (detect stack, git flow, conventions)
3. Set up `mise.toml` with canonical task definitions
4. Initialize CodeGraph (`codegraph init`)
5. Seed Engram memory (project inventory + tech stack, pin it)
6. Create `docs/CONTEXT.md` stub
7. Create `CHANGELOG.md`
8. Verify all steps (`mise tasks`, `codegraph_status`, `mem_context`)
9. Handoff to `building-domain-context` or `brainstorming`

## Golden Rules

All skills enforce the team's 9 golden rules. See
[`docs/golden-rules.md`](docs/golden-rules.md) for the full list and how
each skill enforces them.

## Documentation

- [`docs/tools-reference.md`](docs/tools-reference.md) — Tool install
  commands, usage, and graceful degradation
- [`docs/golden-rules.md`](docs/golden-rules.md) — The 9 golden rules and
  skill enforcement matrix
- [`docs/agents-template.md`](docs/agents-template.md) — AGENTS.md template
  for project onboarding

## License

MIT