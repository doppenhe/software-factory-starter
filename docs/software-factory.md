# Software Factory Model

BLUF: the software factory is a repeatable way to turn ambiguous project intent into scoped, planned, executed, assessed, and handoff-ready work.

## Factory Stages

1. Intake: ask the user the finite prompt batch.
2. Scope: define L1 and wait for confirmation.
3. Plan: define L2 as work units.
4. Execute: produce L3 artifacts.
5. Assess: run increasingly harsh quality loops.
6. Resolve: hand off with evidence and open questions.
7. Garden: remove L3 drift from specs and refresh briefs.

When multiple agents or reviewers are involved, GitHub becomes the coordination layer around the factory stages:

1. Epic issue captures the SPEAR cycle and acceptance criteria.
2. Agent task issues split work into independently claimable units.
3. Branches carry each scope lock.
4. Pull requests carry evidence, tests, screenshots when relevant, and documentation updates.
5. Decision records preserve the reasoning that should survive the branch.

## Required Artifacts

Every meaningful project should have:

- `BRIEF.md` or equivalent L1 context.
- `SPEC.md` or equivalent L1 plus L2 context.
- `PROMPT.md` for unattended execution.
- `state/RALPH_STATE.md` for mutable checklist state when the work loops.
- `state/SCOPE.md`
- `state/PLAN.md`
- `state/PROJECT_STATE.md`
- Assessment notes.
- Closeout.

When the project uses GitHub, also include:

- SPEAR epic issue.
- Agent task issues with success criteria.
- Pull request using the repo PR template.
- Decision records for consequential choices.

## Agent Behavior

The agent should behave like an operator, not a chatbot:

- Preserve state.
- Ask clear questions.
- Make tradeoffs explicit.
- Verify claims.
- Keep final handoff short and evidence-backed.
- Design the environment so agents operate on canonical sources of truth.
- Keep implementation detail in code, not specs.

## Harness Components

The complete harness includes:

- Agent inheritance: foundation, domain, and module context.
- SPEAR workflow: gates and inner loop.
- Runtime: prompt, state, verifier, logs, artifacts, and report contract.
- Proof: logs, state, artifacts, and parseable report.
- Coverage: matrix across the axes that matter.
- Economics: cost, return, payback, and sunset discipline.
- Coordination: issues, branches, PR evidence, CI, and decision records for parallel work.
