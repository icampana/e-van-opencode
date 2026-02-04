# Contributing to OpenCode Settings

Thank you for considering contributing to this OpenCode settings repository! This guide will help you contribute effectively.

## 🎯 What to Contribute

### New Agents
- Language/framework experts (Rust, PHP, C#, etc.)
- Domain specialists (Security, Performance, DevOps)
- Tool experts (Docker, Kubernetes, etc.)

### New Skills
- Advanced workflows
- Best practices
- Common patterns
- Tool proficiency guides

### New Commands
- Framework-specific commands
- Development tools
- Automation scripts
- Quick reference guides

### Improvements
- Better examples
- More comprehensive coverage
- Clearer explanations
- Bug fixes and corrections

## 📋 Contribution Guidelines

### Content Standards

#### Be Practical
- Focus on actionable advice
- Include concrete examples
- Provide actual commands
- Show real-world usage

#### Be Clear
- Use simple, direct language
- Structure content logically
- Use consistent formatting
- Include helpful headings

#### Be Complete
- Cover common scenarios
- Include edge cases
- Add troubleshooting tips
- Provide context

#### Be Accurate
- Test all commands
- Verify examples work
- Keep content current
- Cite sources when relevant

### File Structure

#### Agents
```markdown
# [Technology/Domain] Expert

You are an expert in [area]...

## Core Responsibilities
1. [Primary responsibility]
2. [Secondary responsibility]

## Key Skills
### [Skill Category]
- [Specific skill]
- [Specific skill]

## Tools and Commands
```bash
# Command examples
```

## When to Use This Agent
- [Use case 1]
- [Use case 2]

## Example Usage
- "[Example request]"
```

#### Skills
```markdown
# [Skill Name] Skill

This skill helps [purpose]

## Purpose
[Detailed description]

## Process
1. Step 1
2. Step 2

## [Section Title]
### [Subsection]
[Content]

## Usage
[When and how to use]
```

#### Commands
```markdown
# [Command Name] Command

[Brief description]

## Purpose
[What it accomplishes]

## Commands by [Category]

### [Subcategory]
```bash
# Command with explanation
command --options

# Another command
command2
```

## Usage Examples
[Practical examples]

## Tips
[Best practices]
```

### Markdown Guidelines

#### Headers
```markdown
# H1 for Title (one per document)
## H2 for Major Sections
### H3 for Subsections
#### H4 for Minor Points
```

#### Code Blocks
```markdown
# Always specify language
```javascript
const example = 'code';
```

# For bash/shell
```bash
npm install package
```

# For output
```
Expected output
```
```

#### Lists
```markdown
# Unordered lists
- Item 1
- Item 2
  - Nested item

# Ordered lists
1. First step
2. Second step
```

#### Links
```markdown
# Internal links
[Text](path/to/file.md)

# Anchor links
[Section](#section-heading)

# External links
[Text](https://example.com)
```

#### Emphasis
```markdown
**Bold** for important points
*Italic* for emphasis
`code` for commands/variables
```

## 🔄 Contribution Process

### 1. Plan Your Contribution

Before starting:
- Check if content already exists
- Review similar files for patterns
- Identify where it fits in structure
- Consider the target audience

### 2. Create Your Content

Follow these steps:
```bash
# Fork the repository
# Clone your fork
git clone https://github.com/YOUR_USERNAME/e-van-opencode.git
cd e-van-opencode

# Create a branch
git checkout -b add-rust-expert

# Create your content
# Follow the file structure guidelines
```

### 3. Test Your Content

Verify:
- [ ] All commands work as shown
- [ ] Examples are correct
- [ ] Links are valid
- [ ] Formatting is consistent
- [ ] No typos or errors

### 4. Update Documentation

If adding new files:
```bash
# Update INDEX.md
# Add entry in appropriate section

# Update README.md if needed
# Add to relevant sections

# Update GETTING_STARTED.md if relevant
# Add to learning path or examples
```

### 5. Submit Your Contribution

```bash
# Add your changes
git add .

# Commit with descriptive message
git commit -m "Add Rust expert agent"

# Push to your fork
git push origin add-rust-expert

# Create Pull Request on GitHub
```

## ✍️ Writing Style Guide

### Voice and Tone

**Do:**
- Use second person ("you can", "your code")
- Be encouraging and supportive
- Use active voice
- Be concise but thorough

**Don't:**
- Be condescending
- Use jargon without explanation
- Make assumptions about skill level
- Be overly verbose

### Example Improvements

#### ❌ Bad
```markdown
You should probably use TypeScript because it's better and everyone uses it now.
```

#### ✅ Good
```markdown
TypeScript provides static typing, which helps catch errors during development:

```typescript
function add(a: number, b: number): number {
  return a + b;
}
```
```

### Command Examples

#### ❌ Bad
```markdown
Just run the test command.
```

#### ✅ Good
```markdown
Run tests with coverage:

```bash
npm test -- --coverage

# Or for specific file
npm test -- path/to/test.spec.js
```

This generates a coverage report in the `coverage/` directory.
```

## 🎨 Content Templates

### New Language Expert Agent

```markdown
# [Language] Expert

You are an expert [Language] developer with deep knowledge of [language] best practices and ecosystem.

## Core Responsibilities

1. Write idiomatic [Language] code
2. Follow [Language] conventions and style guides
3. Use appropriate [Language] patterns
4. Implement comprehensive tests
5. Apply [Language] best practices

## Key Skills

### Code Quality
- [Language-specific practices]
- [Naming conventions]
- [Error handling patterns]

### Testing
- [Testing framework]
- [Test patterns]
- [Mocking strategies]

### Modern [Language]
- [Recent features]
- [Best practices]
- [Common patterns]

## Tools and Commands

### Linting and Formatting
```bash
# Format code
[format command]

# Lint code
[lint command]
```

### Testing
```bash
# Run tests
[test command]

# With coverage
[coverage command]
```

### Dependency Management
```bash
# Install dependencies
[install command]

# Update dependencies
[update command]
```

## Common Patterns

### [Pattern Name]
```[language]
// Example code
```

## When to Use This Agent

- Writing or refactoring [Language] code
- Adding [Language] tests
- Fixing [Language] bugs
- Setting up [Language] projects

## Example Usage

Ask this agent to:
- "Write a [Language] function that..."
- "Add tests for the [Language] module..."
- "Refactor this [Language] code to..."
```

### New Skill Template

```markdown
# [Skill Name] Skill

This skill helps [accomplish specific task].

## Purpose

[Detailed description of what this skill enables]

## Checklist

- [ ] [Step 1]
- [ ] [Step 2]
- [ ] [Step 3]

## Process

### 1. [Phase Name]
[Description]

### 2. [Phase Name]
[Description]

## [Topic Area]

### [Subtopic]
[Content with examples]

## Common Issues

### [Issue Name]
[Description and solution]

## Usage

[When and how to use this skill]

## Tools

### [Tool Category]
```bash
# Tool commands
```
```

### New Command Template

```markdown
# [Command Name] Command

[Brief description]

## Purpose

[What this accomplishes]

## Commands by [Category]

### [Language/Framework]

#### [Specific Tool]
```bash
# Basic usage
command

# Advanced usage
command --option

# Specific scenario
command --option value
```

### [Another Category]
[Similar structure]

## Quick Aliases

```bash
# Add to shell profile
alias shortcut='full command'
```

## Usage Examples

### [Scenario]
```bash
# Commands for this scenario
command1
command2
```

## Tips

- [Tip 1]
- [Tip 2]

## Common Issues

### [Issue]
[Solution]
```

## 🐛 Reporting Issues

### Found a Problem?

Open an issue with:
- Clear description of the problem
- Which file has the issue
- Expected vs actual behavior
- Suggested fix if you have one

### Have a Question?

- Check existing documentation first
- Search closed issues
- Open a new issue with "Question:" prefix

## 🔍 Review Process

### What We Look For

Reviewers will check:
- [ ] Content accuracy
- [ ] Follows style guidelines
- [ ] Examples work correctly
- [ ] Proper formatting
- [ ] Updated relevant docs
- [ ] No broken links

### Feedback

You may receive:
- Requests for changes
- Suggestions for improvements
- Questions about examples
- Links to related content

Please:
- Respond to feedback
- Make requested changes
- Ask questions if unclear
- Be patient and collaborative

## 📝 Checklist Before Submitting

### Content Quality
- [ ] Accurate information
- [ ] Working examples
- [ ] Clear explanations
- [ ] Proper formatting

### Structure
- [ ] Follows template
- [ ] Logical organization
- [ ] Consistent with existing content
- [ ] Appropriate file location

### Documentation
- [ ] Updated INDEX.md
- [ ] Updated README.md if needed
- [ ] Updated GETTING_STARTED.md if relevant
- [ ] All links work

### Testing
- [ ] Commands tested
- [ ] Examples verified
- [ ] Markdown renders correctly
- [ ] No typos

## 🌟 Recognition

Contributors will be:
- Acknowledged in commit history
- Mentioned in release notes (major contributions)
- Helping the community!

## 📞 Questions?

- Open an issue
- Check existing documentation
- Review similar contributions
- Ask in pull request comments

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for helping make this resource better for everyone! 🚀

[← Back to README](README.md)
