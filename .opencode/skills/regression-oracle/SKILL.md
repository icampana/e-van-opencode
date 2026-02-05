---
name: regression-oracle
description: Automated regression oracle using snapshot tests for refactoring and optimization tasks.
---

# Automated Regression Oracle

The "Automated Regression Oracle" uses the current version of the software as the definition of correctness for refactoring or optimization tasks.

## Workflow

1.  **Capture**: Identify the function to be modified. Generate a "Snapshot Test" (or "Characterization Test") that records the output of the function for a diverse set of inputs (randomized fuzzing or captured production traffic).
2.  **Lock**: Save these outputs to a temporary file (e.g., `oracle_snapshot.json`).
3.  **Modify**: Perform the refactoring or optimization.
4.  **Verify**: Run the Snapshot Test against the new code. Compare the new output to the `oracle_snapshot.json`. Any deviation is a failure.
5.  **Release**: Only if the verification passes, delete the snapshot and commit the changes.

## When to use

Use this skill when you need to "clean up" or optimize code and want to ensure no behavioral regressions occur.
