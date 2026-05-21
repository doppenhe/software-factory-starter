# Software Factory Operating Model

This repository is a complete starting point for an agent-operated software project. A new agent should be able to read this file, ask the intake prompts in `prompts/project-intake.md`, create the starter artifacts, and begin work using SPEAR.

## Prime Directive

Operate like a disciplined software factory:

- Start with scope, not implementation.
- Make assumptions visible.
- Keep state durable.
- Use review loops that get harsher each round.
- Leave artifacts another agent can resume from.

If the user asks for non-trivial work, run SPEAR. If the work is trivial, say that SPEAR is being skipped and why.

## Required Boot Sequence

1. Read `CODEX.md`.
2. Read `rules/communications.md`.
3. Read `rules/thinking.md`.
4. Read `skills/spear/SKILL.md`.
5. Read `docs/harness.md`.
6. Read `docs/runtime.md`.
7. If starter files do not exist, run `python3 scripts/init-project.py --name "<project name>"`.
8. Ask the user the questions in `prompts/project-intake.md`.
9. Create or update `state/PROJECT_STATE.md`.
10. Produce a SCOPE block and wait for confirmation.
11. After confirmation, create the PLAN.
12. Execute, assess, and resolve.

Do not start implementation before the SCOPE gate unless the user explicitly asks for a quick, trivial change.

## Operating Principles

### Harness

The software factory has three required pieces:

- Knowledge: agent instructions, domain files, craft files, and module files.
- Workflow: SPEAR gates and unattended inner loops.
- Runtime: prompt, state, verifier, logs, artifacts, and report contract.

Skip any one and the loop becomes fragile.

### Design The Road

AI performance is constrained by the environment as much as by the model. Design the project road so agents can operate reliably.

Road design means:

- Use formats agents can read and edit accurately.
- Prefer plain text, Markdown, structured data, and source files over opaque binary formats.
- Avoid lossy round trips through intermediate representations.
- Keep one source of truth for every fact, decision, contract, and implementation detail.
- Make CLI, API, agent tools, and human UI peers over the same underlying state when possible.
- Track every meaningful change with revision history and rollback.
- Optimize internal representations for token efficiency and agent accuracy before legacy compatibility.

Bad roads look like:

- High-token formats that consume context without adding guidance.
- Specs that duplicate code-level details.
- Generated artifacts that cannot be cleanly re-read or edited.
- Manual state that diverges from the source of truth.
- Translation layers that compound small errors over many iterations.

### SPEAR

SPEAR is the workflow:

- Scope
- Plan
- Execute
- Assess
- Resolve

There are two human gates:

- Scope gate before execution.
- Resolve gate before handoff.

The inner loop between Execute and Assess runs unattended until convergence or a blocker.

### MARR Three Levels

Use MARR for substantive artifacts:

- L1, computational level: why this artifact exists and what changes after it is read.
- L2, algorithmic level: the structure, sequence, rubric, and approach.
- L3, implementation level: the actual prose, code, design, or artifact.

In this repository:

- SPEAR Scope captures L1.
- SPEAR Plan captures L2.
- SPEAR Execute produces L3.

If an output is polished but wrong, diagnose the altitude:

- Wrong purpose means L1 failed.
- Wrong structure means L2 failed.
- Weak execution means L3 failed.

### Spec Entropy

Managing AI is managing entropy. Specs drift toward disorder unless maintained.

The rule:

- L1 and L2 belong in specs.
- L3 belongs in the codebase.
- Specs may point to code, but they must not duplicate code-level details.

Use the refactor test:

```text
Will this still be true after the next refactor?
```

If yes, it can live in the spec. If no, it belongs in code, tests, generated docs, or a pointer.

Context tiers:

- Brief: L1 only. Used by QA, audit, review, and orientation agents.
- Spec: L1 plus L2. Used by planning and coding agents.
- Codebase: L3. Used when implementation detail is needed.

After every meaningful batch of agent work, run spec gardening:

1. Check what changed in docs and specs.
2. Remove implementation details that crept into specs.
3. Replace duplicated L3 with pointers to source files when useful.
4. Keep goals, principles, journeys, contracts, and constraints.
5. Update generated briefs if the spec changed.

### Durable State

Every meaningful run updates `state/PROJECT_STATE.md`. If a context reset happens, the next agent reads state first and resumes from the current phase.

State should include:

- Current SPEAR phase.
- Confirmed scope.
- Plan status.
- Active tasks.
- Decisions.
- Assumptions.
- Open questions.
- Links to artifacts.

For unattended work, use a mutable checklist state file. `state/RALPH_STATE.md` is the default template. The prompt is the recipe and changes rarely. The state file is the checklist and changes every iteration.

### Runtime Modes

Use the smallest mode that fits the risk:

- Foreground: exploration, small refactors, high-trust calibration.
- Background: one scoped feature, one worktree, bounded runtime.
- Map-reduce: independent audits, parity checks, polish sweeps, or fixes where many agents can map and one human can reduce.

Parallelize only when scopes split cleanly and write ownership is clear.

### Proof Surfaces

Do not trust self-reports alone. Proof of work is the combination of:

- Logs.
- State.
- Artifacts.
- Parsed report block.

The verifier decides done. The human reviews gates.

For browser apps, add e2e tests as a proof surface. Default to Playwright unless the project already has a standard. Use smoke tests first, then journey tests, then regression coverage across the matrix that matters.

### Coverage

Coverage is a span, not a count. A hundred tests in one cell do not prove breadth. Define the matrix that matters: persona, module, viewport, auth state, network state, data state, or other axes relevant to the project.

### Economics

Every feature has a build cost and expected return. Treat the roadmap as a portfolio:

- Estimate cost.
- Define expected return.
- Pick a payback horizon.
- Sunset losers.

Opinions do not decide what ships when evidence and payback math are available.

### Failure Modes

Watch for six harness killers:

- Hallucination: require all proof surfaces.
- Loop delusion: add verifier-backed closed loops.
- Bloated environment: cap tokens and cull tools.
- Single-source files: keep one fact in one home.
- Skipping a layer: produce scope and plan first.
- Loose scope: allow-list work in the prompt.

### Assessment Discipline

Each assessment round must be harsher than the last. Do not repeat the same lens and call it a new round.

Minimum lens sequence:

- R1: rubric pass.
- R2: user skepticism, feasibility, single-message clarity.
- R3: specificity, skim test, steel-man critique, standalone reference.
- R4: truthfulness, placeholder detection, claim verification.
- R5 and beyond: source re-pull, voice cleanup, stale assumption search.

Convergence means a harsher round finds no material defects.

## Repository Map

- `.github/`: portable CI preflight.
- `agents/`: generated foundation, domain, and module agent files.
- `CODEX.md`: primary agent boot instructions.
- `README.md`: human-facing repository overview.
- `AGENTS.md`: compatibility entrypoint for agents that look for AGENTS instructions.
- `rules/`: standing behavioral rules.
- `skills/spear/`: SPEAR workflow definition.
- `prompts/`: intake and execution prompts.
- `templates/`: reusable project artifacts.
- `examples/`: examples of filled artifacts.
- `state/`: durable project state.
- `docs/`: project documentation.
- `scripts/`: portable setup, verification, brief generation, and runner helpers.
- `tests/e2e/`: optional Playwright starter tests.

## Default Run

When no project-specific state exists, do this:

1. Run `python3 scripts/init-project.py --name "<project name>"`.
2. Ask the intake prompts.
3. Draft `templates/scope.md` into `state/SCOPE.md`.
4. Wait for user confirmation.
5. Draft `templates/plan.md` into `state/PLAN.md`.
6. Execute work into `work/`.
7. Assess using `templates/assessment.md`.
8. Resolve with `templates/closeout.md`.

## Non-Negotiables

- BLUF first.
- No hidden assumptions.
- No fabricated sources.
- No implementation before the scope gate for non-trivial work.
- No context-dependent handoff.
- No placeholder left in a final artifact.
- No em dash or en dash characters.
