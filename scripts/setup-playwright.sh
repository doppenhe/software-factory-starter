#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required for Playwright setup"
  exit 1
fi

if [[ ! -f package.json ]]; then
  cat > package.json <<'EOF'
{
  "private": true,
  "scripts": {
    "verify": "bash scripts/verify.sh",
    "preflight": "bash scripts/preflight.sh",
    "e2e": "playwright test",
    "e2e:ui": "playwright test --ui",
    "e2e:report": "playwright show-report"
  },
  "devDependencies": {
    "@playwright/test": "^1.45.0"
  }
}
EOF
else
  echo "package.json exists. Add these scripts manually if missing:"
  echo "  e2e: playwright test"
  echo "  e2e:ui: playwright test --ui"
  echo "  e2e:report: playwright show-report"
fi

npm install
npx playwright install --with-deps chromium
echo "Playwright setup complete. Run: npm run e2e"

