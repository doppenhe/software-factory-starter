# PROMPT

## Quality Standard

The project initializes and verifies on a clean clone using only Bash and Python.

## Reference Set

- `CODEX.md`
- `docs/runtime.md`
- `templates/ralph-state.md`

## Comparison Process

Compare generated files against required starter files and run the verifier.

## Iteration Protocol

1. Orient.
2. Inspect state.
3. Run verification.
4. Fix missing portable assumptions.
5. Validate report.
6. Report.

## Report Contract

Use `templates/report-contract.md`.

## Rules

- Do not use local absolute paths.
- Do not depend on external services.
- Do not mark complete without command evidence.

## Rocks

### Rock 1

Goal: verify starter mechanics.

Checks:

- Required files exist.
- No forbidden Unicode dash characters exist.
- Report block validates.

Evidence:

- `examples/full-run/iteration-001.log`

