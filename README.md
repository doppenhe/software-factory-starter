# Software Factory Starter

BLUF: this is an operating template for running software projects with coding agents. It gives a cold agent enough structure to ask the right questions, define the work, run a gated workflow, keep state a later run can resume from, and prove what it did. It is not an app template and it contains no application code.

The rules here were not designed in the abstract. They come from repositories where agents open most of the pull requests, and every one of them exists because its absence caused a specific problem.

## Who This Is For

You are running coding agents against a real repository, more than one at a time, and you have hit at least one of these:

- An agent produced polished work on the wrong job.
- Two agents edited the same files and neither knew.
- An agent reported success and the tests had not run.
- A run ended and the next session had no idea what had happened.
- Something automated has been failing for a week and nobody noticed.

If none of that has happened yet, this repository will read as overhead. Come back when it does.

## Quickstart

```bash
git clone https://github.com/doppenhe/software-factory-starter
cd software-factory-starter
python3 scripts/init-project.py --name "Your Project"
bash scripts/preflight.sh
```

Then wire the gate that every agent pull request has to pass:

```bash
cp templates/agent-verify.sh scripts/agent-verify.sh
chmod +x scripts/agent-verify.sh
bash scripts/agent-verify.sh
```

Replace its example checks with your project's own, and keep the failing-fixture proof. Then point an agent at the repository:

```text
Read CODEX.md and start the project intake.
```

The agent reads the operating model, asks the intake questions, produces a scope, and stops for your confirmation before it implements anything.

Requirements are git, Bash, and Python 3. Browser end to end testing is optional and pulls in Node only if you ask for it.

## The Model

Work runs through SPEAR: Scope, Plan, Execute, Assess, Resolve. Two human gates, one after Scope and one before handoff, with an unattended loop between Execute and Assess. Each assessment round uses a harsher lens than the last.

Artifacts get thought about at three levels, borrowed from David Marr: why the artifact exists, how it is structured, and the artifact itself. Scope answers the first, Plan answers the second, Execute produces the third. When something comes out polished but wrong, this tells you which altitude failed.

The harness has four pieces, and dropping any one makes the loop fragile:

- Knowledge: what the agent inherits before it reads the task.
- Workflow: the gates and the inner loop.
- Runtime: prompt, state, verifier, logs, artifacts, report contract.
- Coordination: issues, branches, worktrees, pull requests, CI, decision records.

## What Is In Here

Start with `CODEX.md`. It is the operating model and the file an agent boots from. Everything else is detail behind it.

| Document | Answers |
|----------|---------|
| `docs/agent-verification.md` | What has to pass before an agent may open a pull request, and why a verifier nobody has watched fail is not proof |
| `docs/github-coordination.md` | Issues, claims, scope locks, worktrees, labels, evidence, merge discipline, multiple repositories |
| `docs/contracts.md` | How a shared data shape ships so two parallel agents cannot violate it |
| `docs/runtime.md` | Prompt, campaign state, report contract, and the modes beyond one terminal |
| `docs/scheduled-work.md` | Recurring agent work: committed state, watchdogs, content-free run logs |
| `docs/data-safety.md` | Secret scanning, where raw source material may live, retention |
| `docs/cost-and-telemetry.md` | Tracking what the agents cost before the bill is an argument |
| `docs/e2e-testing.md` | Browser proof surfaces, when they earn their cost |
| `docs/ux-critic.md` | Reviewing visible product changes before a human absorbs the cost |
| `docs/agent-guide.md` | The short version for the agent |
| `docs/human-guide.md` | The short version for you |
| `docs/portable-setup.md` | Setup on a new machine, and the portability rules |

`templates/` holds the artifacts a run produces: scope, plan, contracts, work packets, assessments, closeouts, campaign state. `examples/full-run/` shows them filled in. `.github/` holds issue and pull request templates that ask for evidence rather than narrative.

## Two Rules Worth Stealing Even If You Ignore The Rest

Make the verifier prove it can fail. The gate builds a known-bad input, runs the real validator against it, and fails if that validator passes. Everything else the harness claims rests on this one check.

Make every agent pull request open with a plain-English explanation of what was wrong and how the change addresses it, written for someone who has never seen the repository. It is the difference between a merged pull request and an archaeological dig six months later.

## What This Is Not

It does not call a model, orchestrate worktrees, or create issues for you. The runner validates a report block and prints the next task. Automating the rest is a project decision, and hard-coding it here would make the repository less portable, not more useful.

It also assumes GitHub for coordination. The workflow survives elsewhere, but the issue templates and labels would need translating.

## License

MIT. See `LICENSE`.
