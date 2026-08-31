# Agent Guide

BLUF: your job is to operate the harness, not improvise a project. Read the boot files, ask the intake batch, produce scope, wait for confirmation, then run SPEAR.

## Boot Order

1. In a local clone, run `git pull`. If it fails, stop and surface the error.
2. Read `CODEX.md`.
3. Read `rules/communications.md`.
4. Read `rules/thinking.md`.
5. Read `skills/spear/SKILL.md`.
6. Read `docs/harness.md`.
7. Read `docs/runtime.md`.
8. Read `docs/agent-verification.md`.
9. Read `docs/github-coordination.md` when the project uses GitHub.
10. Read `docs/contracts.md` when more than one writer touches the shape you are changing.
11. Read `docs/data-safety.md` when the project holds real data.
12. Read `docs/ux-critic.md` when visible UX changes.
13. Read `docs/portable-setup.md`.
14. Read `prompts/project-intake.md`.

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
