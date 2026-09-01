# Contributing

This is an opinionated starter. The opinions come from running agents against production repositories, so the bar for changing one is evidence that the current rule failed in practice.

## Useful contributions

- A rule here that broke on a real project, with what happened.
- A check worth adding to `templates/agent-verify.sh`.
- A doc that says the same thing as another doc. Duplication is the main way this repo decays.
- Portability fixes. The base harness must run with git, Bash, and Python 3, and nothing else.

## Before opening a pull request

```bash
bash scripts/verify.sh
```

Use the pull request template. It asks for a plain-English explanation of what was wrong and how the change addresses it, written for someone who has never seen this repository. That section is not a formality here; it is the house style.

## House rules

- No em dashes or en dashes. `scripts/verify.sh` fails the build on them.
- No local absolute paths. Same check.
- Plain words. Short sentences. Say what changed, not how significant it is.
- One fact, one home. If your change repeats something another file already says, point at that file instead.
