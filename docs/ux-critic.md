# UX Critic

BLUF: visible product changes are not done just because they function. The interface must reduce cognitive load, make the next action obvious, and expose the evidence a user needs to trust it.

## When This Applies

Run this critic for changes that touch:

- Primary workflows.
- Review queues.
- Dashboards or cockpit views.
- Entity, object, or record detail pages.
- Intake, search, chat, approval, or decision surfaces.

Skip it for backend-only changes, schema-only changes, and invisible test maintenance.

## Critic Lenses

### Primary User Scan

The first 10 seconds should answer:

- What needs attention?
- Why does it matter?
- What can I safely do now?
- Where is the evidence?

If the user must read every box to understand priority, the layout failed.

### Action Ergonomics

Primary actions should be visually obvious and close to the decision context. Secondary actions should not compete with the primary action.

One-click actions require:

- Visible effect.
- Visible source.
- Visible audit path.
- Clear failure behavior.

### Plain Language

Users should see domain language, not agent or implementation language.

Good UI copy says:

- What happens.
- What stays unchanged.
- What the system will remember.
- Where to look if they need more detail.

Keep technical contract words in schemas, docs, and agent instructions unless the user truly needs them.

### Data Density

Dense data should feel calm, not cramped. Prefer aligned rows, stable columns, and short labels over nested card stacks.

### Evidence Visibility

Evidence should be close to the claim it supports. Provenance should be visible enough to trust the system but not so loud that it hides the decision.

## Required PR Evidence

For visible changes, include:

- Screenshot of the main desktop state.
- Screenshot of the main mobile state when the surface is expected on mobile.
- A short UX critic note:
  - What was the user job?
  - What changed after the critic pass?
  - What still feels rough?

## Red Flags

Do another pass if any of these are true:

- Buttons are separated from the data that explains them.
- Technical terms leak into user copy.
- Badges are decorative rather than stateful.
- The action area is larger than the decision it serves.
- Empty space is accidental rather than intentional.
- Screenshots prove rendering but not the actual workflow state.
