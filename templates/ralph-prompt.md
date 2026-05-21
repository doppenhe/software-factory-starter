# PROMPT

## Quality Standard

One sentence. Testable.

## Reference Set

URLs, screenshots, files, docs, or fixtures that define good.

## Comparison Process

How to compare current work to the reference set.

## Iteration Protocol

1. Orient.
2. Inspect.
3. List defects.
4. Fix.
5. Verify.
6. Report.

## Report Contract

End every iteration with:

```text
<ralph-report>
ITERATION:
PHASE:
COMPLETED:
REFERENCE:
DEFECTS_FOUND:
DEFECTS_FIXED:
DEFECTS_REMAINING:
CYCLES_RUN:
FILES_CHANGED:
TESTS:
NEXT:
BLOCKERS:
PROGRESS:
</ralph-report>
<promise>COMPLETE</promise>
```

## Rules

- Do not mark DONE without verifier evidence.
- Do not batch unrelated fixes.
- Do not change scope without updating state.
- Stop on blocker and report the exact missing input.

## Rocks

### Rock 1

Goal:

Checks:

Evidence:

