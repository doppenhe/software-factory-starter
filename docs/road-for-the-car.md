# Design The Road For The Car

BLUF: agent reliability comes from the environment, not just the model. Build the project so the agent reads the right context, edits the right source of truth, and avoids lossy conversions.

## What The Road Means

The road is the working environment around the model:

- File formats.
- Specs.
- State files.
- Interfaces.
- Tools.
- Revision history.
- Rollback paths.
- Review loops.

If the road is bad, the model burns context and accuracy fighting the environment.

## Design Rules

Use agent-native surfaces:

- Markdown for instructions and specs.
- Structured text for state.
- Source files as the home for implementation detail.
- Generated exports only at the edge.

Avoid permanent dependence on:

- Opaque binary formats.
- Lossy intermediate conversions.
- Manual copies of code facts.
- Docs that require a human to remember what is canonical.

## Source Of Truth

Every fact needs one home:

- Goals and principles live in the Brief.
- Journeys, contracts, and approach live in the Spec.
- File paths, function names, variable names, and component interfaces live in code.
- Decisions live in decision records.
- Current work status lives in project state.

Pointers are fine. Duplication is entropy.

## Peer Surfaces

When a project has multiple ways to operate it, each surface should hit the same underlying state:

- CLI.
- API.
- Agent tools.
- Human UI.
- Tests.

Do not make the agent work through a stale translation layer if it can operate on the canonical object.

## Revision And Rollback

Every meaningful agent action should leave a trail:

- Git diff.
- Run log.
- State update.
- Assessment note.
- Closeout.

When something goes wrong, reverse the action and identify the cause.

