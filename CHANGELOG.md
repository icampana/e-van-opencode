# Changelog

## [Unreleased]
### Added
- `@e-van/skills` package: distributable skills for OpenCode, Claude Code & Superpowers
  - `building-domain-context` skill (Core): DDD ubiquitous language before brainstorming
  - `architecture-scan` skill (Core): tech debt detection + TDD refactor handoff
  - `running-the-gauntlet` skill (Core): evidence-first development for high-stakes code
  - `project-onboarding` skill (Optional): project setup following the AI workflow guide
- Root `package.json` for git-based `npx` and opencode plugin installation
- `packages/skills/plugin.js`: opencode plugin (auto-registers skills path)
- `packages/skills/bin/install.js`: npx CLI installer with `--client`, `--force`, `--list`, `--path`, `--core-only` flags
- `packages/skills/.claude-plugin/`: Claude Code plugin manifest (plugin.json + marketplace.json)
- `packages/skills/.agents/plugins/marketplace.json`: cross-agent marketplace for skills.sh CLI
- `packages/skills/docs/`: tools-reference, golden-rules, agents-template reference docs
- Symlinks in `.opencode/skills/` for local skill discovery
- Multi-client support: OpenCode (`.opencode/skills/`), Claude Code (`.claude/skills/`), cross-agent (`.agents/skills/`)
- `golang-expert` agent for idiomatic Go development, effective concurrency, and standard library first
- `dsearch` skill recommendation in README for local documentation lookup
- Reference to Python and Go backend standards in `docs/AGENTS.md`
- `docs/GSD_WORKFLOW.md`: GSD + OpenCode integration workflow guide

### Removed
- GSD (Get Shit Done) integration — replaced with Superpowers as the main development workflow
- `docs/GSD_WORKFLOW.md` (replaced by Superpowers section in README)
- GSD Protocol section from `docs/AGENTS.md`

### Changed (post-GSD)
- `docs/AGENTS.md` rewritten to align with docs-hub recommendations: version marker, golden rules, superpowers skill chain, simplified structure
- README.md GSD section replaced with Superpowers workflow section

### Changed
- Refined agent role and protocol descriptions in `docs/AGENTS.md` for clarity and precision
- Clarified Serena MCP protocol and restructured sections in `docs/AGENTS.md`
- Updated `principal-engineer` permissions to allow git branch commands

### Fixed
- Removed deprecated MCP `context7` and `read-website-fast` configurations from `opencode.json`
- Corrected typos in `docs/AGENTS.md` for clarity and consistency
- Fixed `principal-engineer` permissions for git commands