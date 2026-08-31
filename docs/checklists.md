# Checklists

## New Project Start

- Run `git pull` in a local clone.
- Read `CODEX.md`.
- Read the communications and thinking rules.
- Read SPEAR.
- Read harness and runtime docs.
- Read GitHub coordination docs when the project uses GitHub.
- Read UX critic docs when visible UX changes.
- If starter files do not exist, run `python3 scripts/init-project.py --name "<project name>"`.
- Ask the project intake prompt batch.
- Copy `templates/agent-verify.sh` to `scripts/agent-verify.sh` and wire the project's checks.
- Create `state/SCOPE.md`.
- Stop for confirmation.

## Before Execution

- Scope is confirmed.
- Non-goals are explicit.
- Unknowns are either resolved or accepted.
- Plan has GOAL and APPROACH for every work unit.
- State file reflects the current phase.
- Runtime mode is chosen: foreground, background, map-reduce, remote, or scheduled.
- The verification gate exists, runs offline, and has been watched failing on a known-bad input.
- Proof surfaces are named.
- Coverage axes are defined when QA matters.
- Browser e2e decision is made for web projects.
- GitHub epic and task issue strategy is named when parallel agents are expected.
- Shared contracts are stable before independent implementation starts, and each ships a doc, schema, fixtures, and validator.
- Every parallel task has its own worktree and a recorded base commit.

## Before Handoff

- Work has been assessed with increasingly harsh lenses.
- Final artifacts contain no unresolved placeholders.
- Claims about the world are sourced or marked as assumptions.
- Specs contain L1 and L2, not duplicated L3.
- Briefs are refreshed if specs changed.
- Logs, state, artifacts, and reports agree.
- E2E evidence is attached when browser behavior is in scope.
- `bash scripts/agent-verify.sh` passed and its result is in the PR evidence.
- PR opens with a plain-English explanation, then links issue, tests, screenshots when UI changed, docs updated, and risks.
- No secret, raw source content, or hand-edited generated output entered the branch at any commit.
- UX critic notes are included for visible UX changes.
- `state/PROJECT_STATE.md` is updated.
- `CLOSEOUT.md` exists or is embedded in the final response.

## Spec Gardening

- Classify changed spec content as L1, L2, or L3.
- Keep goals, principles, constraints, journeys, state machines, contracts, and data representations.
- Remove file paths, function names, props, variables, and implementation mechanics unless they are pointers.
- Check whether each spec sentence survives the next refactor.
- Run verification.
