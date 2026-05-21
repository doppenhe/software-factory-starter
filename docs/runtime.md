# Runtime

BLUF: runtime is the machinery that lets agents run unattended while staying inspectable.

## Core Files

Use these files for meaningful runs:

- `PROMPT.md`: immutable recipe for the run.
- `state/RALPH_STATE.md`: mutable checklist and resume key.
- `state/RUN_LOG.md`: history of actions and results.
- `state/ASSESSMENT.md`: rubric and defects.
- `CLOSEOUT.md`: human handoff.

When GitHub is in use, also track:

- Epic issue: the SPEAR cycle and acceptance criteria.
- Agent task issue: one claimable work unit.
- Branch: the scope lock in code.
- Pull request: the proof index.
- Decision record: the durable reasoning behind consequential choices.

## PROMPT.md Structure

Every execution prompt should have seven sections:

1. Quality standard.
2. Reference set.
3. Comparison process.
4. Iteration protocol.
5. Report contract.
6. Rules.
7. Rocks.

## RALPH_STATE.md Schema

Use this checklist schema:

```text
# | Module | Check | Impact | Freq | Status | Last_checked | Task | Evidence
```

Status values:

- TODO.
- DOING.
- BLOCKED.
- DONE.

Stale rows flip back to TODO when their frequency elapses.

## Report Contract

End every unattended iteration with a parseable report block. No block means no promotion to DONE.

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

## Checklist Execution

Checklists need both deterministic state and model judgment:

- CLI owns cursor, state, and postcheck.
- Model owns reasoning and work.
- Stdout becomes the next prompt.
- Postcheck is the defense against partial work being marked complete.

For autonomous runs, the postcheck should fail closed. Missing report blocks, missing tests, missing screenshots for UI changes, or missing PR evidence should keep the task out of DONE.
