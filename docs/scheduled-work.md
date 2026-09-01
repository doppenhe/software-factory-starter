# Scheduled Work

BLUF: once a factory is real, most agent runs are not started by a human. They are cron jobs. A scheduled lane needs three things a foreground run does not: durable state that survives an ephemeral runner, a watchdog that does not share fate with the runner, and a content-free run log that proves what happened.

## When To Use It

Use the scheduled lane for recurring work with a stable recipe: nightly ingestion, regenerating derived artifacts, digests, weekly rollups, freshness sweeps.

Do not use it for work that still needs judgment about scope. A cron job that has to decide what it is doing will drift, and nobody is watching the moment it drifts.

## Durable State On Ephemeral Runners

A hosted runner is a fresh container every time. Anything gitignored dies with it, so a job that resumes from local state will silently reprocess or silently skip.

The rule: state a scheduled job needs on its next run gets committed. Split it deliberately.

Ephemeral state is caches, indexes, and anything regenerable. Keep it gitignored and local.

Durable state is watermarks, dedup logs, and run history. Commit it as append-only files, one per owner or principal, so two runs and two owners merge without conflict. Never rewrite a prior row.

Derive the resume point from the log rather than storing a cursor. Advance a stage watermark only over runs where that stage succeeded, so a failed stage cannot advance its own window and skip a day of input.

## Watchdogs

A scheduled job cannot alarm on its own failure. If the runner is down, so is the alarm.

Run the watchdog on a different substrate from the job. If the job runs on your box or a cloud routine, run the watchdog on CI. Give it read access to the committed run log and permission to open an issue, and nothing else.

The watchdog checks freshness, not success narrative: is there a completed, non-dry-run entry newer than the staleness threshold, and did the stages that matter report success. Set the threshold with enough slack for a slow run and tight enough to catch one fully missed cycle.

## Run Logs Stay Content Free

The run log is operational state, not a copy of the work. Allow a fixed field list: run id, timestamps, window, per-stage status, aggregate counts, error count, exit status, and coverage gaps with a reason code.

Never put source content, item titles, names, subjects, addresses, identifiers, error bodies, or free text in it. Enforce it with a validator, not a review habit, and report violations by row number and rule code without printing the offending value.

Give the run log a contract doc and a schema like any other shared shape. See `docs/contracts.md`.

## Autonomy Boundaries

A scheduled agent run opens a pull request. It does not merge a bulk or inferred change on its own unless the change is receipted against an exact commit and a human approved that path in advance.

Direct commits are for work a human explicitly asked for that is neither destructive nor bulk. Everything autonomous goes through a pull request with evidence, even when it is routine.

On failure, open a draft pull request and report. Do not auto-merge, and do not bypass the gate.

## Cost

Every scheduled job is a recurring bill. Log its token spend the same way one-off runs do and let the weekly rollup catch a job that quietly doubled. See `docs/cost-and-telemetry.md`.
