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

There are two human gates and one machine gate. The machine gate is `bash scripts/agent-verify.sh`, and it is the one that runs on every pull request without you. Wire it early, watch it fail once on a known-bad input, and then stop reviewing what it already checks.

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
- The verification gate result.
- Tests or e2e evidence when applicable.
- Linked issue and PR evidence when GitHub is used.
- Screenshots and UX critic notes when visible UX changes.

Read the plain-English explanation on every agent pull request first. If it does not make sense to you, the pull request is not ready, whatever the gate says.

## Once Work Runs Unattended

Three things need a human on a schedule rather than per run:

- The watchdog alarm. A scheduled job cannot report its own death, so a watchdog on a different substrate opens an issue when the run log goes stale. Treat that issue as a page.
- The weekly cost rollup. Spend grows without anyone deciding it should. The regression alert is the decision point.
- The decision log. Durable decisions get recorded once and pointed at afterward. If the same question keeps getting re-litigated in issues, it never landed in the log.

## When To Add E2E

For web apps, initialize Playwright after the first runnable app exists:

```bash
bash scripts/setup-playwright.sh
npm run e2e
```

Start with one smoke route and one critical journey.
