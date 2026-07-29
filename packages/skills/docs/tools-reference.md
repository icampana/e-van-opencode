# Tools Reference

Condensed from the team's AI workflow guide. Each skill in this package
integrates these tools. When a tool is absent, use the listed fallback.

## CLI Tools

| Tool | Replaces | Why | Install |
|---|---|---|---|
| `rg` (ripgrep) | `grep` | Respects `.gitignore`, recurses by default, fast | `brew install ripgrep` |
| `bat` | `cat` | Syntax highlighting, `bat -p` for plain agent-parseable output | `brew install bat` |
| `eza` | `ls` | Colorized, git-aware, tree view (`eza --tree -L 3`) | `brew install eza` |
| `fd` | `find` | Fast, ignores gitignored paths, sane syntax | `brew install fd` |
| `sd` | `sed` | Intuitive find-and-replace without sed regex quirks | `brew install sd` |
| `jq` | — | JSON processor for parsing tool output | `brew install jq` |
| `gh` | — | GitHub CLI for PRs, issues, checks | `brew install gh` |

One-shot install:

```bash
brew install ripgrep bat eza fd sd jq gh
```

**Agent-emitted commands:** `rg`, `bat -p`, `eza`, `fd`, `sd`, `jq`, `gh` —
structured, script-friendly output.

**Fallbacks:** If any tool is missing, fall back to the Unix equivalent
(`grep`, `cat`, `ls`, `find`, `sed`). The skills degrade gracefully.

## mise (Task Runner)

[mise](https://mise.jdx.dev) is the team standard for runtime versions and
canonical task definitions. A project's real entry points — test, lint, build,
deploy — should be declared as mise tasks in `mise.toml`:

```toml
[tasks.test]
description = "Run the test suite"
run = "pytest -q"

[tasks.lint]
description = "Run the linter"
run = "ruff check ."

[tasks.typecheck]
description = "Run the type checker"
run = "tsc --noEmit"
```

An agent that can run `mise tasks` learns the project's canonical commands
instead of guessing at `npm run` vs `pytest` vs a bespoke script.

**Fallback:** If mise isn't installed or no `mise.toml` exists, detect the
project's test runner directly (`pytest`, `jest`, `npm test`, `go test`,
`cargo test`, etc.) and use it.

## MCP Servers

### CodeGraph

**Unlocks:** Tree-sitter-parsed knowledge graph of every symbol, edge, and
file. Sub-millisecond structural lookups that grep can't answer.

**Install:**

```bash
mise use --global npm:@colbymchenry/codegraph
```

Per project:

```bash
codegraph init
```

**Key tools:**
- `codegraph_explore` — focused context for a task/area (PRIMARY — call first)
- `codegraph_impact` — what would break if I changed X
- `codegraph_callees` — what does X call
- `codegraph_callers` — what calls X
- `codegraph_search` — find symbol by name
- `codegraph_files` — indexed file tree

**Fallback:** If CodeGraph isn't initialized, offer `codegraph init`. If the
user declines or it's unavailable, fall back to `rg` + `glob` + `read` for
structural analysis. The skills work without CodeGraph — just slower.

### Engram (Persistent Memory)

**Unlocks:** Decisions, bugs, conventions, and architecture notes survive
across sessions and context compaction. Backed by local SQLite + FTS5.

**Install:**

```bash
brew install gentleman-programming/tap/engram
```

**Key tools:**
- `mem_context` — recent session history (call at session start)
- `mem_search` — find prior decisions, bugs, or context by keyword
- `mem_save` — persist a decision, bug fix, discovery, or convention
- `mem_get_observation` — expand full content of a search hit
- `mem_session_summary` — end-of-session summary before declaring done

**Fallback:** If Engram isn't available, skills fall back to reading
`docs/CONTEXT.md`, `docs/adr/`, and `CHANGELOG.md` directly for prior context.
Memory persistence is lost but the workflow still functions.

### context-mode

**Unlocks:** Sandboxed code execution (11 languages) plus a persistent FTS5
knowledge base. Large tool output gets processed and searched instead of
dumped into the model's context window.

**Install:**

```bash
mise use --global npm:context-mode
```

**Key tools:**
- `ctx_batch_execute` — run multiple commands, auto-index output, return search
- `ctx_execute` — run code in sandbox, only stdout enters context
- `ctx_execute_file` — analyze a file without reading raw bytes into context
- `ctx_search` — search indexed content and session memory
- `ctx_fetch_and_index` — fetch URL, index content, raw bytes stay out

**Fallback:** If context-mode isn't available, use `bash` directly for smaller
outputs. For large outputs, pipe through `jq` or `rg` to filter before reading.

## LLM vs Human Tool Usage

- **Agent-emitted, in commands:** `rg`, `bat -p` (plain, no decoration),
  `eza`, `fd`, `sd`, `jq`, `gh` — structured, script-friendly output.
- **Mainly human ergonomics:** `tldr`, `delta`, `mdt` — visual/interactive
  experience, not scriptability.