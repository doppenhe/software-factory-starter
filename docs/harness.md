# Harness

BLUF: the harness is what turns an agent from a one-shot prompt into a repeatable software factory worker.

## Four Pieces

The harness has four pieces:

- Knowledge: `AGENTS.md`, `CODEX.md`, domain files, craft files, module files.
- Workflow: SPEAR, with human gates around an unattended inner loop.
- Runtime: prompt, state, verifier, logs, artifacts, and report contract.
- Coordination: GitHub issues, pull requests, CI, and decision records when the work is shared.

All four are required once work is shared. Knowledge without runtime is advice. Runtime without workflow is motion without judgment. Workflow without knowledge makes the agent re-derive the project every run. Shared work without coordination makes agents collide silently.

Coordination becomes required when more than one agent, reviewer, or deployment path is involved. Local state tells one runner what happened. GitHub tells the whole system what is claimed, blocked, reviewed, merged, and still risky.

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

The verifier decides whether work is done. The report block makes the runner parseable. The verifier is one command, `bash scripts/agent-verify.sh`, and it must be provably able to fail. See `docs/agent-verification.md`.

For parallel work, the runtime also points to the GitHub issue and PR. The issue defines the scope lock. The PR proves what changed.

## Modes

Use:

- Foreground for exploration and calibration.
- Background for one scoped task in its own worktree.
- Map-reduce for independent sweeps where one reviewer can reduce many outputs.
- GitHub-coordinated parallelism for independent agent task issues with explicit scope locks.
- Remote for work that must survive the laptop closing.
- Scheduled for recurring work with a stable recipe, committed state, and an independent watchdog.

## Human Role

Humans choose the bets, write the rubrics, approve gates, and reduce parallel outputs. Agents run the inner loop.
