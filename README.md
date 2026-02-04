# OpenCode Settings Repository

A comprehensive collection of OpenCode settings, custom agents, sub-agents, skills, and commands to share with your team and improve development workflows.

## 📋 Overview

This repository provides a structured way to share OpenCode configurations including:

- **Main AGENTS.md**: Core agent behavior and principles
- **Custom Agents**: Specialized agents for specific technologies (Python, JavaScript, Documentation)
- **Sub-Agents**: Focused agents for specialized tasks (Test Writing, Bug Hunting, Refactoring)
- **Skills**: Reusable capabilities (Code Review, Git Workflow, Debugging)
- **Commands**: Quick reference guides (Testing, Project Setup, Code Quality)

## 🚀 Quick Start

### Using This Repository

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

## 🎯 What's Included

### Main Agent Configuration (AGENTS.md)

The core agent behavior definition including:
- Core principles (minimal changes, test-driven, security first)
- Agent capabilities (analysis, development, validation)
- Standard workflow (understand, plan, implement, validate, review)
- Tool usage guidelines
- Best practices for code changes and testing

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

- [Main Agent Config](.github/agents/AGENTS.md)
- [Custom Agents](.github/agents/)
- [Sub-Agents](.github/agents/sub-agents/)
- [Skills](.github/agents/skills/)
- [Commands](.github/agents/commands/)

**Happy Coding! 🚀**
