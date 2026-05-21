# Proof And Coverage

BLUF: proof of work is not a claim. It is logs, state, artifacts, and reports tied to a coverage matrix.

## Proof Surfaces

Require four proof surfaces for meaningful runs:

- Logs: what happened.
- State: what changed.
- Artifacts: what was produced.
- Reports: parseable summary.

When work lands through GitHub, the pull request is the proof index. It should link the issue, list commands and CI checks, attach screenshots for visible UX, name documentation updates, and call out residual risks.

## Closed Loops

Prefer closed loops where possible:

- Browser checks for visual and interaction behavior.
- Staging checks for real end-to-end flows.
- Rubric checks for qualitative and persona coverage.
- UX critic checks for visible product changes.

For browser checks, default to Playwright unless the project already standardizes elsewhere. Capture traces, screenshots, and console errors so the next agent has evidence, not vibes.

## Coverage Matrix

Coverage is a span, not a raw count. Define axes before testing:

- Persona.
- Module.
- Viewport.
- Auth state.
- Data state.
- Network state.
- Browser or platform.
- Payment or integration state.

A dense cluster of tests in one cell is not broad coverage.

## Defect Flow

Separate jobs:

- Scanner finds backlog.
- Audit names risks.
- Builder implements.
- Fixer handles queued defects.
- Reviewer reduces outputs.
- UX critic catches layout, copy, action ergonomics, evidence visibility, and data density issues before a human reviewer absorbs the cost.

Do not mix pure defect finding with production fixes unless the prompt explicitly allows it.
