---
description: Deep system analysis to generate docs/AI_CONTEXT.md
agent: plan
subtask: true
---
## 1. MISSION: SYSTEM ARCHAEOLOGY

You are now in **Deep Analysis Mode**. Your goal is not to write code, but to build a high-fidelity mental map of the system for future tasks. You are a Senior Software Architect conducting a technical due diligence.

## 2. ANALYSIS PROTOCOL

Execute the following cognitive steps (do not skip):

### Phase 1: Structural X-Ray
1. **Recursive Scan:** Identify modules in `src/`, `lib/`, or `app/`. Use `eza` or `find` to see the tree.
2. **Entry Points:** Locate `main.ts`, `index.js`, `App.tsx`, or `manage.py` specific entry points.
3. **Config Resolution:** Map how environment variables (`.env`) flow into the app config.

### Phase 2: Data Flow & Logic Mapping
1. **Data Models:** Identify the core entities (Prisma schemas, TypeORM entities, Pydantic models).
2. **API Surface:** Map the routes/controllers. How does a request travel from an Endpoint to the Database?
3. **Key Invariants:** What are the "rules that must never be broken" implied by the code?

### Phase 3: Technical Debt & Risk Assessment
1. **"God Objects":** Identify files > 300 lines that do too much.
2. **Hidden Dependencies:** Are there hardcoded strings or magic numbers?
3. **Test Coverage Gaps:** Which critical paths seem untested?

## 3. OUTPUT: ENHANCED CONTEXT ARTIFACT
Based on the analysis, Generate (or Overwrite) `docs/AI_CONTEXT.md` with this detailed structure:

```markdown
# AI CONTEXT & ARCHITECTURAL MAP
> Last Updated: [Current Date]

## 1. Tech Stack & Versions
- **Core:** [Frameworks]
- **State/Data:** [DB, ORM, State Mgmt]
- **Key Libs:** [Auth, Validation, etc.]

## 2. High-Level Architecture
[Brief description of the pattern: Monolith, Microservices, Hexagonal, etc.]

## 3. Critical Data Flows
- **Auth:** [How auth works]
- **Core Feature X:** [How the main feature works]

## 4. Key Directory Map
- `src/core`: [Description]
- `src/features`: [Description]
- ...

## 5. Developer Guide / Conventions
- **Testing:** [How to test]
- **Styling:** [CSS/Tailwind approach]
- **State:** [Redux/Context/Zustand]

## 6. Known Technical Debt / Watchlist
- [List specific risky files or complex logic to watch out for]
