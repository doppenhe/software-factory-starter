# Agent Verification

BLUF: one command decides whether an agent may open a pull request. It must be deterministic, runnable offline, and provably able to fail. A verifier nobody has watched fail proves nothing, and an agent will happily report green from it all afternoon.

## The Gate

Every project gets one entry point:

```bash
bash scripts/agent-verify.sh
```

Agents run it after the work is complete and before drafting PR evidence. If it fails, fix the first failed check and rerun the same command. The command name never changes, so prompts, CI, and docs can all point at the same thing.

Copy `templates/agent-verify.sh` into `scripts/agent-verify.sh` and replace the example checks with the project's own.

## Required Properties

A harness that agents can be trusted with has five properties.

Named checks. Each check prints a header, a PASS or FAIL line, and its exit code. The summary lists every failed check by name. An agent that reports "verification failed" without a check name has not read the output.

A resolved base ref. Changed-file checks need a comparison point. Resolve `AGENT_VERIFY_BASE_REF`, then `origin/main`, then `main`, and fail with the fetch command to run when none resolve.

A deterministic failing-fixture proof. The harness builds a known-bad input in a scratch directory, runs the real validator against it, and fails if that validator passes or fails for the wrong reason. This is the check that proves the rest of the checks can fail. Run it first, before anything expensive.

A split between full and changed-only checks. Full-corpus checks are read-only and run every time: schema validation, secret scanning, contract validation. Expensive per-item checks run only against files changed since the base ref.

No credentials, no writes. The default path must not run production jobs, call paid APIs, write generated files, or require a secret. If a check cannot run without a credential, it belongs in CI with the credential, not in the local gate.

## Failure Interpretation

Document what each check failing means and what to do about it. Without that table, a failing check turns into an agent guessing at scope.

Keep the entry short:

```md
`Fixture and helper tests` means a deterministic helper test failed. Fix the test before PR.
`Base ref resolution` means git cannot find a comparison point. Run `git fetch origin main` or set AGENT_VERIFY_BASE_REF.
```

## Scope Discipline On Failure

If a check fails outside the issue scope, the agent does not fix it. It comments the block from `docs/github-coordination.md`:

```md
Blocked by external failure:
- Check:
- Evidence:
- Why outside scope:
```

## CI Parity

CI calls the same script. Install the dependencies the local check names, then run the one command. Two verification paths that drift produce PRs that pass locally and fail in CI, which trains agents to ignore both.

## Never Bypass

Do not run `git commit --no-verify`. Do not merge on a red gate. If the gate is wrong, fix the gate in its own pull request.
