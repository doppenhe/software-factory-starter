# GitHub Coordination

BLUF: production agent work should use GitHub issues, branches, pull requests, and CI as the shared coordination layer. Local state files help a single run resume. GitHub lets many agents and humans see, split, review, and merge work safely.

## When This Applies

Use this layer when a project has a GitHub repo and more than one meaningful task, agent, reviewer, or deployment path.

For small solo runs, `state/PROJECT_STATE.md` and `state/RALPH_STATE.md` may be enough. For parallel work, GitHub should be canonical.

## Coordination Objects

- Epic issue: the current SPEAR cycle, including audience, job, success criteria, non-goals, unknowns, human gates, and child tasks.
- Agent task issue: one decision-complete unit of work that an agent can own.
- Branch: one scoped implementation lane.
- Pull request: evidence, review, CI, and merge unit.
- Decision record: durable L1 and L2 decisions that should survive refactors.

## Agent Task Issue Contract

Each agent task issue should include:

- Goal.
- Success criteria.
- Scope.
- Non-goals.
- Inputs.
- Expected output.
- Test plan.
- Parallelization notes.
- Documentation updates.

If the issue leaves the agent to invent the API shape, UX hierarchy, data model, or success criteria, it is not ready for parallel work.

## Claiming Work

Before editing files, comment on the issue:

```md
CLAIMED by agent: {name}
Branch: codex/{issue-number}-{slug}
Scope lock: {files or subsystem}
```

The scope lock is the coordination mechanism. Do not edit outside it unless the issue or maintainer explicitly allows it.

## Parallelization Labels

Use project-specific labels, but these defaults work well:

- `loop:primary-user`: reduces the primary user's review drag or improves their main workflow.
- `loop:product`: changes product behavior or UX.
- `loop:data`: improves provenance, freshness, confidence, state, or data quality.
- `surface:web`: web UI or server work.
- `surface:cli`: CLI or agent workflow work.
- `type:contract`: shared schema, data contract, or cross-surface agreement.
- `type:ux`: visible product UX.
- `type:infra`: CI, tests, deployment, or tooling.
- `status:ready`: ready for an agent to claim.
- `status:blocked`: blocked on a decision, dependency, or contract.
- `parallel:safe`: can run in parallel with other work.
- `parallel:shared-contract-first`: requires a shared contract before implementation splits.

Do not copy these labels blindly if your project has better domain words. Preserve the structure: loop, surface, type, status, and parallelization.

## PR Evidence Standard

Each PR should include:

```md
## What Changed
## Evidence
## Tests
## Screenshots, if UI
## Documentation Updated
## Risks
```

Evidence can include:

- CI runs.
- Test logs.
- Screenshots.
- Playwright reports.
- Generated artifacts.
- Links to commits, issues, or workflow runs.

Agent narrative is not evidence by itself.

## Shared Contract First

If multiple surfaces will write or read the same state, define the shared contract before parallel implementation.

Examples:

- UI and CLI both write the same decision record.
- Agents and web app both read the same generated index.
- CI and local verification both enforce the same schema.

Contract first prevents parallel agents from inventing incompatible shapes.

## Merge Discipline

- Keep branches scoped to the issue.
- Keep docs updated when behavior, contracts, CI, or agent workflow changes.
- Do not merge when CI evidence is missing unless the maintainer explicitly accepts the risk.
- Leave a short closeout that maps the implementation to user-facing outcomes.

## Relationship To Local State

Use local state files for:

- Current SPEAR phase.
- Active assumptions.
- Unattended checklist state.
- Run logs and closeout notes.

Use GitHub for:

- Multi-agent task ownership.
- Review history.
- Branch scope.
- CI evidence.
- Merge decisions.
- Cross-agent visibility.
