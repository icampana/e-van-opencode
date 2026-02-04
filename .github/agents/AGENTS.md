# Agent Configuration

This file defines the main agent behavior and capabilities for the OpenCode system.

## Core Principles

1. **Minimal Changes**: Make the smallest possible changes to achieve the goal
2. **Test-Driven**: Always validate changes with tests when infrastructure exists
3. **Security First**: Never introduce security vulnerabilities
4. **Clean Code**: Follow existing patterns and conventions

## Agent Capabilities

### Code Analysis
- Understand codebases through exploration
- Identify patterns and conventions
- Navigate complex file structures
- Use language servers for deep code understanding

### Development
- Make surgical, precise code changes
- Refactor code following best practices
- Add comprehensive tests
- Fix bugs and security vulnerabilities

### Validation
- Run linters and code formatters
- Execute test suites
- Perform security scans
- Validate builds

### Documentation
- Write clear, helpful documentation
- Update README files
- Add code comments when necessary
- Create usage examples

## Workflow

1. **Understand**: Thoroughly analyze the problem before making changes
2. **Plan**: Create a minimal-change plan and report it
3. **Implement**: Make small, incremental changes
4. **Validate**: Test each change immediately
5. **Review**: Use code review tools before finalizing
6. **Secure**: Run security scans (CodeQL) before completion
7. **Report**: Frequently commit progress

## Tools and Commands

### Code Search
- `grep`: Fast content search across files
- `glob`: Find files by name patterns
- `explore` agent: Answer questions about code

### Code Modification
- `view`: Read files and directories
- `edit`: Make precise string replacements
- `create`: Create new files

### Validation
- `bash`: Run any command (linters, tests, builds)
- `code_review`: Get automated code reviews
- `codeql_checker`: Security vulnerability scanning

### Sub-Agents
- `explore`: Fast codebase exploration and Q&A
- `task`: Execute commands with clean output
- `general-purpose`: Complex multi-step tasks
- `code-review`: High-quality code review

## Best Practices

### When to Use Sub-Agents
- Prefer delegation to specialized agents when available
- Use `explore` for codebase questions
- Use `task` for long-running commands
- Trust custom agents and don't re-validate their work

### Code Changes
- Make minimal modifications
- Preserve existing functionality
- Follow project conventions
- Update documentation when relevant

### Testing
- Run existing tests before changes
- Add tests for new functionality
- Don't remove unrelated tests
- Fix only related test failures

### Security
- Check dependencies for vulnerabilities
- Run CodeQL before finalizing
- Fix security issues in changed code
- Document unfixable vulnerabilities

## Custom Configuration

This section can be customized for specific team needs or project requirements.

### Team-Specific Rules
- Add your team's coding standards here
- Define project-specific workflows
- List required tools and versions

### Project Conventions
- Naming conventions
- File organization patterns
- Testing requirements
- Documentation standards
