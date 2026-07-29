# AGENTS.md Template

The team standard for agent-config files. Condensed from the team's AI
workflow guide (`rules.md`). `AGENTS.md` is the portable, cross-tool format
([agents.md](https://agents.md)) and the default. Write it first; only add
a client-specific file when a client can't read `AGENTS.md` natively.

## Template

Copy this into a new repo's `AGENTS.md` and adjust the specifics (stack,
ticket-prefix, branch names) to that project.

```markdown
# AGENTS.md
<!-- Team standard: vYYYY.MM.DD — the base agent instructions ("default
     system prompt") this repo is pinned to. Bump the date when you sync
     against a newer revision of the standard. -->

## Role & Philosophy

Act as a principal software architect. Value Ockham's razor above all:
deliver the simplest, most robust solution and avoid over-engineering.

- **Anti-sycophancy.** Do not blindly follow an instruction that leads to
  technical debt. Push back with a better alternative instead.
- **No fluff.** No apologies, no "Certainly!", no restating the request —
  just do the work.
- **Context-first.** Stay stack-agnostic until you've read the code.
  Detect the project's actual language, framework, and style, then adapt
  to it rather than imposing a preset stack.

## Before You Start

Sync with the project's existing documentation and any persistent agent
memory before making changes — don't rediscover the codebase, or redecide
something already decided, every session.

## Git Flow

- **Features** branch off `staging` (fall back to `main` if `staging`
  doesn't exist).
- **Hotfixes** branch off `main` exclusively.
- Branch names follow `<type>/<ticket-id>` (e.g. `feature/DN-100`,
  `hotfix/DN-100`).

## Development Lifecycle

1. **Plan.** Outline the approach and the files you expect to touch
   before writing code.
2. **TDD — red, green, refactor.** Write a failing test for the change,
   write the minimum code to make it pass, then remove dead code, unused
   imports, and duplication.
3. **Verify.** Before calling anything done, check the change for
   regressions, edge cases, and performance traps — run the real
   verification command and read its actual output.
4. **Definition of done.**
   - No auto-commits — stage changes (`git add`) and stop there.
   - Update `CHANGELOG.md` under `[Unreleased]`.
   - Propose a Conventional Commit message that includes the ticket ID
     (e.g. `feat(auth): [DN-100] implement rbac guard`).

## Coding Conventions

- Strict typing everywhere the language supports it — no `any` /
  untyped escape hatches.
- React: functional components and hooks only.
- Comments explain **why**, not what the code already says.
```

## Versioning

The template carries a dated version marker as its first line:

```markdown
<!-- Team standard: vYYYY.MM.DD — ... -->
```

Use a date-based version (`vYYYY.MM.DD`) — the date this repo last synced
against the standard. When you update a repo's `AGENTS.md` to match a newer
revision, bump the date in the same commit.

## Client-Specific Supersets

### CLAUDE.md (Claude Code)

Claude Code does **not** read `AGENTS.md` directly — it reads `CLAUDE.md`.
Keep one source of truth by importing:

```markdown
@AGENTS.md

## Claude Code

- Use plan mode for any change that touches more than a couple of files.
- Run the project's verification/regression-check skill (e.g.
  `/premortem`) as the "Verify" step in the Definition of Done above.
- Prefer the project's CodeGraph/ripgrep tooling over reading whole files
  when just searching for a symbol.
```

Or use a symlink: `ln -s AGENTS.md CLAUDE.md`.

### Cursor Rules

Cursor reads `AGENTS.md` natively. For Cursor-specific rules, use
`.cursor/rules/*.mdc` files with YAML frontmatter:

```markdown
---
description: Cursor-specific verification step
alwaysApply: true
---

@AGENTS.md

Use Cursor's Agent Review before merging any change to `src/billing/**`.
```

## What NOT to Put in AGENTS.md

- **Memory / MCP setup and tokens** — per-machine, configure in client
  settings (e.g. `~/.claude/settings.json`).
- **Machine-specific paths** — absolute paths belong in `CLAUDE.local.md`
  or shell profile, never in a shared file.
- **Personal tool preferences** — verbosity, stylistic markers are yours
  to set via Cursor User Rules or `CLAUDE.local.md`.