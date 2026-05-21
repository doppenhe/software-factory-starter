# Checklists

## New Project Start

- Read `CODEX.md`.
- Read the communications and thinking rules.
- Read SPEAR.
- Read harness and runtime docs.
- If starter files do not exist, run `python3 scripts/init-project.py --name "<project name>"`.
- Ask the project intake prompt batch.
- Create `state/SCOPE.md`.
- Stop for confirmation.

## Before Execution

- Scope is confirmed.
- Non-goals are explicit.
- Unknowns are either resolved or accepted.
- Plan has GOAL and APPROACH for every work unit.
- State file reflects the current phase.
- Runtime mode is chosen: foreground, background, or map-reduce.
- Proof surfaces are named.
- Coverage axes are defined when QA matters.
- Browser e2e decision is made for web projects.

## Before Handoff

- Work has been assessed with increasingly harsh lenses.
- Final artifacts contain no unresolved placeholders.
- Claims about the world are sourced or marked as assumptions.
- Specs contain L1 and L2, not duplicated L3.
- Briefs are refreshed if specs changed.
- Logs, state, artifacts, and reports agree.
- E2E evidence is attached when browser behavior is in scope.
- `state/PROJECT_STATE.md` is updated.
- `CLOSEOUT.md` exists or is embedded in the final response.

## Spec Gardening

- Classify changed spec content as L1, L2, or L3.
- Keep goals, principles, constraints, journeys, state machines, contracts, and data representations.
- Remove file paths, function names, props, variables, and implementation mechanics unless they are pointers.
- Check whether each spec sentence survives the next refactor.
- Run verification.
