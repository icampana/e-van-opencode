# Changelog

## [Unreleased]
### Added
- `@e-van/skills` package: distributable skills for OpenCode + Superpowers
  - `building-domain-context` skill (Core): DDD ubiquitous language before brainstorming
  - `architecture-scan` skill (Core): tech debt detection + TDD refactor handoff
  - `running-the-gauntlet` skill (Core): evidence-first development for high-stakes code
  - `project-onboarding` skill (Optional): project setup following the AI workflow guide
- Root `package.json` for git-based `npx` and opencode plugin installation
- `packages/skills/plugin.js`: opencode plugin (auto-registers skills path)
- `packages/skills/bin/install.js`: npx CLI installer with `--force`, `--list`, `--path`, `--core-only` flags
- `packages/skills/docs/`: tools-reference, golden-rules, agents-template reference docs
- Symlinks in `.opencode/skills/` for local skill discovery