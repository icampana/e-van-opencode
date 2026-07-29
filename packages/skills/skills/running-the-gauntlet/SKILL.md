---
name: running-the-gauntlet
description: Evidence-first development for high-stakes code. Writes a concrete spec, enforces strict TDD, then runs code through a gauntlet of 6 checks and generates an EVIDENCE.md report with raw numbers.
---

# Running the Gauntlet

Solves the problem of blindly trusting AI-generated code. Inspired by
Uncle Bob Martin, this replaces line-by-line manual code review with
rigorous, extreme constraints. The human reviews the intent (Spec) and
the proof (Evidence), not the code itself.

## Prerequisites

This skill integrates tools from the team's AI workflow guide. See
`docs/tools-reference.md` for install commands and graceful degradation.

- **Required:** Superpowers plugin (for `test-driven-development`)
- **Recommended:** Engram (memory), context-mode (large output processing), mise (canonical commands)

## When to Activate

- Any core feature implementation
- When the user explicitly says "prove it works" or "run the gauntlet"
- Whenever writing high-stakes code: touching money, auth, data integrity,
  or concurrency
- Before merging a critical change

## Workflow

### Phase 0: Sync Context (Golden Rule — sync before starting)

Before writing the spec, recover prior context:

1. **Memory sync:** Call `mem_search` for prior specs, ADRs, or evidence
   from previous gauntlets on this codebase. Call `mem_context` for recent
   session history.
2. **Existing docs:** Read `docs/adr/` for decisions that constrain the
   implementation. Read `docs/CONTEXT.md` for domain vocabulary.

### Phase 1: The Spec Phase (Before Coding)

Write a concrete SPEC detailing:

- **Examples of what the code MUST do** — specific inputs and expected
  outputs, edge cases, happy path
- **Examples of what the code MUST NOT do** — negative constraints,
  forbidden behaviors
- **Required external tools/dependencies** — libraries, services, APIs
- **Constraints** — performance, security, compatibility

Reference the AGENTS.md template structure from `docs/agents-template.md`
for formatting guidance.

**HARD STOP:** Present the Spec to the user for a single Yes/No approval.
**Do NOT write a single line of code until the user approves.**

If the user requests changes, update the spec and re-present. Do not
proceed to Phase 2 until you receive an explicit "yes" or "approved".

### Phase 2: The TDD Loop (Superpowers Integration)

Enforce strict `test-driven-development` (superpowers):

1. **RED:** Write a failing test for the change. Run the test runner.
   The test MUST fail. If it passes, the test is invalid or the feature
   already exists. Document the specific failure message.

2. **GREEN:** Write the **minimum** amount of code to satisfy the test.
   Run the test runner. The test MUST pass. Read the actual exit code —
   never assume success (golden rule: verify before done).

3. **REFACTOR:** Clean up the code structure without changing behavior.
   Remove dead code, unused imports, duplication. Run the test runner
   again. All tests must still pass.

**Discovering the test command:** Use `mise tasks` to find the canonical
test command. If mise isn't set up, detect the test runner directly:
- Node: `npm test` or `npx jest` or `npx vitest`
- Python: `pytest` or `python -m pytest`
- Go: `go test ./...`
- Rust: `cargo test`

**Critical reliability protocol:**
- Before running any test, output a `<thought>` block explaining what the
  test checks.
- You are FORBIDDEN from assuming a test passed. Read the actual exit code
  of the terminal command.
- If you edit a file, verify the edit applied correctly before moving on.

### Phase 3: The Gauntlet Phase

Instead of just running standard unit tests, force the code through a
gauntlet of 6 checks:

#### Check 1: Full Test Suite

Run the entire test suite, not just the new tests.

```bash
mise run test    # or: npm test / pytest / go test ./... / cargo test
```

**Question:** Did anything break globally?
**Pass criteria:** All tests pass. Exit code 0.
**Read the actual exit code.** Never hallucinate success.

#### Check 2: Suite Health

Re-run the test suite in random order to catch order-dependent failures.

- Jest: `npx jest --shuffle` or `--randomize`
- pytest: `pytest -p random` or `pip install pytest-randomly && pytest`
- Go: `go test -shuffle=on ./...`
- Rust: `cargo test -- --test-threads=1` (no native shuffle; label unverified)

**Question:** Are the tests stable in any order?
**Pass criteria:** All tests pass in random order.
**If the framework doesn't support randomization:** Label this check
"unverified — framework doesn't support random ordering."

#### Check 3: Changed-Line Coverage

Generate a coverage report filtered to the changed files only.

- Jest: `npx jest --coverage --changedFiles=<files>`
- pytest: `pytest --cov=<module> --cov-report=term-missing`
- Go: `go test -coverprofile=coverage.out && go tool cover -func=coverage.out`
- Rust: `cargo tarpaulin --out Stdout --lib`

**Question:** Is every new line genuinely exercised by a test?
**Pass criteria:** 100% coverage on changed lines. Any uncovered line
must be justified (e.g., defensive code that can't be triggered).

#### Check 4: Types & Linting

Run the type checker and linter to catch unreadable tangles or type errors.

```bash
mise run lint       # or: ruff check . / eslint . / golangci-lint run
mise run typecheck  # or: tsc --noEmit / mypy . / go vet ./...
```

**Question:** Are there any unreadable tangles or type errors?
**Pass criteria:** Zero errors. Warnings are acceptable if justified.

#### Check 5: Mutation Testing

Plant intentional bugs to ensure the tests actually catch them.

- JavaScript/TypeScript: `npx stryker run`
- Python: `mutmut run` or `pip install mutmut && mutmut run`
- Go: `go-mutesting` (if installed)

**Question:** Do the tests catch intentional bugs?
**Pass criteria:** Mutation score >80%. Any surviving mutant must be
investigated — either the test is insufficient or the mutant is equivalent.

**If no mutation testing tool is configured:** Label this check
"unverified — no mutation testing tool configured." Do NOT skip it silently.

#### Check 6: Real Execution

Prove the code actually runs outside the test harness.

- CLI tool: run it with real arguments and verify output
- API endpoint: make a real HTTP request (use `ctx_execute` with `fetch`
  if available, or `curl` via bash)
- Library: write a small script that imports and calls the code
- Background job: run it and verify side effects

**Question:** Does the code actually run outside the test harness?
**Pass criteria:** The code produces the expected output/side effects
in a real execution context.

**Processing large output:** Use `ctx_execute` (context-mode) to process
large test/lint/coverage output — only the derived answer enters context,
not raw bytes. If context-mode is unavailable, pipe through `jq` or `rg`
to filter before reading.

### Phase 4: The Evidence Phase

Generate an `EVIDENCE.md` report summarizing the raw, real numbers from a
**final fresh run** of the Gauntlet. Not from memory — re-run everything.

```markdown
# Evidence Report

## Spec
[Link to the approved spec]

## Gauntlet Results

| Check | Status | Details |
|---|---|---|
| Full Test Suite | PASS / FAIL | [N] tests, [N] passed, [N] failed, exit code [N] |
| Suite Health (random order) | PASS / FAIL / UNVERIFIED | [Details or "framework doesn't support randomization"] |
| Changed-Line Coverage | PASS / FAIL | [N]% on changed files, [N] uncovered lines |
| Types & Linting | PASS / FAIL | [N] errors, [N] warnings |
| Mutation Testing | PASS / FAIL / UNVERIFIED | Mutation score [N]%, [N] mutants killed |
| Real Execution | PASS / FAIL | [Description of real execution proof] |

## Raw Output

### Full Test Suite
[Actual terminal output — exit code, test count, pass/fail counts]

### Suite Health
[Actual terminal output from random-order run]

### Coverage
[Actual coverage report for changed files]

### Types & Linting
[Actual linter/typechecker output]

### Mutation Testing
[Actual mutation testing output or "unverified — no tool configured"]

### Real Execution
[Actual output from real execution]

## Rule of Honesty
[Any check that was not run is explicitly labeled "unverified" with the reason.]
```

**Rule of Honesty:**
- Never weaken a test to make it pass.
- If a check didn't run, explicitly label it "unverified" with the reason.
- Do not edit the evidence to look better than reality.

**Memory persistence (golden rule — keep memory current):**
- `mem_save` the evidence with `type: "architecture"` (or `type: "bugfix"`
  if this was a bug fix gauntlet).
- `topic_key`: "evidence/<feature-name>" for future reference.

Present the Evidence to the user. Do not claim "done" until the user
reviews the evidence.

## Degradation

| Tool Missing | Impact | Fallback |
|---|---|---|
| Superpowers | No TDD enforcement | Enforce RED-GREEN-REFACTOR manually |
| Engram | No memory sync or persistence | Read `docs/adr/` and prior `EVIDENCE.md` files directly |
| context-mode | Large output enters context directly | Pipe through `jq`/`rg` to filter before reading |
| mise | No canonical command discovery | Detect runner from `package.json`, `pyproject.toml`, etc. |
| Mutation testing tool | Check 5 unverified | Label "unverified — no mutation testing tool configured" |
| Coverage tool | Check 3 degraded | Run tests with `--verbose` and manually verify each new line is exercised |