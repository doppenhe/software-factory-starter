# Contracts

BLUF: "define the shared contract first" is advice until the contract ships as four artifacts: a contract doc, a machine-readable schema, fixtures, and a validator wired into `scripts/agent-verify.sh`. A contract that only exists in prose gets violated by the second parallel agent.

## When A Contract Is Required

Write one when two or more writers touch the same shape:

- Two surfaces read or write the same state, for example a CLI and a web app.
- A generated artifact is consumed by another job, agent, or repo.
- A scheduled job appends to a log that a watchdog or report reads later.
- A cross-repo agreement outlives the pull request that created it.

If only one agent will ever produce and consume the shape, skip the contract and keep the fact in code.

## The Bundle

Every contract ships four files.

The doc, `docs/<thing>-contract.md`. Owns L1 and L2: what the shape is for, the field allowlist, what is forbidden, retention, and the failure behavior. It never lists function names or file paths that a refactor would invalidate.

The schema, `schemas/<thing>.schema.json`. The machine-readable version of the allowlist. Unknown fields fail. A version string lives in the payload so old rows stay readable.

The fixtures, `tests/fixtures/<thing>/`. At least one valid example and one known-bad example per rule that matters. The known-bad fixtures are what make the validator provable.

The validator, `scripts/validate-<thing>.py`. Runs offline against fixtures and against committed data. Reports the rule code and the row or file, and never prints the offending value when the data is sensitive.

Wire the validator into `scripts/agent-verify.sh` in the same pull request. A contract that CI does not enforce decays at the speed of parallel agents.

## Writers Go Through One Door

When a contract governs appended or generated data, give it a single writer script and make that the only supported path. The writer validates the complete future state before it writes, not the single row in isolation. Hand-edits and per-file commits are how two agents produce data that each validates alone and breaks together.

## Change Rules

Add fields by extending the schema and the doc in one pull request, with fixtures for the new shape.

Removing or renaming a field is a version bump, not an edit. Old rows stay valid under the version they were written with.

If the change alters what another surface can rely on, record it in the decision log before implementation splits.

## Relationship To Spec Entropy

The contract doc is where L2 lives permanently. It is the answer to "this fact keeps leaking into the spec": give it a contract doc, point the spec at it, and delete the copy. See `docs/spec-entropy.md`.
