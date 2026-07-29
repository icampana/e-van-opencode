# Golden Rules

The philosophical foundation all skills in this package enforce. Condensed
from the team's AI workflow guide.

## The 9 Golden Rules

1. **Sync context before starting.** Read the project's docs and the agent's
   own memory of prior sessions before touching anything — don't make it
   rediscover the codebase every time.

2. **Stay context-first and stack-agnostic.** Let the agent read the code and
   adapt to the detected language, framework, and style instead of forcing a
   preset pattern on it.

3. **Plan before you code.** For anything non-trivial, brainstorm the approach
   and get agreement on the design before implementation starts.

4. **Favor the simplest robust solution.** Apply Ockham's razor. If the agent
   is over-engineering, or you are, push back with a simpler alternative
   rather than accepting technical debt.

5. **Don't let it rubber-stamp a bad decision.** An agent that rubber-stamps
   a flawed instruction is worse than useless — expect it to flag a better
   alternative, and do the same for it.

6. **TDD where code is involved.** Red, green, refactor, with frequent, small
   commits along the way.

7. **Verify before calling it done.** Run the actual check and read the actual
   output before you or the agent claims something works — evidence before
   assertions.

8. **Keep agent memory current.** Update persistent memory/context files as
   the architecture or conventions change, so the next session starts from
   the truth, not a stale snapshot.

9. **Guard risky or outward-facing actions.** Anything hard to reverse or
   visible outside the repo — pushes, deletes, sending data externally —
   gets a human confirmation first.

## How Each Skill Enforces These Rules

| Rule | building-domain-context | architecture-scan | running-the-gauntlet | project-onboarding |
|---|---|---|---|---|
| 1. Sync context | `mem_search` + `codegraph_explore` before grilling | `mem_search` + read ADRs before scanning | `mem_search` for prior specs/evidence | `mem_search` + `mem_context` before setup |
| 2. Context-first | Read existing code structure before asking questions | Detect stack before scanning | Detect test runner before gauntlet | Detect stack before creating AGENTS.md |
| 3. Plan before code | Grilling phase produces spec before any code | Reporting phase before refactor | Spec phase with hard-stop approval | Pre-flight check before creating files |
| 4. Simplest solution | Extract only necessary terms, no over-modeling | 1-3 bottlenecks max, prioritized | Minimal code to pass tests | Only create files that are missing |
| 5. Anti-sycophancy | Push back on vague terminology | Push back on premature refactoring | Push back on skipping checks | Push back on unnecessary setup |
| 6. TDD | Handoff to `test-driven-development` | Handoff to `test-driven-development` | Enforce RED-GREEN-REFACTOR directly | N/A (setup skill) |
| 7. Verify before done | Confirm glossary with user | Confirm bottleneck selection with user | EVIDENCE.md with raw numbers | Run `mise tasks` + `codegraph_status` to verify |
| 8. Keep memory current | `mem_save` glossary after documentation | `mem_save` architecture findings | `mem_save` evidence after gauntlet | `mem_save` + `mem_pin` project inventory |
| 9. Guard risky actions | No code changes (documentation only) | No refactoring until user picks | No code until spec approved | Ask user before writing each file |