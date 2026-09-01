# Agent Instructions

BLUF: read `CODEX.md` first. It is the source of truth for operating this repository.

This repository is a starter operating model for agent-run software projects. Follow the boot sequence in `CODEX.md`, then use SPEAR for non-trivial work.

## Startup Order

1. In a local clone, run `git pull` before reading further, writing, or committing.
2. If the pull fails, stop and surface the error.
3. Then read the files below.

Required first reads:

1. `CODEX.md`
2. `rules/communications.md`
3. `rules/thinking.md`
4. `skills/spear/SKILL.md`
5. `prompts/project-intake.md`
6. `docs/runtime.md`
7. `docs/agent-verification.md`
8. `docs/github-coordination.md`
9. `docs/contracts.md` when the task touches a shape more than one writer uses
10. `docs/data-safety.md` when the project holds real data
11. `docs/scheduled-work.md` when the task runs on a schedule
12. `docs/portable-setup.md`
13. `docs/agent-guide.md`
14. `docs/ux-critic.md` when changing visible product UX

Do not implement non-trivial work before the SCOPE gate is confirmed.

When the project uses GitHub, treat issues and pull requests as the shared coordination layer. Claim an agent task issue before editing, include a branch and scope lock, work in an isolated worktree, and keep the pull request evidence-backed.

Before opening a pull request, run `bash scripts/agent-verify.sh` and include the result in the evidence. Every agent-authored issue and pull request includes a plain-English explanation of what was wrong and how the change addresses it.
