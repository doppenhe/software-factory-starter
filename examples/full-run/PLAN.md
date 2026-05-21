# PLAN

## Source

Scope file: `examples/full-run/SCOPE.md`

## Work Units

### Unit 1

GOAL: Prove initialization works on a clean clone.

APPROACH: Run `python3 scripts/init-project.py --name "Example"` and verify generated files.

STATUS: example

### Unit 2

GOAL: Prove the runtime can resume from state.

APPROACH: Use `python3 scripts/ralph.py next` to emit the next checklist item as stdout.

STATUS: example

### Unit 3

GOAL: Prove report parsing works.

APPROACH: Validate `examples/full-run/iteration-001.log` with `python3 scripts/ralph.py check-report`.

STATUS: example

## Risks

- This example proves the harness mechanics, not product quality.

## Verification

- `bash scripts/verify.sh`
- `python3 scripts/ralph.py check-report examples/full-run/iteration-001.log`

## Exit Criteria

All commands pass without local machine assumptions.

