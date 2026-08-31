# Portable Setup

BLUF: a new user should be able to clone this repo and start without any local path, private credential, or machine-specific dependency.

## Requirements

- Git.
- Bash.
- Python 3.

No package install is required for the base harness.

## Start

```bash
git clone <repo-url>
cd <repo>
python3 scripts/init-project.py --name "Your Project"
bash scripts/preflight.sh
```

## What Setup Creates

- `SPEC.md`
- `BRIEF.md`
- `PROMPT.md`
- `CLOSEOUT.md`
- `state/SCOPE.md`
- `state/PLAN.md`
- `state/PROJECT_STATE.md`
- `state/RALPH_STATE.md`
- `state/RUN_LOG.md`
- `state/ASSESSMENT.md`
- `agents/foundation/COMPANY.md`
- `agents/domains/ENGINEERING.md`
- `agents/modules/EXAMPLE.md`

## Wire The Verification Gate

```bash
cp templates/agent-verify.sh scripts/agent-verify.sh
chmod +x scripts/agent-verify.sh
bash scripts/agent-verify.sh
```

Replace the example checks with the project's own, keeping the failing-fixture proof. This one command is the pull request gate for every agent. See `docs/agent-verification.md`.

## Runner Commands

Print the next checklist item:

```bash
python3 scripts/ralph.py next
```

Validate a report block:

```bash
python3 scripts/ralph.py check-report examples/full-run/iteration-001.log
```

Regenerate the Brief from the Spec:

```bash
python3 scripts/generate-brief.py
```

## Optional Browser E2E

For web projects:

```bash
bash scripts/setup-playwright.sh
npm run e2e
```

This adds Node dependencies only when you opt into browser e2e.

## Portability Rules

- Do not commit local absolute paths.
- Do not require credentials for base verification.
- Do not rely on a specific editor, shell profile, or local agent binary.
- Keep optional integrations behind explicit setup docs.
