# Software Factory Starter

BLUF: this repository is a portable starter kit for agent-run software projects. It gives a cold agent enough structure to ask the right questions, define the work, run SPEAR, track state, assess quality, and hand off cleanly.

## What This Is

This is not an app template. It is an operating template for starting any software project with agents.

It includes:

- A boot contract for agents.
- SPEAR workflow instructions.
- MARR three-level thinking rules.
- Road design rules for agent-native environments.
- Harness runtime conventions.
- Intake prompts.
- Scope, plan, state, assessment, and closeout templates.
- Agent inheritance, runtime, coverage, and economics templates.
- Example filled artifacts.
- Durable state conventions.

## How To Use It

Point an agent at this repository and tell it:

```text
Read CODEX.md and start the project intake.
```

The agent should read the operating model, ask the prompts in `prompts/project-intake.md`, produce a SCOPE block, and wait for confirmation before implementation.

## Guides

- Human guide: `docs/human-guide.md`
- Agent guide: `docs/agent-guide.md`
- Portable setup: `docs/portable-setup.md`
- E2E testing: `docs/e2e-testing.md`

## Portable Setup

After cloning on a new machine:

```bash
python3 scripts/init-project.py --name "Your Project"
bash scripts/preflight.sh
```

This creates local starter files such as `SPEC.md`, `BRIEF.md`, `PROMPT.md`, `state/SCOPE.md`, `state/PLAN.md`, and `state/RALPH_STATE.md`. It uses only Python 3 and Bash.

## Optional E2E

For web projects, add Playwright when you need browser-backed proof:

```bash
bash scripts/setup-playwright.sh
npm run e2e
```

See `docs/e2e-testing.md` and `templates/e2e-plan.md`.

## First Files To Read

1. `CODEX.md`
2. `rules/communications.md`
3. `rules/thinking.md`
4. `skills/spear/SKILL.md`
5. `prompts/project-intake.md`
6. `docs/harness.md`
7. `docs/runtime.md`
8. `docs/human-guide.md` for humans
9. `docs/agent-guide.md` for agents

## Core Workflow

SPEAR is the required workflow for non-trivial work:

1. Scope
2. Plan
3. Execute
4. Assess
5. Resolve

MARR is the thinking model behind substantive artifacts:

- L1: why this work exists.
- L2: how the work is structured.
- L3: the implemented artifact.

The harness has three pieces:

- Knowledge: agent instructions and inherited context.
- Workflow: SPEAR.
- Runtime: prompt, state, verifier, logs, artifacts, and report contract.

## Directory Structure

```text
.
├── .github/
├── AGENTS.md
├── CODEX.md
├── README.md
├── agents/
├── docs/
├── examples/
├── prompts/
├── rules/
├── scripts/
├── skills/
├── state/
├── templates/
└── work/
```

## Human Gate Rule

For non-trivial work, the agent must stop after Scope and wait for confirmation. This prevents polished work on the wrong job.
