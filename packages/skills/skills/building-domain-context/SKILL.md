---
name: building-domain-context
description: Forces DDD ubiquitous language definition before writing complex logic. Grills the user on business terminology, extracts a glossary, and documents it before handing off to brainstorming.
---

# Building Domain Context

Solves the "verbose AI" and "misalignment" problem by forcing the agent to
build a shared ubiquitous language (Domain-Driven Design) before writing
complex logic. No code is written during this skill.

## Prerequisites

This skill integrates tools from the team's AI workflow guide. See
`docs/tools-reference.md` for install commands and graceful degradation.

- **Required:** Superpowers plugin (for handoff to `brainstorming` and `writing-plans`)
- **Recommended:** Engram (memory), CodeGraph (structural analysis), ripgrep

## Workflow

### Phase 0: Sync Context (Golden Rule — sync before starting)

Before grilling the user, recover prior context:

1. **Memory sync:** Call `mem_search` for prior domain context, glossaries,
   or ubiquitous language from past sessions. Call `mem_context` for recent
   session history.
2. **Code structure:** Use `codegraph_explore` to understand the existing
   code structure and terminology. If CodeGraph isn't initialized, offer
   `codegraph init`; if unavailable, fall back to `rg` + `read`.
3. **Terminology scan:** Use `rg` to find how business terms are currently
   used in code (variable names, function names, comments, docstrings).
4. **Existing docs:** Read `docs/CONTEXT.md` or `docs/DOMAIN.md` if they
   exist. Read `docs/adr/` for prior architectural decisions.
5. **Project inventory:** Check Engram for a pinned project inventory
   (`mem_context`) to understand the project's purpose and aliases.

If prior domain context exists, resume from it rather than starting fresh.
Present what you found and ask: "Should I continue from this existing
glossary, or start over?"

### Phase 1: The Grilling Phase

**Do not write code. Do not write documentation yet.**

Ask the user highly specific, targeted questions about the business logic,
edge cases, and specific terminology they use for their application.

Rules:
- Ask only **1-2 questions at a time** to avoid overwhelming the user.
- Each question should include a recommended answer based on your code
  structure scan (Phase 0). The user confirms, corrects, or refines.
- Focus on nouns (entities, concepts) and verbs (actions, operations).
- Probe edge cases: "What happens when X fails?", "Can Y exist without Z?"
- If the user's language is vague ("the thing that processes payments"),
  push back (golden rule: anti-sycophancy) and ask them to name it precisely.

Continue grilling until you have covered:
- All core entities and their relationships
- All primary operations/actions
- Edge cases and error states
- Any terms where the code's naming diverges from the user's mental model

### Phase 2: The Glossary Phase

Once the user's intent is clear, extract a list of specific nouns and verbs
(the "Ubiquitous Language"):

- **Nouns** → entities, concepts, value objects, aggregates
- **Verbs** → actions, operations, domain events, commands

Example transformation:
- Instead of "the thing that happens when a user pays" → "Checkout Initialization"
- Instead of "user stuff" → "Account Provisioning"
- Instead of "the database table for orders" → "Order Aggregate" (if DDD) or "Order Record" (if CRUD)

Present the glossary to the user as a table:

| Term | Type | Definition | Code Equivalent |
|---|---|---|---|
| Checkout Initialization | Verb/Command | The process of starting a payment flow | `initiateCheckout()` |
| Order Aggregate | Noun/Entity | The root entity containing order lines and totals | `Order` class |

Ask the user to confirm or refine each term.

### Phase 3: The Documentation Phase

Automatically write or update `docs/CONTEXT.md` (or `docs/DOMAIN.md` if the
project prefers that name). Structure it as:

```markdown
# Domain Context

<!-- Version: vYYYY.MM.DD -->

## Ubiquitous Language

| Term | Type | Definition | Code Equivalent |
|---|---|---|---|
| ... | ... | ... | ... |

## Entity Relationships

[Description of how entities relate to each other]

## Business Rules

- [Rule 1]
- [Rule 2]

## Architectural Decisions

[Reference any ADRs discussed during grilling]
```

Additional documentation actions:
- If architectural decisions were discussed during grilling, trigger the
  `adr-manager` skill to create ADRs in `docs/adr/`.
- If the project has no `AGENTS.md`, offer to create one from the template
  in `docs/agents-template.md`. Fill in the detected stack and conventions.
- Follow the AGENTS.md template style: dated version marker, clear sections.

### Phase 4: Memory Phase (Golden Rule — keep memory current)

Persist the domain context so future sessions start from the truth:

1. `mem_save` the ubiquitous language glossary:
   - `title`: "Domain ubiquitous language for [project]"
   - `type`: "architecture"
   - `topic_key`: "domain/ubiquitous-language"
   - `content`: What/Why/Where/Learned format with the glossary table
2. If ADRs were created, `mem_save` each decision with `type: "decision"`.
3. If `AGENTS.md` was created, `mem_save` with `type: "config"`.

### Phase 5: Handoff

Once `docs/CONTEXT.md` is updated, transition automatically into the
standard Superpowers workflow, strictly utilizing the new vocabulary:

1. **`brainstorming`** (superpowers) — turn the domain understanding into an
   agreed design/spec. Use the ubiquitous language terms explicitly.
2. **`writing-plans`** (superpowers) — break the approved spec into a
   bite-sized, test-first implementation plan.

Announce the handoff: "Domain context established. Transitioning to
brainstorming using the agreed ubiquitous language."

## Degradation

| Tool Missing | Impact | Fallback |
|---|---|---|
| Engram | No memory sync or persistence | Read `docs/CONTEXT.md` and `docs/adr/` directly |
| CodeGraph | No structural code analysis | Use `rg` + `read` for terminology scan |
| ripgrep | Slower text search | Use `grep` |
| Superpowers | No handoff to brainstorming | Continue with manual spec writing |