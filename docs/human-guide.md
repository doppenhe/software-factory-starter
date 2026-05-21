# Human Guide

BLUF: use this repo to start a project with a disciplined agent harness instead of a loose prompt. You provide intent and gates. The agent runs the inner loop.

## First Use

```bash
git clone <repo-url>
cd software-factory-starter
python3 scripts/init-project.py --name "Your Project"
bash scripts/preflight.sh
```

Then tell an agent:

```text
Read CODEX.md and start project intake.
```

## What You Own

The human owns:

- The project bet.
- The Scope gate.
- The rubric.
- The Resolve gate.
- Any decision to expand, stop, or change direction.
- The choice of which epics and agent task issues are worth running in parallel.

The agent owns:

- Drafting scope from intake.
- Turning scope into plan.
- Executing the inner loop.
- Running verification.
- Producing evidence.
- Keeping state current.
- Claiming GitHub issues and keeping PR evidence current when GitHub is used.

## The Gates

Scope gate:

- Confirm audience, job, success criteria, non-goals, format, and unknowns.
- Do not let the agent start implementation before this is right.

Resolve gate:

- Review what changed, evidence, open questions, and next iteration.
- If evidence is weak, send the agent back to Assess.

## Recommended Flow

1. Run project intake.
2. Confirm `state/SCOPE.md`.
3. Review `state/PLAN.md`.
4. Let the agent execute.
5. Require proof surfaces.
6. Review `CLOSEOUT.md`.

For parallel agent work, create a SPEAR epic issue first. Split execution into agent task issues only after the shared contract is stable enough that agents can work without stepping on each other. Ask each agent to claim one issue, create one branch, and open one PR with evidence.

## Proof Standard

For meaningful work, ask for:

- Logs.
- State.
- Artifacts.
- Parsed report block.
- Tests or e2e evidence when applicable.
- Linked issue and PR evidence when GitHub is used.
- Screenshots and UX critic notes when visible UX changes.

## When To Add E2E

For web apps, initialize Playwright after the first runnable app exists:

```bash
bash scripts/setup-playwright.sh
npm run e2e
```

Start with one smoke route and one critical journey.
