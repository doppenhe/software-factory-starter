# Runtime

BLUF: runtime is the machinery that lets agents run unattended while staying inspectable.

## Core Files

Use these files for meaningful runs:

- `PROMPT.md`: immutable recipe for the run.
- `state/RALPH_STATE.md`: mutable campaign state and resume key.
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

The state file is a campaign tracker: one row per task, carrying everything the next agent needs to resume after a context reset.

```text
# | Task | Repo | Worktree | Branch | Base | Status | Verification | Notes
```

Status values:

- TODO: claimed scope, not started.
- DOING: implementation in progress.
- VERIFY: implementation complete, running the gate.
- AUDIT: gate green, independent adversarial review in progress.
- FIX: audit found defects, correction round in progress.
- PR: pull request open, awaiting CI or human review.
- DONE: merged, with evidence recorded.
- BLOCKED: waiting on a decision, a dependency, or an out-of-scope failure.

Rules that keep the file honest:

- Record the base commit per task. A rebase is a state change, so update the row.
- Verification records real numbers, for example "focused 64 passed, full verify 837 passed", not "tests pass".
- Defects found in audit send the row back to FIX, not forward to PR.
- Serialize what cannot run in parallel: shared contracts, decision log edits, generated output, publication.
- A row stale by its own freshness rule flips back to TODO.

A campaign spanning repositories keeps one state file above them, not one per repository. See `templates/ralph-state.md`.

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

## Modes Beyond The Laptop

Two runtime modes need their own rules.

Remote. A cloud run that survives the laptop closing. Scope it to one repository per run, expect credentialed tests to skip in the sandbox and say so in the evidence, and end a failed run in a draft pull request with a report rather than a retry loop. Never auto-merge.

Scheduled. Recurring work on a stable recipe, where nobody is watching the moment it drifts. It needs committed state, a content-free run log, and a watchdog running on a different substrate from the job. See `docs/scheduled-work.md`.
