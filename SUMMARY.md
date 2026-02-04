# Repository Summary

This repository provides a complete OpenCode configuration system designed as a **global configuration** for all your development projects.

## 📦 What's Included

### Core Configuration Files

- **AGENTS.md** - Main agent configuration with Principal Software Architect persona
  - Anti-sycophancy approach
  - Context-first development
  - TDD-first execution protocol
  - Agent delegation system

### Custom Agents (6)

- **python-expert.md** - Python development specialist
- **javascript-expert.md** - JavaScript/TypeScript expert
- **documentation-expert.md** - Technical writing specialist

### Sub-Agents (3)

- **test-writer.md** - Comprehensive test writing
- **bug-hunter.md** - Systematic debugging
- **refactoring-specialist.md** - Code quality improvement

### Skills (3)

- **code-review.md** - Code review guidelines
- **git-workflow.md** - Git commands and workflows
- **debugging.md** - Debugging techniques

### Commands (3)

- **quick-test.md** - Testing commands for all frameworks
- **project-setup.md** - Project bootstrapping guides
- **code-quality-check.md** - Linting and formatting

### Documentation

- **README.md** - Main overview and quick start
- **GETTING_STARTED.md** - Detailed onboarding guide
- **GLOBAL_CONFIG.md** - Global configuration explanation
- **EXAMPLES.md** - Real-world usage scenarios
- **CONTRIBUTING.md** - Contribution guidelines
- **INDEX.md** - Quick reference navigation

### Setup Scripts

- **setup-global.sh** - Install as global configuration
- **install-tools.sh** - Install recommended CLI tools (bat, rg, sd, eza)
- **TEMPLATE.md** - Template for creating custom agents

## 🎯 Design Philosophy

This repository follows a **global-first** approach:

1. **One central configuration** for all your projects
2. **Symlink to projects** to stay in sync
3. **Optional per-project extensions** for customization
4. **Easy updates** - change once, applies everywhere

## 🚀 Quick Start

```bash
# 1. Clone repository
git clone https://github.com/icampana/e-van-opencode.git
cd e-van-opencode

# 2. Install as global config
./setup-global.sh

# 3. Install CLI tools (optional)
./install-tools.sh

# 4. Apply to a project
cd /path/to/your/project
~/.opencode/setup-project.sh
```

## 📊 Statistics

- **15 configuration files** in `.github/agents/`
- **6 custom agents** for different technologies
- **3 sub-agents** for specialized tasks
- **3 skills** for common workflows
- **3 command references** for quick lookups
- **7 documentation files** for guidance
- **2 setup scripts** for easy installation

## 🌍 Use Cases

### Solo Developer
- Consistent standards across all personal projects
- Update once, applies everywhere
- Easy to maintain

### Team
- Share configurations across team members
- Enforce consistent coding standards
- Collaborative improvement

### Multiple Clients
- Global baseline configuration
- Per-client customizations
- Easy to switch contexts

## 📚 Key Features

### Context-First Approach
- Adapts to project conventions
- Uses `docs/AI_CONTEXT.md` for project memory
- Stack-agnostic until code is analyzed

### TDD-First Protocol
- Red-Green-Refactor methodology
- Write tests before implementation
- Validate all changes

### Anti-Sycophancy
- Push back on bad ideas
- Suggest simpler alternatives
- Focus on technical excellence

### Multi-Agent System
- Specialized agents for different domains
- Orchestration between agents
- Respect domain expertise

## 🔧 Recommended Tools

The configuration references these CLI tools:

- **bat** - Enhanced file viewer with syntax highlighting
- **rg (ripgrep)** - Fast search across files
- **sd** - Simple find and replace
- **eza** - Modern directory listing

Install with: `./install-tools.sh`

## 📖 Next Steps

1. Read [GLOBAL_CONFIG.md](GLOBAL_CONFIG.md) for global setup details
2. See [GETTING_STARTED.md](GETTING_STARTED.md) for step-by-step guide
3. Browse [EXAMPLES.md](EXAMPLES.md) for real-world scenarios
4. Check [INDEX.md](.github/agents/INDEX.md) for quick navigation
5. Review [AGENTS.md](.github/agents/AGENTS.md) for core principles

## 🤝 Contributing

Want to improve this configuration?

1. Fork the repository
2. Add your improvements
3. Follow [CONTRIBUTING.md](CONTRIBUTING.md) guidelines
4. Share with the community

## 📄 License

MIT License - Use freely in your projects

---

**Created:** 2026-02-04
**Purpose:** Share OpenCode best practices and configurations
**Approach:** Global-first, with per-project flexibility
