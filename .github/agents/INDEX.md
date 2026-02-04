# OpenCode Configuration Index

Quick reference guide to all available agents, skills, and commands.

## 📚 Table of Contents

- [Main Configuration](#main-configuration)
- [Custom Agents](#custom-agents)
- [Sub-Agents](#sub-agents)
- [Skills](#skills)
- [Commands](#commands)

## Main Configuration

### [AGENTS.md](AGENTS.md)
Core agent behavior as Principal Software Architect with context-first approach.

**Key Topics:**
- Role & Persona (Anti-sycophancy, Context-First, Orchestrator)
- Adaptive Project & Memory Bank (docs/AI_CONTEXT.md)
- Pre-flight Safety & Simplicity Checks
- Preferred CLI Tools (bat, rg, sd)
- TDD-First Execution Protocol
- Agent Delegation & Specialization
- Commit & Handoff procedures

**Use When:** Setting up new projects, understanding agent philosophy, or onboarding team members

---

## Custom Agents

Specialized agents with deep domain expertise.

### [Python Expert](python-expert.md)
Python development specialist with deep knowledge of Python ecosystem.

**Specializes In:**
- Modern Python (PEP 8, type hints, dataclasses)
- Testing with pytest
- Tools: black, pylint, mypy, flake8

**Use When:** Writing Python code, adding Python tests, or reviewing Python code

### [JavaScript/TypeScript Expert](javascript-expert.md)
Modern JavaScript and TypeScript development specialist.

**Specializes In:**
- ES6+ and TypeScript
- React, Node.js, Express
- Testing with Jest/Vitest
- Tools: ESLint, Prettier, TypeScript compiler

**Use When:** Writing JS/TS code, React components, or Node.js applications

### [Documentation Expert](documentation-expert.md)
Technical writing specialist for comprehensive documentation.

**Specializes In:**
- README files, API documentation
- Tutorials and guides
- Markdown best practices
- Documentation generators

**Use When:** Creating or updating documentation, writing guides, or API docs

---

## Sub-Agents

Focused agents for specialized tasks.

### [Test Writer](sub-agents/test-writer.md)
Specialist in writing comprehensive, maintainable tests.

**Focus Areas:**
- Unit and integration tests
- Test patterns (Arrange-Act-Assert)
- Mocking strategies
- Framework-specific patterns (Jest, pytest, JUnit)

**Use When:** Adding tests, improving test coverage, or learning testing patterns

### [Bug Hunter](sub-agents/bug-hunter.md)
Systematic bug finding and fixing specialist.

**Focus Areas:**
- Reproduction and investigation
- Root cause analysis
- Debugging tools by language
- Common bug patterns

**Use When:** Debugging issues, fixing bugs, or investigating failures

### [Refactoring Specialist](sub-agents/refactoring-specialist.md)
Code quality improvement through careful refactoring.

**Focus Areas:**
- Refactoring catalog (extract function, simplify conditionals)
- Code smell detection
- Safe refactoring process
- Before/after examples

**Use When:** Improving code quality, removing duplication, or simplifying complex code

---

## Skills

Reusable capabilities that can be applied across projects.

### [Code Review](skills/code-review.md)
Comprehensive code review guidelines and checklists.

**Covers:**
- Review checklist (functionality, quality, security)
- Common issues to look for
- Constructive feedback templates
- Tools for viewing changes

**Use When:** Reviewing code, preparing for code review, or learning review practices

### [Git Workflow](skills/git-workflow.md)
Complete guide to working effectively with Git.

**Covers:**
- Basic and feature branch workflows
- Commit message conventions
- Branch management
- Viewing history and undoing changes
- Troubleshooting common issues

**Use When:** Working with Git, learning Git commands, or troubleshooting Git issues

### [Debugging](skills/debugging.md)
Systematic debugging techniques and tools.

**Covers:**
- Debugging process (understand → isolate → test → fix)
- Print debugging, debuggers, binary search
- Common issues by language
- Debugging tools and commands

**Use When:** Debugging issues, learning debugging techniques, or stuck on a problem

---

## Commands

Quick reference guides for common development tasks.

### [Quick Test](commands/quick-test.md)
Test commands for all major frameworks and languages.

**Includes:**
- JavaScript/TypeScript (Jest, Vitest, Mocha)
- Python (pytest, unittest)
- Java (Maven, Gradle)
- Go, Ruby, .NET
- Quick aliases and auto-detection scripts

**Use When:** Running tests, setting up test commands, or learning framework-specific testing

### [Project Setup](commands/project-setup.md)
Bootstrap new projects with best practices.

**Includes:**
- Node.js, React, Next.js, Express
- Python, Flask, FastAPI
- Go, Java, .NET
- Common configuration files
- Docker setup

**Use When:** Starting new projects, setting up development environments

### [Code Quality Check](commands/code-quality-check.md)
Linting, formatting, and quality checks for all languages.

**Includes:**
- JavaScript/TypeScript (ESLint, Prettier, TypeScript)
- Python (black, pylint, flake8, mypy)
- Go (gofmt, golangci-lint)
- Java, Ruby, Rust, .NET
- Pre-commit hooks and CI configuration

**Use When:** Checking code quality, setting up linters, or before committing

---

## Quick Reference by Use Case

### 🆕 Starting a New Project
1. [Project Setup](commands/project-setup.md) - Bootstrap your project
2. [AGENTS.md](AGENTS.md) - Review principles and workflow
3. [Code Quality Check](commands/code-quality-check.md) - Set up linting

### 🐛 Fixing a Bug
1. [Bug Hunter](sub-agents/bug-hunter.md) - Investigation process
2. [Debugging](skills/debugging.md) - Debugging techniques
3. [Test Writer](sub-agents/test-writer.md) - Add regression test

### ✍️ Writing Code
1. Language-specific agent ([Python](python-expert.md), [JavaScript](javascript-expert.md))
2. [AGENTS.md](AGENTS.md) - Best practices
3. [Code Quality Check](commands/code-quality-check.md) - Check your code

### 🧪 Adding Tests
1. [Test Writer](sub-agents/test-writer.md) - Test patterns
2. [Quick Test](commands/quick-test.md) - Run tests
3. Language-specific agent for testing patterns

### 📖 Writing Documentation
1. [Documentation Expert](documentation-expert.md) - Writing guidelines
2. [AGENTS.md](AGENTS.md) - When to document

### 🔍 Reviewing Code
1. [Code Review](skills/code-review.md) - Review checklist
2. [Git Workflow](skills/git-workflow.md) - View changes
3. Language-specific agent for domain knowledge

### ♻️ Refactoring Code
1. [Refactoring Specialist](sub-agents/refactoring-specialist.md) - Refactoring patterns
2. [Test Writer](sub-agents/test-writer.md) - Ensure test coverage first
3. [Code Quality Check](commands/code-quality-check.md) - Validate improvements

### 🚀 Before Committing
1. [Quick Test](commands/quick-test.md) - Run tests
2. [Code Quality Check](commands/code-quality-check.md) - Check quality
3. [Git Workflow](skills/git-workflow.md) - Commit changes

---

## 🎯 Getting Started

### For New Team Members

1. Read [AGENTS.md](AGENTS.md) for overall principles
2. Bookmark this INDEX.md for quick reference
3. Explore agents relevant to your work
4. Reference skills and commands as needed

### For Experienced Developers

1. Jump directly to specific agents or skills
2. Reference commands for quick lookups
3. Contribute improvements based on your experience

### For Project Setup

1. Copy `.github/agents/` to your project
2. Customize [AGENTS.md](AGENTS.md) for your needs
3. Add project-specific agents or skills
4. Share with your team

---

## 📝 Contributing

To add new content:

1. Follow existing patterns for your content type
2. Add entry to this INDEX.md
3. Update README.md if adding new categories
4. Include practical examples

---

**Last Updated:** 2026-02-04

[← Back to README](../../../README.md)
