# OpenCode Shared Configuration

A shared OpenCode configuration repository for team-wide consistency, following OpenCode's best practices.

## 📋 Structure

```
e-van-opencode/
├── .opencode/          # Agent definitions (per-project scope)
│   └── agents/         # Markdown agent files
├── docs/               # Documentation & reference
│   └── AGENTS.md       # Main rules file
├── opencode.json       # OpenCode config
├── sync-config.sh      # Sync script for ~/.config/opencode/
└── README.md
```

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/icampana/e-van-opencode.git
cd e-van-opencode
```

### 2. Sync to OpenCode Config

```bash
# Copy configuration to ~/.config/opencode/
./sync-config.sh
```

This syncs:
- `opencode.json` → `~/.config/opencode/opencode.json`
- `docs/AGENTS.md` → `~/.config/opencode/AGENTS.md`
- `.opencode/agents/*.md` → `~/.config/opencode/agents/`

### 3. Pull Updates

```bash
git pull
./sync-config.sh
```

## 🔗 Options

### Use Symlinks (Recommended for Active Development)

Stay in sync automatically:

```bash
./sync-config.sh --symlink
```

### Skip Backup

```bash
./sync-config.sh --no-backup
```

## 📦 Available Agents

| Agent | Mode | Description |
|-------|------|-------------|
| `ui-engineer` | primary | Frontend, CSS, Accessibility |
| `python-backend-engineer` | primary | Python backend patterns |
| `devops-engineer` | primary | CI/CD, K8s, Terraform |
| `postgresql-expert` | subagent | SQL optimization |
| `security-reviewer` | subagent | OWASP security audit |
| `docker-expert` | subagent | Docker & containers |
| `github-actions-expert` | subagent | GitHub Actions workflows |
| `nextjs-expert` | subagent | Next.js best practices |
| `astro-expert` | subagent | Astro framework |
| `senior-code-reviewer` | subagent | Code review |

## 📖 How It Works

OpenCode looks for configuration in this order:

1. **Local rules**: `AGENTS.md` in current directory (not used here)
2. **Global rules**: `~/.config/opencode/AGENTS.md` 
3. **Agents**: `~/.config/opencode/agents/*.md`

This repo provides content for steps 2 & 3 via `sync-config.sh`.

## 🛠️ Customization

1. Fork this repository
2. Modify agents in `.opencode/agents/`
3. Update `docs/AGENTS.md` with your team's standards
4. Share with your team

## 📚 References

- [OpenCode Rules Docs](https://opencode.ai/docs/rules/)
- [OpenCode Agents Docs](https://opencode.ai/docs/agents/)
