# {Thing} Contract

BLUF: {what this shape is, who writes it, who reads it, and why it is a contract rather than an implementation detail}.

## Status

- Version: {thing}.v1
- Schema: `schemas/{thing}.schema.json`
- Fixtures: `tests/fixtures/{thing}/`
- Validator: `scripts/validate-{thing}.py`
- Writer: `scripts/write-{thing}.py`
- Wired into: `scripts/agent-verify.sh`

## Producers And Consumers

- Writes: {surfaces, jobs, or agents allowed to write}
- Reads: {surfaces, jobs, or reports that depend on this}

## Allowed Fields

| Field | Type | Required | Meaning |
|-------|------|----------|---------|
|  |  |  |  |

Unknown fields fail validation.

## Forbidden Content

{Source text, credentials, personal data, free text, absolute paths, or anything else that must never appear. Say it explicitly. Silence here becomes a leak later.}

## Ordering And Mutability

{Append-only or replaceable. Whether prior rows may be edited. How concurrent writers merge.}

## Retention

{How long records live, measured against what clock. An outage must not freeze expired data.}

## Failure Behavior

{What the validator does on a violation, what the writer does on a partial write, and what a consumer does when the data is stale, partial, or unavailable.}

## Validation

```bash
python3 scripts/validate-{thing}.py
```

Known-bad fixtures that must fail:

- {fixture}: {rule it proves}

## Change Rules

Additive changes extend the schema, the table above, and the fixtures in one pull request. Removals and renames bump the version. Record cross-surface consequences in the decision log.
