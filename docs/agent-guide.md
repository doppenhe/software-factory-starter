# Agent Guide

BLUF: your job is to operate the harness, not improvise a project. Read the boot files, ask the intake batch, produce scope, wait for confirmation, then run SPEAR.

## Boot Order

1. In a local clone, run `git pull`. If it fails, stop and surface the error.
2. Read `CODEX.md`.
3. Read `rules/communications.md`.
4. Read `rules/thinking.md`.
5. Read `skills/spear/SKILL.md`.
6. Read `docs/runtime.md`.
7. Read `docs/agent-verification.md`.
8. Read `docs/github-coordination.md` when the project uses GitHub.
9. Read `docs/contracts.md` when more than one writer touches the shape you are changing.
10. Read `docs/data-safety.md` when the project holds real data.
11. Read `docs/ux-critic.md` when visible UX changes.
12. Read `docs/portable-setup.md`.
13. Read `prompts/project-intake.md`.

If generated project files are missing, run:

```bash
python3 scripts/init-project.py --name "<project name>"
```

## First Response

Ask the project intake questions as one batch. Do not drip-feed.

After the user answers, create or update:

- `state/SCOPE.md`
- `state/PROJECT_STATE.md`

Then stop for Scope confirmation.

## After Scope Confirmation

Create or update:

- `state/PLAN.md`
- `SPEC.md` if the project needs L1 plus L2 context.
- `BRIEF.md` if QA, review, or orientation agents need L1 context.
- `PROMPT.md` if unattended execution is expected.
- `state/RALPH_STATE.md` if the run needs a mutable checklist.

## Execution Rules

- Keep L1 and L2 in specs.
- Keep L3 in code.
- Keep one fact in one home.
- Update state after meaningful work.
- Use the smallest runtime mode that fits.
- Do not mark work done without evidence.
- When GitHub is in use, claim the issue before editing and work in your own worktree.
- Run `bash scripts/agent-verify.sh` before opening a pull request and put the result in the evidence.
- Open the PR with a plain-English explanation of what was wrong and how the change addresses it, then branch, scope lock, tests, screenshots when relevant, docs updated, and risks.
- Never use `--no-verify`. If a check fails outside your scope, post the blocked-by-external-failure block instead of fixing it.
- If visible UX changes, run the UX critic before asking for human review.

## Parallel Work

Use GitHub issues as the task queue for parallel agents.

Each agent task issue needs goal, plain-English explanation, success criteria, scope, non-goals, inputs, expected output, test plan, parallelization notes, and documentation updates. Claim the issue with agent name, branch, worktree, and scope lock before editing. Do not expand scope silently. If a shared contract is missing, build the contract bundle first: doc, schema, fixtures, and validator wired into the gate. See `docs/contracts.md`.

## Defect Flow

Keep the jobs separate. Mixing them produces fixes nobody asked for inside a scan nobody can review.

- Scanner finds the backlog.
- Audit names the risks.
- Builder implements.
- Fixer works the queued defects.
- Reviewer reduces parallel outputs.
- UX critic catches layout, copy, action ergonomics, and data density before a human absorbs the cost.

Do not mix defect finding with production fixes unless the prompt says to.

## Checklist Before Execution

- Scope is confirmed and non-goals are explicit.
- Unknowns are resolved or accepted.
- The plan has a goal and an approach for every work unit.
- The state file reflects the current phase.
- The runtime mode is chosen: foreground, background, map-reduce, remote, or scheduled.
- The verification gate exists, runs offline, and has been watched failing on a known-bad input.
- Proof surfaces are named and coverage axes are defined when quality matters.
- Shared contracts are stable, each with a doc, schema, fixtures, and validator.
- Every parallel task has its own worktree and a recorded base commit.

## Checklist Before Handoff

- The work was assessed with increasingly harsh lenses.
- No unresolved placeholders remain.
- Claims about the world are sourced or marked as assumptions.
- Specs hold L1 and L2, not duplicated L3, and briefs are refreshed if specs changed.
- Logs, state, artifacts, and reports agree.
- `bash scripts/agent-verify.sh` passed and its result is in the pull request evidence.
- The pull request opens with a plain-English explanation, then issue, tests, screenshots when UI changed, docs updated, and risks.
- No secret, raw source content, or hand-edited generated output entered the branch at any commit.
- `state/PROJECT_STATE.md` is updated and the closeout exists.

## Report Contract

End unattended iterations with:

```text
<ralph-report>
ITERATION:
PHASE:
COMPLETED:
REFERENCE:
DEFECTS_FOUND:
DEFECTS_FIXED:
DEFECTS_REMAINING:
CYCLES_RUN:
FILES_CHANGED:
TESTS:
NEXT:
BLOCKERS:
PROGRESS:
</ralph-report>
<promise>COMPLETE</promise>
```

Validate reports with:

```bash
python3 scripts/ralph.py check-report <path>
```

## Closeout

Resolve with:

- What changed.
- Evidence.
- Tests.
- Screenshots if UI changed.
- Documentation updated.
- Risks.
- Open questions.
- Next iteration.

Keep the closeout under one page.
