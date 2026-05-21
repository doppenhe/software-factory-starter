# PLAN

## Source

Scope file: `state/SCOPE.md`

## Work Units

### Unit 1

GOAL: Give any agent a cold-start operating contract.

APPROACH: Create `CODEX.md` as the primary boot file and `AGENTS.md` as the compatibility pointer.

STATUS: complete

### Unit 2

GOAL: Encode the workflow without making the repo owner-specific.

APPROACH: Document SPEAR, MARR, communications rules, and software-factory behavior as generic operating rules.

STATUS: complete

### Unit 3

GOAL: Make project starts finite and repeatable.

APPROACH: Add batched intake prompts and templates for scope, plan, requirements, decisions, assessment, closeout, research, and run logs.

STATUS: complete

### Unit 4

GOAL: Make the repo checkable.

APPROACH: Add `scripts/verify.sh` to check required files and forbidden Unicode dash characters in starter paths.

STATUS: complete

### Unit 5

GOAL: Capture the Edge workflow for agent-native environments and entropy-resistant specs.

APPROACH: Add road-design docs, spec-entropy docs, Brief and Spec templates, spec-gardening template, and update CODEX boot rules.

STATUS: complete

### Unit 6

GOAL: Cross-reference the AI Developer Productivity deck and capture the full software-factory component set.

APPROACH: Add harness, runtime, proof, coverage, role, economics, agent inheritance, report contract, and state templates.

STATUS: complete

### Unit 7

GOAL: Make the repository portable for someone else to clone and operate.

APPROACH: Add setup scripts, preflight, CI, minimal runner, Brief generator, and a full example run with no local path dependency.

STATUS: complete

### Unit 8

GOAL: Provide a path to e2e testing without making the base harness depend on Node.

APPROACH: Add Playwright docs, optional setup script, starter config, example spec, e2e plan template, and opt-in CI workflow.

STATUS: complete

### Unit 9

GOAL: Make parallel agent work safe and reviewable through GitHub.

APPROACH: Add GitHub coordination docs, SPEAR epic and agent task issue templates, PR evidence standards, UX critic docs, and verification coverage for the new coordination files.

STATUS: complete

## Risks

- Pre-existing unrelated files in this directory can fail whole-repo style checks, so verification is scoped to starter paths.
- A future agent may skip `CODEX.md` if a platform only reads a different entrypoint.

## Verification

- Run `bash scripts/verify.sh`.
- Check git status for expected new files only.

## Exit Criteria

The starter repo can be handed to a cold agent and used to begin a new software project through intake, scope, plan, execution, assessment, and closeout.
