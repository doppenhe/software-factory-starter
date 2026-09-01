#!/usr/bin/env bash
# Copy to scripts/agent-verify.sh and replace the example checks with your own.
# Contract: one command, named checks, no credentials, no writes, provably able to fail.
# See docs/agent-verification.md.

set -u -o pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

FAILED=0
FAILURES=()

usage() {
  cat <<'USAGE'
Usage:
  bash scripts/agent-verify.sh
  bash scripts/agent-verify.sh --self-test-failure-only

Deterministic local checks that an agent must pass before opening a pull request.
The default path runs no production job, no paid API call, and no credentialed command.
USAGE
}

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

require_command() {
  local cmd="$1"
  local hint="$2"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    note "Missing command: $cmd"
    note "Next action: $hint"
    return 1
  fi
}

check_tools() {
  require_command git "Install git, then rerun bash scripts/agent-verify.sh" || return 1
  require_command python3 "Install Python 3, then rerun bash scripts/agent-verify.sh" || return 1
}

resolve_base_ref() {
  if [ -n "${AGENT_VERIFY_BASE_REF:-}" ]; then
    printf '%s\n' "$AGENT_VERIFY_BASE_REF"
    return 0
  fi
  if git rev-parse --verify --quiet origin/main >/dev/null; then
    printf '%s\n' "origin/main"
    return 0
  fi
  if git rev-parse --verify --quiet main >/dev/null; then
    printf '%s\n' "main"
    return 0
  fi
  return 1
}

check_base_ref() {
  local base_ref
  if ! base_ref="$(resolve_base_ref)"; then
    note "Could not resolve a base ref."
    note "Next action: git fetch origin main, or set AGENT_VERIFY_BASE_REF=<ref>"
    return 1
  fi
  note "Using base ref: $base_ref"
}

# Replace the body with your project validator run against a known-bad input.
# The point is to prove the validator fails, and fails for the expected reason,
# before the rest of the run trusts it passing.
self_test_failing_fixture() {
  local scratch output status
  scratch="$(mktemp -d)"
  trap 'rm -rf "${scratch:-}"; trap - RETURN' RETURN

  cat > "$scratch/record.json" <<'BAD'
{"id": "example"}
BAD

  output="$(python3 - "$scratch/record.json" <<'PY' 2>&1
import json
import sys

record = json.load(open(sys.argv[1]))
if "status" not in record:
    print("invalid record: missing required field status")
    raise SystemExit(1)
PY
)"
  status=$?

  if [ "$status" -eq 0 ]; then
    note "Known-bad fixture unexpectedly passed validation."
    note "$output"
    note "Next action: inspect the validator failure path."
    return 1
  fi

  if ! printf '%s\n' "$output" | grep -q "missing required field status"; then
    note "Known-bad fixture failed, but not for the expected reason."
    note "$output"
    note "Next action: update the fixture proof or the validator expectation."
    return 1
  fi

  note "Expected failure observed: invalid record rejected."
}

run_tests() {
  # Replace with the project test command.
  note "No test suite wired yet. Replace run_tests in scripts/agent-verify.sh."
}

run_full_validation() {
  # Read-only checks over the whole repository: schema, contracts, secret scan.
  note "No full validation wired yet. Replace run_full_validation in scripts/agent-verify.sh."
}

run_changed_validation() {
  local base_ref
  base_ref="$(resolve_base_ref)" || {
    note "Could not resolve a base ref."
    note "Next action: git fetch origin main, or set AGENT_VERIFY_BASE_REF=<ref>"
    return 1
  }
  # Expensive per-item checks run only against files changed since the base ref.
  note "No changed-file validation wired yet. Base ref would be: $base_ref"
}

main() {
  if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
    usage
    return 0
  fi

  if [ "${1:-}" = "--self-test-failure-only" ]; then
    self_test_failing_fixture
    return $?
  fi

  if [ "$#" -gt 0 ]; then
    usage
    return 2
  fi

  note "Agent verify: deterministic local checks before a pull request."

  run_check "Tool availability" check_tools
  run_check "Base ref resolution" check_base_ref
  run_check "Deterministic failing-fixture proof" self_test_failing_fixture
  run_check "Tests" run_tests
  run_check "Full validation, read-only" run_full_validation
  run_check "Changed-file validation" run_changed_validation

  note ""
  if [ "$FAILED" -ne 0 ]; then
    note "Agent verify failed."
    note "Failed check(s):"
    for name in "${FAILURES[@]}"; do
      note "- $name"
    done
    note "Next action: fix the first failing check above, then rerun bash scripts/agent-verify.sh"
    return 1
  fi

  note "Agent verify passed."
}

main "$@"
