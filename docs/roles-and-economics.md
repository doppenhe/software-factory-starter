# Roles And Economics

BLUF: the software factory changes the management job. Humans pick bets and write rubrics. Agents run the loop.

## Roles

Use three human roles when the factory scales:

- Fleet manager: runs agents, watches worktrees, monitors green PRs.
- Process lead: owns specs, review gates, instrumentation, release notes, and RCAs.
- Platform PM: owns the CLI, APIs, runners, and internal platform that turns goals into shipped code.

## Portfolio Roadmap

Treat each feature as a portfolio bet:

- Build cost.
- Expected return.
- Payback.
- Risk.
- Evidence.

Weekly review beats quarterly planning when build cost and iteration cost collapse.

## Rollout

Start narrow:

1. Pick one team that already writes good specs.
2. Run a four-week pilot on one feature with one runner.
3. Measure iterations, defects, and hours saved.
4. Expand only when the pilot ships.

If the pilot does not ship, the harness is not ready.

