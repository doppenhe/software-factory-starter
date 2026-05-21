# Managing Spec Entropy

BLUF: specs decay when implementation detail leaks into them. Keep L1 and L2 in specs, keep L3 in code, and garden after every meaningful batch of agent work.

## The Problem

Agents are helpful and concrete. When they discover a function, file, parameter, or component detail, they may write it back into the spec for future sessions.

That feels useful once. Over time it creates entropy:

- Specs grow in token count.
- Code facts become duplicated.
- Refactors make specs stale.
- Agents load more context but get less guidance.

## The MARR Rule

Use MARR to decide what belongs where:

- L1: goals, principles, constraints, edge-case decisions. Keep in the Brief and Spec.
- L2: journeys, state machines, interaction patterns, cross-module contracts, data representations. Keep in the Spec.
- L3: file paths, function names, component props, variable names, implementation mechanics. Keep in code.

Ask:

```text
Will this still be true after the next refactor?
```

If no, remove it from the spec or replace it with a pointer.

## Brief And Spec

Use two context products:

- Brief: L1 only. For QA, audit, review, and orientation.
- Spec: L1 plus L2. For planning and coding.

The Brief should be generated or refreshed from the Spec when possible. A Brief should not accumulate L3 because it should not contain a place for L3 to live.

## Gardening Loop

After each batch of agent work:

1. Review changed docs and specs.
2. Classify new content as L1, L2, or L3.
3. Keep L1 and L2.
4. Move L3 back to code, tests, generated docs, or pointers.
5. Update state with what changed.
6. Run verification.

The goal is not shorter specs for their own sake. The goal is stable context that preserves behavior without duplicating implementation.

