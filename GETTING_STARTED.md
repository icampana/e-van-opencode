# Getting Started with OpenCode Settings

This guide will help you adopt these OpenCode settings for your team or projects.

## 🎯 For Individual Developers

### Quick Setup

1. **Clone or Download**
   ```bash
   git clone https://github.com/icampana/e-van-opencode.git
   cd e-van-opencode
   ```

2. **Browse the Content**
   ```bash
   # View the main configuration
   cat .github/agents/AGENTS.md
   
   # Check the index for quick navigation
   cat .github/agents/INDEX.md
   ```

3. **Apply to Your Projects**
   ```bash
   # Copy to an existing project
   cp -r .github/agents /path/to/your/project/.github/
   
   # Or reference specific guides as needed
   ```

### Daily Usage

**Before Starting Work:**
- Review [AGENTS.md](.github/agents/AGENTS.md) principles
- Check relevant custom agent for your language

**During Development:**
- Reference [skills](.github/agents/skills/) for common tasks
- Use [commands](.github/agents/commands/) for quick lookups

**Before Committing:**
- Run [code quality checks](.github/agents/commands/code-quality-check.md)
- Run [tests](.github/agents/commands/quick-test.md)
- Review changes using [git workflow](.github/agents/skills/git-workflow.md)

## 👥 For Teams

### Team Setup

1. **Fork This Repository**
   ```bash
   # On GitHub, fork icampana/e-van-opencode to your organization
   ```

2. **Customize for Your Team**
   - Update [AGENTS.md](.github/agents/AGENTS.md) with team standards
   - Add agents for your technology stack
   - Create team-specific commands
   - Add project templates

3. **Share with Team**
   - Add to team documentation
   - Include in onboarding materials
   - Reference in code review guidelines

### Team Workflow

**Onboarding New Members:**
1. Share the forked repository
2. Walk through [AGENTS.md](.github/agents/AGENTS.md)
3. Show [INDEX.md](.github/agents/INDEX.md) for navigation
4. Assign reading of relevant agents/skills

**Code Reviews:**
- Reference [code review skill](.github/agents/skills/code-review.md)
- Use checklist from the guide
- Point to specific agents when giving feedback

**Project Setup:**
- Use [project setup commands](.github/agents/commands/project-setup.md)
- Apply team's [AGENTS.md](.github/agents/AGENTS.md) configuration
- Set up [code quality checks](.github/agents/commands/code-quality-check.md)

## 📁 For Projects

### Adding to Existing Projects

1. **Copy Configuration**
   ```bash
   cd your-project
   mkdir -p .github/agents
   cp -r /path/to/e-van-opencode/.github/agents/* .github/agents/
   ```

2. **Customize for Project**
   - Update [AGENTS.md](.github/agents/AGENTS.md) with project specifics
   - Remove irrelevant agents
   - Add project-specific commands

3. **Set Up Automation**
   ```bash
   # Add pre-commit hooks
   cp .github/agents/commands/code-quality-check.md .husky/pre-commit
   
   # Add to CI/CD
   # Reference guides in .github/workflows/
   ```

### New Project Setup

1. **Bootstrap with Template**
   ```bash
   # Use project setup guide
   # Follow: .github/agents/commands/project-setup.md
   ```

2. **Add OpenCode Configuration**
   ```bash
   cp -r /path/to/e-van-opencode/.github .
   ```

3. **Initialize Development**
   ```bash
   # Install dependencies
   # Set up linting (code-quality-check.md)
   # Configure tests (quick-test.md)
   ```

## 🔧 Customization Guide

### Adding Custom Agents

Create `.github/agents/your-technology-expert.md`:

```markdown
# Your Technology Expert

You are an expert in [technology]...

## Core Responsibilities
1. [Responsibility 1]
2. [Responsibility 2]

## Key Skills
- [Skill 1]
- [Skill 2]

## Tools and Commands
```bash
# Tool commands
```

## When to Use This Agent
- [Use case 1]
- [Use case 2]
```

### Adding Custom Skills

Create `.github/agents/skills/your-skill.md`:

```markdown
# Your Skill Name

This skill helps [purpose]

## Purpose
[Description]

## Process
1. Step 1
2. Step 2

## Examples
[Practical examples]

## Usage
[When and how to use]
```

### Adding Custom Commands

Create `.github/agents/commands/your-command.md`:

```markdown
# Your Command Name

[Description]

## Purpose
[What it does]

## Commands
```bash
# Your commands here
```

## Usage Examples
[Examples]

## Tips
[Best practices]
```

## 🎓 Learning Path

### Week 1: Foundations
- [ ] Read [AGENTS.md](.github/agents/AGENTS.md) completely
- [ ] Bookmark [INDEX.md](.github/agents/INDEX.md)
- [ ] Explore [git workflow](.github/agents/skills/git-workflow.md)
- [ ] Try [project setup](.github/agents/commands/project-setup.md)

### Week 2: Language Expertise
- [ ] Study your language's custom agent
- [ ] Practice [code quality checks](.github/agents/commands/code-quality-check.md)
- [ ] Learn [testing patterns](.github/agents/commands/quick-test.md)
- [ ] Review [debugging skill](.github/agents/skills/debugging.md)

### Week 3: Advanced Practices
- [ ] Master [code review](.github/agents/skills/code-review.md)
- [ ] Learn from [sub-agents](.github/agents/sub-agents/)
- [ ] Apply [refactoring patterns](.github/agents/sub-agents/refactoring-specialist.md)
- [ ] Practice [test writing](.github/agents/sub-agents/test-writer.md)

### Ongoing
- [ ] Reference guides as needed
- [ ] Contribute improvements
- [ ] Share with team members
- [ ] Customize for your needs

## 📚 Use Case Examples

### Example 1: New Feature Development

```bash
# 1. Understand requirements
# Read relevant agents for guidance

# 2. Set up branch
git checkout -b feature/new-feature
# Reference: .github/agents/skills/git-workflow.md

# 3. Write code
# Reference: .github/agents/python-expert.md (or your language)

# 4. Add tests
# Reference: .github/agents/sub-agents/test-writer.md

# 5. Check quality
npm run lint
npm run format
# Reference: .github/agents/commands/code-quality-check.md

# 6. Run tests
npm test
# Reference: .github/agents/commands/quick-test.md

# 7. Commit
git add .
git commit -m "feat: Add new feature"
# Reference: .github/agents/skills/git-workflow.md

# 8. Push and create PR
git push origin feature/new-feature
```

### Example 2: Bug Fix

```bash
# 1. Reproduce the bug
# Reference: .github/agents/sub-agents/bug-hunter.md

# 2. Debug
# Reference: .github/agents/skills/debugging.md

# 3. Fix the issue
# Make minimal changes

# 4. Add regression test
# Reference: .github/agents/sub-agents/test-writer.md

# 5. Verify fix
npm test

# 6. Commit
git commit -m "fix: Handle null values in parser"
```

### Example 3: Code Review

```bash
# 1. Check out PR branch
git fetch origin
git checkout pr-branch

# 2. Review changes
git diff main..pr-branch
# Reference: .github/agents/skills/code-review.md

# 3. Run checks
npm run lint
npm test

# 4. Provide feedback
# Use: .github/agents/skills/code-review.md templates
```

## 🔍 Troubleshooting

### Can't Find What You Need?

1. Check [INDEX.md](.github/agents/INDEX.md)
2. Search through agents and skills
3. Create custom content if needed

### Content Outdated?

1. Update the specific file
2. Test your changes
3. Contribute back (if using team repository)

### Need More Examples?

1. Check existing agents for patterns
2. Add examples to skills/commands
3. Share with team for feedback

## 🤝 Contributing Back

### Found an Issue?

1. Note what's wrong or missing
2. Create a fix or improvement
3. Submit to team repository

### Have an Improvement?

1. Follow existing patterns
2. Add practical examples
3. Update INDEX.md if adding new content
4. Share with team

### Created Something Useful?

1. Format as agent/skill/command
2. Add to appropriate directory
3. Update README and INDEX
4. Share with community

## 📞 Support

### Team Resources

- Team's forked repository
- Team documentation
- Team chat channels
- Senior developers

### Community Resources

- Original repository: https://github.com/icampana/e-van-opencode
- GitHub Issues for questions
- Pull Requests for improvements

## ✅ Quick Checklist

### For Developers
- [ ] Cloned or bookmarked repository
- [ ] Read AGENTS.md
- [ ] Familiar with INDEX.md
- [ ] Know which agents apply to your work
- [ ] Can find commands quickly

### For Teams
- [ ] Forked repository
- [ ] Customized AGENTS.md
- [ ] Added team-specific content
- [ ] Shared with team members
- [ ] Integrated into workflows

### For Projects
- [ ] Copied .github/agents/ directory
- [ ] Customized for project
- [ ] Set up automation
- [ ] Team is aware of configuration
- [ ] Regularly updated

---

**Ready to start?** Check out [INDEX.md](.github/agents/INDEX.md) for quick navigation!

[← Back to README](../README.md)
