# Global Configuration Guide

This repository is designed to work as a **global OpenCode configuration** that applies to all your projects, with the flexibility to add per-project customizations when needed.

## 🌍 Global Configuration Concept

### Why Global Config?

Instead of copying agent configurations to every project, you maintain one central configuration that:
- **Stays consistent** across all your projects
- **Updates everywhere** when you improve your agents
- **Reduces duplication** - maintain configurations in one place
- **Allows per-project overrides** when needed

### How It Works

```
~/.opencode/                          # Global configuration
├── .github/agents/
│   ├── AGENTS.md                     # Your global agent rules
│   ├── python-expert.md              # Available to all projects
│   ├── javascript-expert.md
│   └── ...
│
/path/to/project-1/                   # Your projects
├── .github/agents/                   # → Symlink to ~/.opencode/.github/agents
│   └── AGENTS_PROJECT.md             # Optional project-specific additions
│
/path/to/project-2/
├── .github/agents/                   # → Symlink to ~/.opencode/.github/agents
│   └── AGENTS_PROJECT.md             # Different project-specific rules
```

## 🚀 Quick Setup

### 1. Install Global Configuration

```bash
# Clone this repository
git clone https://github.com/icampana/e-van-opencode.git
cd e-van-opencode

# Run global setup
./setup-global.sh
```

This will:
- Install configuration to `~/.opencode/`
- Set up environment variables
- Create helper scripts
- Add shell aliases

### 2. Apply to Projects

For each project where you want to use OpenCode:

```bash
cd /path/to/your/project

# Run the project setup helper
~/.opencode/setup-project.sh
```

Choose from three options:
1. **Symlink** (recommended) - stays in sync with global config
2. **Copy** - allows per-project customization
3. **Reference only** - use global config without local files

## 📋 Usage Patterns

### Pattern 1: Pure Global Config (Recommended)

Use the same configuration across all projects:

```bash
# Set up project with symlink
cd my-project
~/.opencode/setup-project.sh
# Choose option 1 (Symlink)

# Result: .github/agents/ → ~/.opencode/.github/agents/
```

**Benefits:**
- All projects use the same agents
- Update once, applies everywhere
- Consistent team standards

**When to use:**
- Most projects in your portfolio
- Team projects with shared standards
- When consistency is important

### Pattern 2: Global + Per-Project Extensions

Use global config but add project-specific rules:

```bash
# Set up project with symlink
cd my-project
~/.opencode/setup-project.sh
# Choose option 1 (Symlink)

# Add project-specific configuration
cat > .github/agents/AGENTS_PROJECT.md << 'EOF'
# Project-Specific Agent Rules

## Additional Rules for This Project

- Use TypeScript strict mode
- Follow company coding standards
- Specific testing requirements
- Custom deployment procedures

## Project Context

This project uses:
- Next.js 14 with App Router
- PostgreSQL with Prisma
- Deployed on Vercel

## Team Conventions

- All API routes must have OpenAPI docs
- E2E tests required for critical flows
EOF
```

**Benefits:**
- Global standards + project needs
- Project-specific context preserved
- Easy to see what's project-specific

**When to use:**
- Projects with unique requirements
- Client projects with specific standards
- Legacy projects with special considerations

### Pattern 3: Per-Project Full Copy

Copy global config and customize extensively:

```bash
# Set up project with copy
cd my-project
~/.opencode/setup-project.sh
# Choose option 2 (Copy)

# Now customize .github/agents/ as needed
nano .github/agents/AGENTS.md
```

**Benefits:**
- Complete control over project config
- No dependency on global config
- Can diverge from team standards if needed

**When to use:**
- Experimental projects
- Projects with very different tech stack
- When isolation is important

## 🔄 Keeping Global Config Updated

### Update Global Configuration

```bash
# Update from repository
opencode-update

# Or manually
cd ~/.opencode
git pull origin main
```

### Sync Projects (if using symlinks)

Projects with symlinks automatically use the updated global config. No action needed!

### Sync Projects (if using copies)

For projects that copied the config, re-run setup:

```bash
cd /path/to/project
~/.opencode/setup-project.sh
# Choose option 2 (Copy) again to overwrite
```

## 📁 Directory Structure

### Global Configuration

```
~/.opencode/
├── .github/agents/
│   ├── AGENTS.md                 # Main agent configuration
│   ├── INDEX.md                  # Quick reference
│   ├── TEMPLATE.md               # Template for new agents
│   ├── python-expert.md          # Language-specific agents
│   ├── javascript-expert.md
│   ├── documentation-expert.md
│   ├── sub-agents/
│   │   ├── test-writer.md
│   │   ├── bug-hunter.md
│   │   └── refactoring-specialist.md
│   ├── skills/
│   │   ├── code-review.md
│   │   ├── git-workflow.md
│   │   └── debugging.md
│   └── commands/
│       ├── quick-test.md
│       ├── project-setup.md
│       └── code-quality-check.md
├── README.md
├── GETTING_STARTED.md
├── EXAMPLES.md
├── CONTRIBUTING.md
└── setup-project.sh              # Helper for setting up projects
```

### Per-Project Configuration (Optional)

```
/path/to/project/
├── .github/agents/               # → Symlink to global OR local copy
│   ├── AGENTS_PROJECT.md         # ✨ Project-specific rules (optional)
│   └── [custom-agent].md         # ✨ Project-specific agents (optional)
└── docs/
    └── AI_CONTEXT.md             # ✨ Generated by agent (per AGENTS.md)
```

## 🎯 Configuration Precedence

When both global and project configurations exist:

1. **Global AGENTS.md** provides the base behavior
2. **Project AGENTS_PROJECT.md** can extend or override
3. **Custom agents** in project override global ones with same name

Example:

```
# Global: ~/.opencode/.github/agents/AGENTS.md
→ Sets TDD-first approach, CLI tools, general workflow

# Project: .github/agents/AGENTS_PROJECT.md
→ Adds: "Use Next.js 14 App Router"
→ Adds: "Follow company ESLint config"
→ Adds: "Deploy via Vercel, not manual"

# Result: Agent uses both, with project rules taking precedence
```

## 🛠️ Environment Variables

### OPENCODE_GLOBAL_DIR

Points to your global configuration:

```bash
export OPENCODE_GLOBAL_DIR="$HOME/.opencode"
```

Set automatically by `setup-global.sh` in your shell RC file.

### Using in Scripts

```bash
# Reference global config in scripts
if [ -n "$OPENCODE_GLOBAL_DIR" ]; then
    echo "Global config: $OPENCODE_GLOBAL_DIR"
    cat "$OPENCODE_GLOBAL_DIR/.github/agents/INDEX.md"
fi
```

## 💡 Pro Tips

### Quick Access Aliases

Added by setup script:

```bash
# View the index
opencode-docs

# Update global config
opencode-update

# View specific agent
cat $OPENCODE_GLOBAL_DIR/.github/agents/python-expert.md
```

### IDE Integration

Add global config to your IDE's workspace settings:

**VS Code** (`.vscode/settings.json`):
```json
{
  "opencode.configPath": "~/.opencode/.github/agents/"
}
```

### Team Sharing

Share your customized global config with your team:

```bash
# Fork the repository
# Customize for your team
# Team members run:
git clone https://github.com/yourteam/opencode-settings.git
cd opencode-settings
./setup-global.sh
```

## 📚 Examples

### Example 1: Solo Developer

```bash
# One-time setup
./setup-global.sh

# For each project
cd ~/projects/web-app
~/.opencode/setup-project.sh    # Choose symlink

cd ~/projects/api-server
~/.opencode/setup-project.sh    # Choose symlink

cd ~/projects/mobile-app
~/.opencode/setup-project.sh    # Choose symlink

# All projects now use the same global config
# Update once, applies to all
```

### Example 2: Team with Standards

```bash
# Team lead sets up shared config
git clone https://github.com/company/opencode-config.git
cd opencode-config
# Customize AGENTS.md with company standards
./setup-global.sh

# Team members do the same
# Everyone shares the same global config
# Enforces consistency across team
```

### Example 3: Multiple Clients

```bash
# Different clients, different standards
# Use per-project copies

cd ~/clients/client-a/project
~/.opencode/setup-project.sh    # Choose copy
# Customize for Client A

cd ~/clients/client-b/project
~/.opencode/setup-project.sh    # Choose copy
# Customize for Client B

# Each client has their own config
# But both started from your global baseline
```

## 🔍 Troubleshooting

### Symlink Not Working

```bash
# Check if symlink exists
ls -la .github/agents

# Should show: .github/agents -> /home/user/.opencode/.github/agents

# If broken, recreate:
rm .github/agents
ln -s ~/.opencode/.github/agents .github/agents
```

### Global Config Not Found

```bash
# Verify installation
ls -la ~/.opencode

# Verify environment variable
echo $OPENCODE_GLOBAL_DIR

# Reinstall if needed
cd /path/to/e-van-opencode
./setup-global.sh
```

### Want to Switch from Copy to Symlink

```bash
cd /path/to/project

# Backup current config (if customized)
mv .github/agents .github/agents.backup

# Create symlink
ln -s ~/.opencode/.github/agents .github/agents

# Merge any custom config
cat .github/agents.backup/AGENTS_PROJECT.md > .github/agents/AGENTS_PROJECT.md
```

## 📖 See Also

- [Getting Started](GETTING_STARTED.md) - Initial setup guide
- [Examples](EXAMPLES.md) - Real-world usage scenarios
- [Contributing](CONTRIBUTING.md) - Improving the global config
- [AGENTS.md](.github/agents/AGENTS.md) - The main configuration

---

[← Back to README](README.md)
