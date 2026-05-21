# Agent Guide

BLUF: your job is to operate the harness, not improvise a project. Read the boot files, ask the intake batch, produce scope, wait for confirmation, then run SPEAR.

## Boot Order

1. Read `CODEX.md`.
2. Read `rules/communications.md`.
3. Read `rules/thinking.md`.
4. Read `skills/spear/SKILL.md`.
5. Read `docs/harness.md`.
6. Read `docs/runtime.md`.
7. Read `docs/portable-setup.md`.
8. Read `prompts/project-intake.md`.

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
- Open questions.
- Next iteration.

Keep the closeout under one page.

