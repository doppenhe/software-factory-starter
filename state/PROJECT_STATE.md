# PROJECT STATE

## Current Phase

Scope

## Confirmed Scope

This starter repository is being created as a complete starting point for agent-run software projects.

## Active Plan

1. Define starter repo structure and agent boot contract.
2. Create CODEX, SPEAR, MARR, prompt, template, and example files.
3. Review scaffold for completeness and forbidden dash characters.

## Decisions

- `CODEX.md` is the primary boot file.
- `AGENTS.md` points agents to `CODEX.md` for compatibility.
- SPEAR governs workflow.
- MARR governs artifact thinking.
- Road design governs the agent operating environment.
- Specs hold L1 and L2. Code holds L3.
- Brief is L1-only context. Spec is L1 plus L2 context.
- Harness has four pieces once work is shared: knowledge, workflow, runtime, and coordination.
- Proof surfaces are logs, state, artifacts, and reports.
- Coverage is a span across named axes, not a raw count.
- Browser e2e is optional and defaults to Playwright when web behavior is in scope.
- Feature work should include cost, expected return, and payback when relevant.
- The repository is portable and should work for any project owner after clone.
- GitHub issues and PRs are the default coordination layer for parallel production work.
- Visible UX changes should include a UX critic pass before human review.

## Assumptions

- This directory is the target repository.
- Existing unrelated artifacts should not be modified.
- The starter should be documentation-first, not a CLI implementation.

## Open Questions

- Whether to add a project initializer script in a later iteration.
- Whether to add CI checks for dash characters, placeholders, and required files.
- Whether to generate Brief files from Spec files automatically.
- Whether to expand the lightweight runner into worktree orchestration.
- Whether to automate GitHub issue creation in a later iteration.

## Active Tasks

- Scaffold operating files.
- Validate completeness.

## Artifacts

- `CODEX.md`
- `README.md`
- `AGENTS.md`
- `rules/`
- `skills/spear/`
- `prompts/`
- `templates/`
- `docs/road-for-the-car.md`
- `docs/spec-entropy.md`
- `docs/harness.md`
- `docs/runtime.md`
- `docs/proof-and-coverage.md`
- `docs/github-coordination.md`
- `docs/ux-critic.md`
- `docs/roles-and-economics.md`
- `scripts/init-project.py`
- `scripts/ralph.py`
- `scripts/generate-brief.py`
- `scripts/preflight.sh`
- `scripts/setup-playwright.sh`
- `docs/e2e-testing.md`
- `templates/e2e-plan.md`
- `examples/`

## Last Updated

2026-05-20
