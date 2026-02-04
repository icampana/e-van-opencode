# OpenCode Settings Repository

A comprehensive collection of OpenCode settings designed as a **global configuration** for all your projects, with support for per-project customization.

## 📋 Overview

This repository provides a **global-first approach** to OpenCode configurations:

- **🌍 Global Configuration**: One central config for all your projects
- **🔄 Stay in Sync**: Update once, applies everywhere
- **🎯 Per-Project Extensions**: Add project-specific rules when needed
- **👥 Team Sharing**: Share configurations across your team
- **📦 Comprehensive**: Agents, sub-agents, skills, and commands included

### What's Included

- **Main AGENTS.md**: Core agent behavior and principles
- **Custom Agents**: Specialized agents for specific technologies
- **Sub-Agents**: Focused agents for specialized tasks
- **Skills**: Reusable capabilities (Code Review, Git, Debugging)
- **Commands**: Quick reference guides (Testing, Setup, Quality Checks)

## 🚀 Quick Start

### 1. Install as Global Configuration (Recommended)

Set up once, use everywhere:

```bash
# Clone the repository
git clone https://github.com/icampana/e-van-opencode.git
cd e-van-opencode

# Run global setup
./setup-global.sh
```

This installs the configuration to `~/.opencode/` and sets up your environment.

### 2. Apply to Your Projects

For each project:

```bash
cd /path/to/your/project

# Run project setup helper
~/.opencode/setup-project.sh
```

Choose:
- **Symlink** (recommended): Stays in sync with global config
- **Copy**: Allows per-project customization
- **Reference**: Use global without local files

### 3. Install Required Tools (Optional)

```bash
# Install recommended CLI tools (bat, rg, sd, eza)
./install-tools.sh
```

**Learn more:** See [GLOBAL_CONFIG.md](GLOBAL_CONFIG.md) for detailed global configuration guide.

---

### Alternative: Per-Project Setup

If you prefer to copy configurations to individual projects:

1. **Clone or Fork**: Copy this repository to use as a template for your team
2. **Customize**: Modify the configurations to match your team's needs
3. **Share**: Team members can reference these configurations in their OpenCode setup

### Applying to Your Project

To use these settings in your project:

```bash
# Option 1: Copy the .github/agents directory to your project
cp -r .github/agents /path/to/your/project/.github/

# Option 2: Reference this repository as a shared resource
# Your team can link to specific files for guidance
```

## 📁 Repository Structure

```
.github/agents/
├── AGENTS.md                    # Main agent configuration
├── python-expert.md             # Python custom agent
├── javascript-expert.md         # JavaScript/TypeScript custom agent
├── documentation-expert.md      # Documentation custom agent
├── sub-agents/
│   ├── test-writer.md          # Test writing specialist
│   ├── bug-hunter.md           # Bug finding and fixing
│   └── refactoring-specialist.md  # Code refactoring
├── skills/
│   ├── code-review.md          # Code review guidelines
│   ├── git-workflow.md         # Git commands and workflows
│   └── debugging.md            # Debugging techniques
└── commands/
    ├── quick-test.md           # Test commands for all frameworks
    ├── project-setup.md        # Project bootstrapping
    └── code-quality-check.md   # Linting and formatting
```

## 🌍 Global vs Per-Project Configuration

### Global Configuration (Recommended)

✅ **Benefits:**
- Update once, applies to all projects
- Consistent standards across your work
- Less duplication and maintenance
- Easy to share with team

📖 **Full Guide:** [GLOBAL_CONFIG.md](GLOBAL_CONFIG.md)

### Per-Project Configuration

✅ **Use when:**
- Project has unique requirements
- Working with different teams
- Need isolation from global changes
- Client-specific standards

You can also **combine both**: Use global config with project-specific extensions in `AGENTS_PROJECT.md`.

### Main Agent Configuration (AGENTS.md)

The core agent behavior definition with a Principal Software Architect approach:
- **Anti-Sycophancy**: Push back against bad ideas with better alternatives
- **Context-First**: Stack-agnostic until code is read, adapts to project conventions
- **Adaptive Memory Bank**: Uses docs/AI_CONTEXT.md for project knowledge
- **TDD-First Protocol**: Red-Green-Refactor methodology
- **Preferred CLI Tools**: bat, rg (ripgrep), sd for precision
- **Agent Delegation**: Multi-agent orchestration system
- **Structured Handoff**: Conventional commits and changelog updates

### Custom Agents

Specialized agents with deep domain knowledge:

#### Python Expert
- PEP 8 and PEP 257 compliance
- Type hints and modern Python
- pytest testing patterns
- Common tools (black, pylint, mypy)

#### JavaScript/TypeScript Expert
- Modern ES6+ and TypeScript
- React, Node.js patterns
- Testing with Jest/Vitest
- Common tools (ESLint, Prettier)

#### Documentation Expert
- Technical writing best practices
- Documentation types (README, API docs, tutorials)
- Markdown formatting
- Code example patterns

### Sub-Agents

Focused agents for specific tasks:

#### Test Writer
- Unit and integration testing
- Test patterns by language
- Mocking guidelines
- Coverage strategies

#### Bug Hunter
- Systematic debugging process
- Common bug patterns
- Debugging tools by language
- Root cause analysis

#### Refactoring Specialist
- Refactoring catalog
- Code smell detection
- Safe refactoring process
- Before/after examples

### Skills

Reusable capabilities that can be applied across projects:

#### Code Review
- Comprehensive checklist
- Review guidelines
- Common issues to catch
- Constructive feedback templates

#### Git Workflow
- Common git commands
- Branch management
- Commit message conventions
- Troubleshooting guide

#### Debugging
- Debugging process
- Tools by language
- Common issues and solutions
- Best practices

### Commands

Quick reference guides for common tasks:

#### Quick Test
- Test commands for all major frameworks
- Language-specific examples
- Framework detection
- CI/CD integration

#### Project Setup
- Bootstrap new projects
- Configuration files
- Docker setup
- Best practices

#### Code Quality Check
- Linters and formatters by language
- Pre-commit hooks
- CI configuration
- Universal check scripts

## 🛠️ Customization

### For Your Team

1. **Fork this repository** to create your team's version
2. **Modify AGENTS.md** to include team-specific coding standards
3. **Add custom agents** for your technology stack
4. **Create custom commands** for your workflows
5. **Update README** with your team's guidelines

### Adding New Content

#### Adding a Custom Agent

Create a new file in `.github/agents/`:

```markdown
# [Technology] Expert

You are an expert in [technology] with deep knowledge of...

## Core Responsibilities
...

## Key Skills
...

## When to Use This Agent
...
```

#### Adding a Skill

Create a new file in `.github/agents/skills/`:

```markdown
# [Skill Name] Skill

This skill helps [purpose]

## Purpose
...

## Process
...

## Usage
...
```

#### Adding a Command

Create a new file in `.github/agents/commands/`:

```markdown
# [Command Name] Command

[Description]

## Purpose
...

## Commands
...

## Usage
...
```

## 📖 How to Use

### For Developers

Reference specific guides when needed:

```bash
# Need to debug an issue?
cat .github/agents/skills/debugging.md

# Setting up a new project?
cat .github/agents/commands/project-setup.md

# Writing tests?
cat .github/agents/sub-agents/test-writer.md
```

### For OpenCode Integration

These configurations can be referenced by OpenCode to:
- Understand your team's best practices
- Follow your coding standards
- Use your preferred tools and workflows
- Apply consistent patterns across projects

### For Team Onboarding

New team members can:
1. Review AGENTS.md for overall principles
2. Study relevant custom agents for their work
3. Learn from skills documentation
4. Reference commands for daily tasks

## 🤝 Contributing

### Adding Content

1. Create new agents, skills, or commands following existing patterns
2. Keep content focused and actionable
3. Include practical examples
4. Update this README if adding new categories

### Improving Existing Content

1. Fix errors or outdated information
2. Add missing tools or frameworks
3. Enhance examples and explanations
4. Share lessons learned

## 📝 Best Practices

### When Creating Configurations

- **Be Specific**: Include exact commands and examples
- **Be Practical**: Focus on real-world usage
- **Be Consistent**: Follow the established format
- **Be Complete**: Cover common scenarios thoroughly

### When Using Configurations

- **Start Simple**: Don't try to use everything at once
- **Adapt**: Customize for your specific needs
- **Share**: Contribute improvements back
- **Iterate**: Refine based on experience

## 🔗 Resources

### Learn More About OpenCode

- OpenCode documentation
- OpenCode best practices
- Community examples

### Related Tools

- Git documentation
- Testing frameworks
- Linting tools
- CI/CD platforms

## 📄 License

This repository is provided under the MIT License. Feel free to use, modify, and share these configurations with your team.

## 🌟 Credits

Created based on experience with OpenCode and software development best practices. Contributions welcome!

---

## Quick Navigation

- [Global Configuration Guide](GLOBAL_CONFIG.md)
- [Getting Started](GETTING_STARTED.md)
- [Example Usage](EXAMPLES.md)
- [Contributing](CONTRIBUTING.md)
- [Main Agent Config](.github/agents/AGENTS.md)
- [Quick Reference Index](.github/agents/INDEX.md)

**Happy Coding! 🚀**
