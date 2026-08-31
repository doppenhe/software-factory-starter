# Data Safety

BLUF: agents write fast and commit often, and git remembers. Any project touching real data needs a secret scan, a rule about where raw source content may live, content-free logs, and retention. Enforce all four in the verifier, because a review habit does not survive parallel agents.

## Secret Scan

Scan the corpus for high-confidence credential patterns and fail the gate on a hit. Run it over the whole repository, not only changed files: a key committed three branches ago is still a key.

Report the file and the rule that matched. Do not print the value.

## Raw Content Placement

Decide once where raw source material may live, for example transcripts, scraped pages, uploaded documents, or inbound messages, and reject it everywhere else.

Scan for misplaced raw content across every version an agent can produce: each commit on the branch after the merge base, the staged index, unstaged files, and untracked files. A file added early in a branch and deleted later still ships in the history, so the branch-history read is the one that matters.

Diagnostics name the rule and the location. They do not quote the content.

## Content Free By Default

Logs, indexes, run records, and telemetry describe work. They do not copy it.

Give every such file an explicit field allowlist in a contract doc, enforce the allowlist in a validator, and reject unknown fields. Counts, statuses, timestamps, and reason codes are safe. Titles, names, subjects, addresses, stable source identifiers, error bodies, and free text are not.

Derived summaries need their own check when the source is protected: verify that a generated summary did not copy long exact passages out of the material it summarized.

## Retention

State how long each generated or cached artifact lives and measure the cutoff against a clock that keeps moving during an outage. A retention window anchored to the last successful fetch freezes expired data exactly when the source is down.

## Repository Hygiene

Never commit binary assets. Store them externally and reference them by key.

Never hand-edit generated or materialized output. Regenerate it. Guard bulk regeneration with a blast-radius check and an explicit override label for the case where the large diff is intended.

Keep private request material and credentials outside the repository entirely, including in the working tree an agent can see.

## Wiring

Every rule here is a check in `scripts/agent-verify.sh` and a section in a contract doc. See `docs/agent-verification.md` and `docs/contracts.md`.
