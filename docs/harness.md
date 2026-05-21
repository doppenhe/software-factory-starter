# Harness

BLUF: the harness is what turns an agent from a one-shot prompt into a repeatable software factory worker.

## Three Pieces

The harness has three pieces:

- Knowledge: `AGENTS.md`, `CODEX.md`, domain files, craft files, module files.
- Workflow: SPEAR, with human gates around an unattended inner loop.
- Runtime: prompt, state, verifier, logs, artifacts, and report contract.

All three are required. Knowledge without runtime is advice. Runtime without workflow is motion without judgment. Workflow without knowledge makes the agent re-derive the project every run.

## Knowledge Inheritance

Use inheritance so one fact has one home:

- Foundation files define identity, beliefs, values, mission, and vision.
- Domain files define durable craft rules.
- Module files define product surfaces.

Module files import domain files. Domain files import foundation files. Do not duplicate foundation facts into modules.

## Runtime Contract

The runtime uses two core files:

- `PROMPT.md`: the recipe. It changes rarely.
- `RALPH_STATE.md`: the mutable checklist. It changes every iteration.

The verifier decides whether work is done. The report block makes the runner parseable.

## Modes

Use:

- Foreground for exploration and calibration.
- Background for one scoped task.
- Map-reduce for independent sweeps where one reviewer can reduce many outputs.

## Human Role

Humans choose the bets, write the rubrics, approve gates, and reduce parallel outputs. Agents run the inner loop.

