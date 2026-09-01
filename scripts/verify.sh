#!/usr/bin/env bash
# Verification gate for this repository. Same shape as templates/agent-verify.sh:
# named checks, no credentials, no writes, and a proof that the lints can fail.

set -u -o pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

FAILED=0
FAILURES=()

note() {
  printf '%s\n' "$*"
}

run_check() {
  local name="$1"
  shift
  note ""
  note "== $name =="
  if "$@"; then
    note "PASS: $name"
  else
    local status=$?
    note "FAIL: $name"
    note "Exit code: $status"
    FAILED=1
    FAILURES+=("$name")
  fi
}

required=(
  ".github/workflows/preflight.yml"
  ".github/workflows/e2e.yml"
  ".github/ISSUE_TEMPLATE/agent-task.md"
  ".github/ISSUE_TEMPLATE/spear-epic.md"
  ".github/pull_request_template.md"
  "CODEX.md"
  "AGENTS.md"
  "README.md"
  "CONTRIBUTING.md"
  "LICENSE"
  "rules/communications.md"
  "rules/thinking.md"
  "docs/agent-guide.md"
  "docs/agent-verification.md"
  "docs/contracts.md"
  "docs/cost-and-telemetry.md"
  "docs/data-safety.md"
  "docs/e2e-testing.md"
  "docs/github-coordination.md"
  "docs/human-guide.md"
  "docs/portable-setup.md"
  "docs/runtime.md"
  "docs/scheduled-work.md"
  "docs/ux-critic.md"
  "skills/spear/SKILL.md"
  "prompts/project-intake.md"
  "templates/agent-verify.sh"
  "templates/assessment.md"
  "templates/brief.md"
  "templates/closeout.md"
  "templates/contract.md"
  "templates/coverage-matrix.md"
  "templates/decision-record.md"
  "templates/domain-agent.md"
  "templates/e2e-plan.md"
  "templates/feature-economics.md"
  "templates/foundation-agent.md"
  "templates/module-agent.md"
  "templates/plan.md"
  "templates/project-state.md"
  "templates/ralph-prompt.md"
  "templates/ralph-state.md"
  "templates/scope.md"
  "templates/spec.md"
  "templates/spec-gardening.md"
  "templates/work-packet.md"
  "scripts/init-project.py"
  "scripts/lint.py"
  "scripts/ralph.py"
  "scripts/generate-brief.py"
  "scripts/preflight.sh"
  "scripts/setup-playwright.sh"
  "playwright.config.ts"
  "tests/e2e/example.spec.ts"
  "state/PROJECT_STATE.md"
)

check_required_files() {
  local missing=0
  for file in "${required[@]}"; do
    if [[ ! -e "$file" ]]; then
      note "missing required file: $file"
      missing=1
    fi
  done
  return "$missing"
}

check_dashes() {
  python3 scripts/lint.py --root . --check dashes
}

check_paths() {
  python3 scripts/lint.py --root . --check paths
}

# The lints above are only worth trusting because this check watches them fail.
self_test_failing_fixture() {
  local scratch output status
  scratch="$(mktemp -d)"
  trap 'rm -rf "${scratch:-}"; trap - RETURN' RETURN

  python3 - "$scratch" <<'PY'
import sys
from pathlib import Path

scratch = Path(sys.argv[1])
(scratch / "docs").mkdir(parents=True, exist_ok=True)
(scratch / "docs/dash.md").write_text("A sentence with a forbidden " + chr(0x2014) + " character.\n")
(scratch / "docs/path.md").write_text("Clone it to " + "/" + "Users/example/project and run it.\n")
PY

  output="$(python3 scripts/lint.py --root "$scratch" docs 2>&1)"
  status=$?

  if [ "$status" -eq 0 ]; then
    note "Known-bad fixture unexpectedly passed the lints."
    note "$output"
    return 1
  fi

  if ! printf '%s\n' "$output" | grep -q "forbidden Unicode dash character"; then
    note "Fixture failed, but the dash lint did not report it."
    note "$output"
    return 1
  fi

  if ! printf '%s\n' "$output" | grep -q "local absolute path"; then
    note "Fixture failed, but the absolute path lint did not report it."
    note "$output"
    return 1
  fi

  note "Expected failures observed: dash lint and path lint both reported."
}

main() {
  note "Verify: deterministic local checks for this repository."

  run_check "Required files" check_required_files
  run_check "Deterministic failing-fixture proof" self_test_failing_fixture
  run_check "Forbidden dash characters" check_dashes
  run_check "Local absolute paths" check_paths

  note ""
  if [ "$FAILED" -ne 0 ]; then
    note "Verification failed."
    note "Failed check(s):"
    for name in "${FAILURES[@]}"; do
      note "- $name"
    done
    note "Next action: fix the first failing check above, then rerun bash scripts/verify.sh"
    return 1
  fi

  note "Verification passed."
}

main "$@"
