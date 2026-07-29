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