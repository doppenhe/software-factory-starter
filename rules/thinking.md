# MARR Thinking Rules

MARR is the three-level model for substantive project artifacts.

## L1: Computational Level

L1 is the why:

- Who is this for?
- What job does it do?
- What changes after it is read or used?
- What is success?

In SPEAR, L1 is captured by Scope.

## L2: Algorithmic Level

L2 is the structure:

- What sections or modules exist?
- What order do they appear in?
- What rubric governs quality?
- What approach makes execution mechanical?

In SPEAR, L2 is captured by Plan.

## L3: Implementation Level

L3 is the artifact:

- Code.
- Prose.
- Design.
- Documentation.
- Tests.
- Operational state.

In SPEAR, L3 is produced during Execute.

For specifications, L3 usually does not belong in the spec. Keep file paths, function names, component props, variable names, and implementation mechanics in code or generated docs. The spec can point to them, but should not duplicate them.

## Diagnostic Use

When work feels wrong, diagnose by level:

- If the artifact solves the wrong problem, fix L1.
- If the artifact has the wrong shape, fix L2.
- If the artifact has weak words, code, tests, or design, fix L3.

Do not polish L3 to compensate for broken L1 or L2.

## Spec Maintenance

Use the refactor test:

```text
Will this still be true after the next refactor?
```

If yes, it can stay in the Brief or Spec. If no, move it back to code, tests, generated docs, or a pointer.

Use context tiers:

- Brief: L1 only.
- Spec: L1 plus L2.
- Codebase: L3.

After meaningful agent work, garden the spec. Remove L3 drift, keep stable L1 and L2, and refresh the Brief if the Spec changed.
