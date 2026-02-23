## Structuring use cases

A use case file captures one goal pursued by one primary actor — the desired end state, the scenario that achieves it, the invariants that constrain it, and the obstacles that threaten it.

## Structure

Use case files live at `use-cases/{nn}-{slug}.md` within the model directory. `{nn}` is a zero-padded number (e.g., `01`, `02`) that provides stable ordering.

```markdown
# {nn} — {Title}

## Goal

{One paragraph.}

## Context

- Bounded context: contexts/{nn}-{slug}
- Primary actor: actors/{nn}-{slug}
- Supporting actors: actors/{nn}-{slug}, actors/{nn}-{slug}
- Trigger: {What prompts the actor to pursue this goal}

## Actor responsibilities

- {actor-name} — {what it owns, what it produces, what it consumes}

## Invariants

- {invariant statement}. Reference shared invariants by path when applicable.

## Success outcome

- {outcome}

## Failure outcome

- {outcome}

## Scenario

1. {Actor} — {intent}
   --> {DomainEvent}
2. {Actor} — {intent}
3. {Actor} — {intent}

## Goal obstacles

### Step {n}a — {threat}

1. {Actor} — {response}
2. {Actor} — {recovery}

## Domain events

### Published

- {EventName} (events/{nn}-{slug}) — {significance}

### Internal

- {EventName} — {significance}

## Notes (optional)

- {Design decisions, open questions, cross-references. Omit this section when empty.}
```
