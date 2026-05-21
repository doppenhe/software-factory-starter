# Example PLAN

## Source

Scope file: `state/SCOPE.md`

## Work Units

### Unit 1

GOAL: Give a cold agent a reliable boot path.

APPROACH: Put the operating contract in `CODEX.md`, then point compatibility files toward it.

STATUS: complete

### Unit 2

GOAL: Make the first user conversation finite and useful.

APPROACH: Provide batched intake prompts with required and optional sections.

STATUS: complete

### Unit 3

GOAL: Make project state resumable after context loss.

APPROACH: Use `state/PROJECT_STATE.md` as the durable handoff document.

STATUS: complete

## Risks

- Agents may skip the Scope gate unless the instruction is repeated in multiple entrypoints.
- Templates may become stale if not used in real runs.

## Verification

- Check required files exist.
- Check no template contains final-artifact placeholders outside template files.
- Check no Unicode em dash or en dash characters exist.

## Exit Criteria

A new agent can read the repo, ask intake prompts, produce scope, and stop for confirmation.

