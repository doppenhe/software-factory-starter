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
Worktree: {path}
Scope lock: {files or subsystem}
```

The scope lock is the coordination mechanism. Do not edit outside it unless the issue or maintainer explicitly allows it.

## Worktrees

Every parallel task gets its own git worktree. Do not edit the shared main checkout while another agent may be working there.

```bash
git worktree add ../{repo}-{issue-number}-{slug} -b codex/{issue-number}-{slug} origin/main
```

Record the base commit in the campaign state file. A rebase changes the base, so update the row. Remove the worktree at closeout.

Branch prefix is `codex/` unless the issue says otherwise. Commit subjects carry a bracketed type and a slug, for example `[intake] pipeline-sync 2026-08-27, nightly sync` or `[#443] add bounded source cache`, so the log reads as a work ledger rather than a diff summary.

## Parallelization Labels

Use project-specific labels, but these defaults work well:

- `loop:principal`: reduces the primary reviewer's drag or improves their main workflow.
- `loop:product`: changes product behavior or UX.
- `loop:data`: improves provenance, freshness, confidence, state, or data quality.
- `surface:web`: web UI or server work.
- `surface:cli-agent`: CLI or agent workflow work.
- `surface:github-actions`: CI and scheduled automation work.
- `type:agent-contract`: shared schema, data contract, or cross-surface agreement.
- `type:data-exposure`: exposes source, freshness, confidence, or decision state to a reviewer.
- `type:ux`: visible product UX.
- `type:testing`: testing, verification, or CI gates.
- `type:infra`: deployment or tooling.
- `status:ready`: ready for an agent to claim.
- `status:blocked`: blocked on a decision, dependency, or contract.
- `parallel:safe`: can run in parallel with other work.
- `parallel:shared-contract-first`: requires a shared contract before implementation splits.
- `epic`: parent issue tracking a multi-PR effort.

Two label shapes earn their place once the factory runs unattended. A campaign label, for example `spear:{epic-slug}` or `audit:P0`, groups every issue in one run so the batch can be queried later. An override label, for example `regen-ok`, is the documented escape hatch for a guard that would otherwise block a legitimately large diff. Name the guard the label overrides, or it becomes a way to skip the guard by habit.

Do not copy these labels blindly if your project has better domain words. Preserve the structure: loop, surface, type, status, and parallelization.

## PR Evidence Standard

Each PR should include:

```md
## Plain-English Explanation
## What Changed
## Evidence
## Tests
## Screenshots, if UI
## Documentation Updated
## Risks
```

The plain-English explanation answers two questions for a reader who does not know the repository: what was wrong, and how this change addresses it. Simple words, and define any technical term it cannot avoid. It is the difference between a merged agent pull request and an archaeological dig six months later.

Evidence includes the verification gate result from `bash scripts/agent-verify.sh`. See `docs/agent-verification.md`.

Use `Closes #N` for complete resolution and `Part of #N` for partial work.

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
- Never use `--no-verify`. Never merge on a red gate.
- Use a pull request for autonomous, bulk, or destructive work. Use a direct commit only when a human explicitly asked for the action and it is neither bulk nor destructive.
- On failure, open a draft pull request and report. Do not auto-merge autonomous work.
- Leave a short closeout that maps the implementation to user-facing outcomes.

## Failure Triage

When a check fails outside the issue scope, do not fix it. Comment:

```md
Blocked by external failure:
- Check:
- Evidence:
- Why outside scope:
```

## Multiple Repositories

When work spans repositories, one repository owns the operating model and the others point at it. Do not fork the rules.

The canonical repository holds the operating model, the decision log, and the shared contracts. Satellite repositories keep an `AGENTS.md` that links to it, plus their own decision log for decisions that affect only them. Epics live in the canonical repository. Child task issues live in whichever repository owns the code.

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
