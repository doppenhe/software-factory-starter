# CAMPAIGN STATE

One row per task in the campaign. The prompt is the recipe and changes rarely. This file changes every iteration and is the resume key after a context reset.

Date:

## Confirmed Scope

- {what this campaign is allowed to touch}
- {what stops the run: blocker, repeated assessment rounds with no improvement, out-of-scope failure}

## Tasks

| # | Task | Repo | Worktree | Branch | Base | Status | Verification | Notes |
|---|------|------|----------|--------|------|--------|--------------|-------|
| 1 | #000 example task | repo | /tmp/repo-000-slug | codex/000-slug | abc1234 | TODO |  |  |

## Status Values

- TODO: claimed scope, not started.
- DOING: implementation in progress.
- VERIFY: implementation complete, running the gate.
- AUDIT: gate green, independent adversarial review in progress.
- FIX: audit found defects, correction round in progress.
- PR: pull request open, awaiting CI or human review.
- DONE: merged, with evidence recorded.
- BLOCKED: waiting on a decision, a dependency, or an out-of-scope failure.

## Rules

- One isolated worktree per task. Never edit the shared main checkout while another task is live.
- Record the base commit. A rebase is a state change, so update the row.
- Verification records real numbers, for example "focused 64 passed, full verify 837 passed", not "tests pass".
- Promote to DONE only with evidence: pull request, commit, and gate output.
- Defects found in audit go back to FIX, not forward to PR. Each round is harsher than the last.
- Serialize what cannot run in parallel: shared contracts, decision log edits, generated output, publication.
- A row that is stale by its own freshness rule flips back to TODO.

## Coordination

- {which tasks may run together, which are serial, who owns integration}
- {issue claims posted}

## Blockers

- {what is stuck, what it is waiting on, who can clear it}
