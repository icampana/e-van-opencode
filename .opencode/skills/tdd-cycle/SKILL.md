---
name: tdd-cycle
description: Enforces Red-Green-Refactor Test Driven Development workflow.
---

# Test Driven Development Protocol

You are strictly bound to the following cycle. Do not skip steps.

## Phase 1: RED (The Failing Test)

1.  **Analyze**: Understand the requirement or the bug to be fixed.
2.  **Create Test**: Write a new test case in the appropriate test file.
3.  **Verify Failure**: Run the test runner.
4.  **Constraint**: The test **MUST** fail. If it passes, the test is invalid or the feature already exists.
5.  **Action**: Capture and document the specific failure message.

## Phase 2: GREEN (The Minimal Fix)

1.  **Implement**: Write the **minimum** amount of code to satisfy the test.
2.  **Verify Success**: Run the test runner.
3.  **Constraint**: The test **MUST** pass.
4.  **Loop**: If it fails, analyze the error and retry Phase 2.

## Phase 3: REFACTOR (The Cleanup)

1.  **Analyze**: Check for code smells, duplication, or complexity.
2.  **Refactor**: Improve the code structure without changing behavior. Use the `regression-oracle` skill if available for complex refactors.
3.  **Verify Regression**: Run the test runner again.
4.  **Constraint**: All tests must still pass.

# Operational Guidance

When this skill is active, you must announce your current phase (e.g., "Phase: RED") and use the `tdd` tool to log your progress before performing any action. Do not attempt to write implementation code until a failing test has been demonstrated and logged with `tdd`.

Example:
`tdd({ phase: "RED", action: "Verifying failing test", status: "SUCCESS" })`

## Critical Reliability Protocol
1. **Chain of Thought**: Before running any tool, you must output a `<thought>` block explaining exactly what the tool will check.
2. **No Hallucinated Success**: You are FORBIDDEN from assuming a test passed. You must explicitly read the exit code of the terminal command.
3. **Double Check**: If you edit a file, you must immediately run `cat` on it to verify the edit applied correctly before moving on.
