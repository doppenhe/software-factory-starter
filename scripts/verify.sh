#!/usr/bin/env bash
set -euo pipefail

paths=(
  ".github"
  "AGENTS.md"
  "CODEX.md"
  "README.md"
  "docs"
  "examples"
  "prompts"
  "rules"
  "scripts"
  "skills"
  "state"
  "templates"
  "tests"
  "playwright.config.ts"
)

missing=0
required=(
  ".github/workflows/preflight.yml"
  ".github/workflows/e2e.yml"
  ".github/ISSUE_TEMPLATE/agent-task.md"
  ".github/ISSUE_TEMPLATE/spear-epic.md"
  ".github/pull_request_template.md"
  "CODEX.md"
  "AGENTS.md"
  "README.md"
  "rules/communications.md"
  "rules/thinking.md"
  "docs/harness.md"
  "docs/human-guide.md"
  "docs/agent-guide.md"
  "docs/portable-setup.md"
  "docs/runtime.md"
  "docs/github-coordination.md"
  "docs/ux-critic.md"
  "docs/proof-and-coverage.md"
  "docs/e2e-testing.md"
  "skills/spear/SKILL.md"
  "prompts/project-intake.md"
  "templates/scope.md"
  "templates/plan.md"
  "templates/project-state.md"
  "templates/assessment.md"
  "templates/brief.md"
  "templates/coverage-matrix.md"
  "templates/decision-record.md"
  "templates/e2e-plan.md"
  "templates/closeout.md"
  "templates/domain-agent.md"
  "templates/feature-economics.md"
  "templates/foundation-agent.md"
  "templates/module-agent.md"
  "templates/ralph-prompt.md"
  "templates/ralph-state.md"
  "templates/report-contract.md"
  "templates/spec.md"
  "templates/spec-gardening.md"
  "templates/work-packet.md"
  "scripts/init-project.py"
  "scripts/ralph.py"
  "scripts/generate-brief.py"
  "scripts/preflight.sh"
  "scripts/setup-playwright.sh"
  "playwright.config.ts"
  "tests/e2e/example.spec.ts"
  "state/PROJECT_STATE.md"
)

for file in "${required[@]}"; do
  if [[ ! -e "$file" ]]; then
    echo "missing required file: $file"
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

python3 - "$@" <<'PY'
from pathlib import Path
import sys

paths = [
    "AGENTS.md",
    "CODEX.md",
    "README.md",
    "docs",
    "examples",
    "prompts",
    "rules",
    "scripts",
    "skills",
    "state",
    "templates",
]

bad = False
for root in paths:
    path = Path(root)
    files = [path] if path.is_file() else [p for p in path.rglob("*") if p.is_file()]
    for file in files:
        text = file.read_text(errors="ignore")
        for index, char in enumerate(text):
            if ord(char) in (0x2013, 0x2014):
                line = text[:index].count("\n") + 1
                print(f"{file}:{line}: forbidden Unicode dash character found")
                bad = True

if bad:
    sys.exit(1)
PY

python3 - "$@" <<'PY'
from pathlib import Path
import re
import sys

paths = [
    ".github",
    "AGENTS.md",
    "CODEX.md",
    "README.md",
    "docs",
    "examples",
    "prompts",
    "rules",
    "scripts",
    "skills",
    "state",
    "templates",
]
patterns = [
    re.compile(r"/Users/"),
    re.compile(r"/home/[A-Za-z0-9_.-]+"),
    re.compile(r"C:\\Users\\"),
]

bad = False
for root in paths:
    path = Path(root)
    files = [path] if path.is_file() else [p for p in path.rglob("*") if p.is_file()]
    for file in files:
        text = file.read_text(errors="ignore")
        for line_no, line in enumerate(text.splitlines(), 1):
            if file == Path("scripts/verify.sh") and ("re.compile" in line or "patterns =" in line):
                continue
            if any(pattern.search(line) for pattern in patterns):
                print(f"{file}:{line_no}: local absolute path found")
                bad = True

if bad:
    sys.exit(1)
PY

echo "verification passed"
