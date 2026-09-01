# CAMPAIGN STATE

Date: 2026-05-20

## Confirmed Scope

- Prove the starter boots, runs one loop, and verifies.
- Stop if the verifier cannot be shown to fail on a known-bad input.

## Tasks

| # | Task | Repo | Worktree | Branch | Base | Status | Verification | Notes |
|---|------|------|----------|--------|------|--------|--------------|-------|
| 1 | #001 init creates starter files | starter | /tmp/starter-001-init | codex/001-init | example | DONE | preflight passed | examples/full-run/iteration-001.log |
| 2 | #002 report contract validates | starter | /tmp/starter-002-report | codex/002-report | example | DONE | check-report passed | examples/full-run/iteration-001.log |
| 3 | #003 verifier fails on known-bad input | starter | /tmp/starter-003-verify | codex/003-verify | example | DONE | failing-fixture proof observed | examples/full-run/iteration-001.log |

## Status Values

- TODO, DOING, VERIFY, AUDIT, FIX, PR, DONE, BLOCKED.

## Coordination

- Tasks 1 and 2 ran together. Task 3 ran after both, since it reads the verifier output.

## Blockers

- None.
