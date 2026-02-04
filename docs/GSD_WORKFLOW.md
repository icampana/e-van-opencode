# GSD Workflow with OpenCode Experts

This guide explains how to use the **Get Shit Done (GSD)** system (`npx get-shit-done-cc`) in harmony with the **OpenCode Expert Agents** defined in this repository.

## The Core Philosophy
*   **GSD provides the "Project Management"**: Roadmaps, Requirements, Tasks, and Atomic Plans.
*   **OpenCode provides the "Staff"**: Specialized personas (Principal Engineer, UI Engineer, etc.) that execute the work.

## Setup
1.  **Install GSD**:
    ```bash
    npx get-shit-done-cc --opencode --local
    ```
    *(Note: Using `--local` installs GSD hooks into `.opencode/` or `.claude/` for this project only.)*

2.  **Sync Agents**:
    Ensure your Expert Agents are synced:
    ```bash
    ./sync-config.sh --symlink
    ```

## Workflow: New Project
When starting a fresh project, use the **Principal Engineer** persona to guide GSD's initialization.

1.  **Initialize**:
    ```bash
    /gsd:new-project
    ```
2.  **Research Phase**:
    When GSD spawns research agents, they will inherit the `docs/AGENTS.md` rules. They will automatically:
    *   Read `docs/AI_CONTEXT.md`.
    *   Respect the `dependency audit` protocols.

## Mapping Phases to Experts
When you reach the **Execute Phase** (`/gsd:execute-phase`), you can "assign" work to specific experts by invoking them in your task descriptions or simply relying on their file-type triggers.

| Task Type | Recommended Agent | Trigger |
| :--- | :--- | :--- |
| **New Architecture** | `@principal-engineer` | Default behavior. |
| **Frontend/React** | `@ui-engineer` | "Create a React component..." |
| **Database Schema** | `@postgresql-expert` | "Design a SQL migration..." |
| **CI/CD Pipelines** | `@devops-engineer` | "Update GitHub Actions..." |
| **Documentation** | `@documentation-expert` | "Write API docs..." |

## Example: Implementing a Feature

1.  **Discuss**:
    ```bash
    /gsd:discuss-phase 1
    ```
    *GSD asks you about preferences. You can say: "Follow the @ui-engineer standards for accessibility."*

2.  **Plan**:
    ```bash
    /gsd:plan-phase 1
    ```
    *GSD generates `PLAN.md`. It sees the "GSD Protocol" in `AGENTS.md` and creates atomic steps.*

3.  **Execute**:
    ```bash
    /gsd:execute-phase 1
    ```
    *The Executor Agent reads the plan. It sees it involves `src/components`, so it adopts the `@ui-engineer` persona constraints (Mobile-First, Semantic HTML).*

## Verification & Tests
GSD requires a `VERIFICATION.md` check.
*   Use `@test-writer` to generate the tests *before* the implementation if following TDD (as mandated by `AGENTS.md`).
*   GSD's `verify` step will run these tests.

## Troubleshooting
*   **"Agent ignored the plan"**: Check if `opencode.json` is correctly excluding `.planning/`. The agent might be overwhelmed by context.
*   **"GSD wiped my agents"**: Re-run `./sync-config.sh`. It is safe and will restore your experts without deleting GSD's files.
