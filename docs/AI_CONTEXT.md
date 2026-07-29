# AI Context — e-van-opencode

> Auto-generated architectural context. Run `@analyze-context` to refresh.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Shell (sync-config.sh), JavaScript/Node.js (skills installer, plugin) |
| AI Platform | OpenCode (opencode.json, agents, skills, commands) |
| Plugin System | OpenCode plugins + Claude Code marketplace + cross-agent (.agents/) |
| MCP Servers | Serena (code intelligence), CodeGraph (symbol graph), context-mode (context window protection), Engram (persistent memory) |
| Distribution | npm (git-based npx), opencode plugin, symlinks |
| Development Workflow | Superpowers (brainstorming → plans → TDD → verify) |

## Architecture

This is an **AI configuration repository** — not an application. It provides shared OpenCode agent definitions, skills, and workflow guides that teams sync to their local `~/.config/opencode/` directory.

### Directory Map

```
e-van-opencode/
├── .opencode/
│   ├── agents/              # 19 agent definition files (Markdown + YAML frontmatter)
│   │   ├── principal-engineer.md   # Primary — system architecture, TDD, cross-domain
│   │   ├── ui-engineer.md          # Primary — frontend, CSS, A11y
│   │   ├── python-backend-engineer.md  # Primary — FastAPI/Django, type safety
│   │   ├── devops-engineer.md      # Primary — CI/CD, IaC, cloud
│   │   ├── nextjs-expert.md        # Primary — Next.js, RSC, App Router
│   │   ├── astro-expert.md         # Primary — Astro, SSG
│   │   ├── golang-expert.md        # Primary — idiomatic Go, concurrency
│   │   ├── postgresql-expert.md    # Subagent — SQL, schema, perf
│   │   ├── security-reviewer.md    # Subagent — OWASP, vuln scanning
│   │   ├── docker-expert.md        # Subagent — Docker, Compose
│   │   ├── github-actions-expert.md # Subagent — CI/CD YAML
│   │   ├── senior-code-reviewer.md # Subagent — code review
│   │   ├── python-expert.md        # Subagent — PEP 8, type hints
│   │   ├── javascript-expert.md     # Subagent — JS/TS, Node.js
│   │   ├── refactoring-specialist.md # Subagent — safe refactoring
│   │   ├── test-writer.md          # Subagent — TDD tests
│   │   ├── bug-hunter.md           # Subagent — root cause analysis
│   │   └── documentation-expert.md # Subagent — docs, README
│   ├── skills/              # Skills (symlinks to packages/skills/ + local)
│   └── commands/            # Custom slash commands
│       └── analyze-context.md
├── docs/
│   ├── AGENTS.md            # Master agent rules (loaded globally by OpenCode)
│   └── adr/                 # Architecture Decision Records
├── packages/
│   └── skills/              # @e-van/skills — distributable skills package
│       ├── skills/          # 4 skill definitions (SKILL.md each)
│       ├── bin/install.js   # npx CLI installer
│       ├── docs/            # Reference docs (golden-rules, tools-reference, agents-template)
│       └── plugin.js        # OpenCode plugin entry
├── opencode.json            # OpenCode MCP + plugin configuration
├── package.json             # Root package (git-based npx install)
├── sync-config.sh           # Sync to ~/.config/opencode/
└── README.md
```

### Key Modules

1. **Agent Definitions** (`.opencode/agents/*.md`): 19 Markdown files with YAML frontmatter (`description`, `mode`, `temperature`, `tools`, `permission`). Each defines a specialized persona with instructions, constraints, and domain expertise.

2. **Master Rules** (`docs/AGENTS.md`): The global AGENTS.md loaded by OpenCode. Defines the Principal Software Architect persona ("e-van"), golden rules, adaptive discovery, editing protocol, TDD execution loop, agent delegation, superpowers workflow, and commit conventions.

3. **Skills Package** (`packages/skills/`): Installable via `npx @e-van/skills@git+...`. Contains 4 workflow skills (building-domain-context, architecture-scan, running-the-gauntlet, project-onboarding) with multi-client support.

4. **Sync Script** (`sync-config.sh`): Copies or symlinks config files to `~/.config/opencode/`. Supports `--symlink`, `--no-backup` flags.

5. **OpenCode Config** (`opencode.json`): MCP server registration (Serena, CodeGraph, context-mode, Engram), plugin paths, and skill directories.

## Conventions

- **Agent Frontmatter**: YAML with `description`, `mode` (primary|subagent), `temperature` (0.1), `tools`, `permission`.
- **Conventional Commits**: `feat()`, `fix()`, with scope in parentheses.
- **Markdown**: Agents use standard markdown with structured section headers.
- **Skills**: Each skill has a `SKILL.md` with description, instructions, and integration points for CodeGraph, Engram, context-mode, and mise.
- **ADR**: Architecture decisions tracked in `docs/adr/`.
- **Superpowers**: Skills enforce the golden rules (brainstorming → plans → TDD → verify).

## Known Technical Debt / Watchlist

- `docs/AI_CONTEXT.md` must be manually refreshed via `@analyze-context` command (no auto-sync).
- Skills package installer (`bin/install.js`) auto-detects client but does not validate installed skill compatibility across client versions.
- `opencode.json` MCP configs are environment-specific (API keys, paths) — sync to `~/.config/opencode/` may require manual adjustment.