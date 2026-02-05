---
name: adr-manager
description: Manages Architecture Decision Records (ADRs) when modifying architecturally significant files.
---

# ADR Management Protocol

You are responsible for maintaining the architectural history of this project.

## Trigger Conditions

This skill is triggered whenever you modify files that are "architecturally significant." This includes, but is not limited to:
- Core configuration files (`requirements.txt`, `package.json`, `pyproject.toml`)
- Database schemas or migration files
- Security-sensitive modules (auth, encryption)
- New major modules or service integrations

## Workflow

1.  **Check Registry**: Inspect the `docs/adr` directory to understand existing decisions and determine the next ID (e.g., `0005`).
2.  **Propose ADR**: Create a new markdown file in `docs/adr/XXXX-title.md` using the following template:

```markdown
# ADR [ID]: [Title]

**Status**: Proposed | Accepted | Superseded
**Date**: [YYYY-MM-DD]

## Context
What is the problem we are solving? What are the constraints?

## Decision
What is the proposed change? Why this path over others?

## Consequences
What are the trade-offs? What new technical debt or benefits are introduced?
```

3.  **Log Decision**: Use the `adr_log` tool to update the index file (`docs/adr/README.md`).

## Importance

Documenting decisions ensures that the reasoning behind complex changes is not lost as the AI or team evolves.
