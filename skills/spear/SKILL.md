# SPEAR

SPEAR is the default workflow for non-trivial work.

## When To Use SPEAR

Use SPEAR for:

- New project setup.
- Product or feature definition.
- Multi-file code changes.
- Architecture decisions.
- Technical documentation.
- Memos, reports, and other artifacts another human will read.
- Any task where getting the scope wrong would waste meaningful time.

Skip SPEAR for:

- Factual lookups.
- One-line answers.
- Trivial formatting.
- Small mechanical edits.

When skipping, say why.

## Phase 1: Scope

Produce a SCOPE block with six fields:

1. Audience: who reads or uses the output.
2. Job: what changes after the output exists.
3. Success criteria: observable signs the work is done.
4. Non-goals: what is explicitly out of scope.
5. Format: repo, app, memo, deck, PR, doc, or other artifact.
6. Unknowns: what remains unresolved.

Stop after Scope and wait for confirmation.

## Phase 2: Plan

Translate scope into work units. Each unit has:

- GOAL: what the user or reader takes away.
- APPROACH: the structural or implementation choice.

The plan is the L2 MARR artifact.

## Phase 3: Execute

Do the work. Update durable state as you go.

Required execution artifacts:

- `state/PROJECT_STATE.md`
- Relevant files in `work/`, `docs/`, source directories, or final destination.
- Iteration notes when useful.

## Phase 4: Assess

Run assessment rounds until convergence.

Each round must be harsher than the last:

- R1: baseline rubric pass.
- R2: user skepticism, feasibility, single-message clarity.
- R3: specificity, 15-second skim test, steel-man critique, standalone reference.
- R4: truthfulness, placeholder-as-defect, claim verification.
- R5 and beyond: source re-pull, internal-language cleanup, stale assumption search.

If a harsher round finds no material defects, stop.

## Phase 5: Resolve

Create a closeout under one page:

- What changed.
- Evidence.
- Open questions.
- Next iteration.

The closeout is a manifest, not a second memo.

