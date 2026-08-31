# Cost And Telemetry

BLUF: agent spend is a line item that grows without anyone deciding it should. Log every model call with attribution, roll it up weekly against a baseline, and alarm on regression. Opinions about whether the factory got more expensive are worthless next to a committed log.

## Per-Run Cost Log

Append one content-free record per model call or per job: timestamp, attribution category, path or job name, model, input and output tokens when the provider returns them, an estimate flag when it does not, and cost. No prompt content, no completion content.

Attribution is the field that makes the log useful. At minimum separate normal recurring work, deliberate one-off work such as a backfill, and unattributed work. Without it, one backfill week poisons every trend line drawn afterward.

Treat the log as a contract: schema, fixtures, validator. See `docs/contracts.md`.

## Weekly Rollup

Aggregate the trailing week by category, path, and model, and append the total to a history file.

Alarm on regression against a baseline computed from recent history, for example the median of the last four attributed weekly totals. Deliberate and unattributed spend stays visible in the report but must not move the baseline, or a single approved backfill raises the bar for every week after it.

Open an issue on regression. A report nobody reads is not an alarm.

## Session Capture

Cost logging tells you what was spent. Session capture tells you what the agent actually did.

If the project routes model traffic through a local gateway, point the SDK at it with a base URL environment variable rather than editing every script, and let CI jobs record under a shared label so pipeline traffic separates from laptop sessions. Wait for the gateway to answer before setting the variable, and supervise the daemon rather than backgrounding it once, or the job runs unrecorded and nothing says so.

Whatever the tool, the requirement is the same: recorded runs, queryable after the fact, with pipeline spend distinguishable from interactive spend.

## Feature Economics

Cost telemetry is the input to the portfolio view in `docs/roles-and-economics.md`. Build cost stops being an estimate once the log exists. Use the measured number.
