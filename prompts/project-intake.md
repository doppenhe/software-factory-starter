# Project Intake Prompt

BLUF: ask these questions before starting a new project. Batch them in one message.

## Required Questions

1. What are we building?
2. Who is the primary user?
3. What should be true after the first useful version exists?
4. What is explicitly out of scope for v1?
5. What kind of artifact is this project: app, library, automation, analysis, documentation, or mixed?
6. What constraints matter: stack, hosting, budget, deadline, privacy, compliance, brand, integrations?
7. What existing assets should the agent read first?
8. What does done look like?
9. What risks or failure modes should the agent watch for?
10. Who signs off at the Scope gate?
11. What are the canonical sources of truth for product behavior, code, state, and decisions?
12. What formats or tools should the agent avoid because they create lossy conversions or unnecessary token load?
13. What runtime mode fits v1: foreground, background, or map-reduce?
14. What proof surfaces should count as done: logs, state, artifacts, reports, tests, screenshots, staging, or other evidence?
15. What coverage axes matter: persona, module, viewport, auth state, data state, network state, integration state, or something else?
16. What is the rough feature economics: build cost, expected return, and payback horizon?
17. Does this project need browser e2e? If yes, what are the first smoke route and first critical journey?

## Optional Questions

Ask only if relevant:

1. Is there an existing repository, design, spec, ticket, or customer request?
2. Are there competitors or references to study?
3. Are there datasets, APIs, credentials, or secrets involved?
4. Should the agent create a branch, commit, or PR?
5. Should the project include CI, tests, docs, packaging, or deployment from day one?
6. Should the agent create a Brief, a Spec, or both before implementation?
7. Should this project use a `PROMPT.md` and `state/RALPH_STATE.md` runtime from the start?
8. Should Playwright be initialized now or deferred until the app exists?

## Output After Intake

Create `state/SCOPE.md` using `templates/scope.md`, then wait for confirmation.
