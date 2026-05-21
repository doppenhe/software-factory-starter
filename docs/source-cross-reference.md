# Source Cross-Reference

BLUF: this repo captures the major software-factory components from the AI Developer Productivity 2026 deck.

## Source

Title metadata: `AI Developer Productivity: Full Deck`

The source PDF is not required at runtime. This file records the conceptual mapping so the repository remains portable after clone.

## Captured Components

| Deck component | Repo location |
|----------------|---------------|
| Design the road for the car | `docs/road-for-the-car.md`, `CODEX.md` |
| SPEAR workflow | `skills/spear/SKILL.md`, `templates/scope.md`, `templates/plan.md`, `templates/assessment.md`, `templates/closeout.md` |
| MARR three levels | `rules/thinking.md`, `docs/spec-entropy.md` |
| AGENTS inheritance | `docs/harness.md`, `templates/foundation-agent.md`, `templates/domain-agent.md`, `templates/module-agent.md` |
| Runtime prompt and state | `docs/runtime.md`, `templates/ralph-prompt.md`, `templates/ralph-state.md` |
| Report contract | `templates/report-contract.md`, `docs/runtime.md` |
| Proof surfaces | `docs/proof-and-coverage.md` |
| Closed-loop testing | `docs/proof-and-coverage.md`, `templates/coverage-matrix.md` |
| Browser e2e path | `docs/e2e-testing.md`, `tests/e2e/example.spec.ts`, `playwright.config.ts` |
| Coverage as span | `docs/proof-and-coverage.md`, `templates/coverage-matrix.md` |
| Runtime modes | `CODEX.md`, `docs/harness.md` |
| Map-reduce | `CODEX.md`, `docs/harness.md` |
| New roles | `docs/roles-and-economics.md` |
| PM as portfolio manager | `docs/roles-and-economics.md`, `templates/feature-economics.md` |
| Harness failure modes | `CODEX.md` |
| Monday start checklist | `docs/checklists.md`, `prompts/project-intake.md` |
| Spec gardening | `docs/spec-entropy.md`, `templates/spec-gardening.md` |
| Document shapes | `docs/doc-shapes.md` |
| Portable runner helper | `scripts/ralph.py` |
| Portable project setup | `scripts/init-project.py` |
| CI preflight | `.github/workflows/preflight.yml` |

## Known Gaps

- The runner is intentionally minimal. It validates report blocks and prints the next checklist prompt, but does not invoke an LLM.
- CI includes a generic preflight and optional e2e workflow. Browser e2e runs only after Node dependencies are installed.
- Brief generation is present, but intentionally simple.
- Worktree orchestration is documented but not implemented.
