#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

bash scripts/verify.sh

if [[ -f PROMPT.md && -f state/RALPH_STATE.md ]]; then
  python3 scripts/ralph.py next >/dev/null
fi

if [[ -f SPEC.md ]]; then
  python3 scripts/generate-brief.py >/dev/null
fi

echo "preflight passed"

