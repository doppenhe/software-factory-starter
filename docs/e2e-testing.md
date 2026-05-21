# E2E Testing

BLUF: use e2e tests as a proof surface, not as decoration. Start with Playwright because it covers browser behavior, screenshots, traces, and CI cleanly.

## When To Add E2E

Add e2e when any of these are true:

- The project has a browser UI.
- User journeys matter more than unit behavior.
- Visual or interaction regressions would be costly.
- The agent needs verifier-backed loops.
- A human would otherwise click through the same flow before handoff.

Skip e2e for pure libraries, one-off scripts, or projects where unit and contract tests cover the risk.

## Framework Default

Default to Playwright for web apps.

Reasons:

- Works locally and in CI.
- Supports Chromium, Firefox, and WebKit.
- Captures screenshots, videos, and traces.
- Can test mobile viewports.
- Can inspect computed styles for design-token checks.

Use another framework only when the codebase already standardizes on it.

## Proof Levels

Use three levels:

- Smoke: app loads, primary route works, no console errors.
- Journey: user completes a real job end to end.
- Regression: known edge cases, visual checks, auth states, network states, and integration boundaries.

## Getting To E2E

1. Identify the critical user journeys.
2. Define the coverage matrix.
3. Add smoke tests first.
4. Add one golden journey.
5. Add trace, screenshot, and console capture.
6. Wire into CI.
7. Let agent runs use e2e as the verifier.

## Agent Loop

In a Ralph run, e2e should be the verifier:

1. Agent changes code.
2. Agent runs targeted e2e.
3. Test output becomes the next prompt.
4. Agent fixes defects.
5. Report block includes e2e evidence.

Do not accept a self-report when an e2e check can answer the question.

## Coverage Matrix

Track span across axes:

- Persona.
- Journey.
- Viewport.
- Browser.
- Auth state.
- Data state.
- Network state.
- Integration state.

Use `templates/coverage-matrix.md` before expanding tests.

## Portable Setup

The base harness does not require Node. To add Playwright to a project:

```bash
bash scripts/setup-playwright.sh
npm run e2e
```

This creates a minimal Playwright setup only if `package.json` is absent. If a project already has Node tooling, merge the generated scripts into the existing package file.

