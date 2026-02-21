---
name: structuring-usecases
description: Structural contract for use case documents. Defines the artifact shape for both reading and writing use cases. Load when writing or reviewing use case documents.
---

# Structuring use cases

Structural contract for use case documents. Defines the artifact shape for both reading and writing use cases. Load when writing or reviewing use case documents.

Use case files live at `use-cases/{nn}-{slug}.md` within the model directory. `{nn}` is a zero-padded number (e.g., `01`, `02`) that provides stable ordering.

## Structure

```markdown
# {nn} — {Title}

## Goal

{Desired end state the actor is trying to reach. Express the state of the world the actor wants to exist in. Goals are stable — they survive model upgrades, tool changes, and prompt rewrites.}

## Context

- **Bounded context:** [{context name}](../contexts/{nn}-{slug}.md)
- **Primary actor:** [{actor name}](../actors/{nn}-{slug}.md)
- **Supporting actors:** [{actor name}](../actors/{nn}-{slug}.md), [{actor name}](../actors/{nn}-{slug}.md)
- **Trigger:** {What prompts the actor to pursue this goal}

## Actor responsibilities

{Which actor owns each concern — what it produces, what it consumes, what judgment it applies. Internal data contracts between actors are defined here.}

- **{actor-name}** — {what it owns, what it produces, what it consumes}

## Invariants

{Domain rules that must hold continuously — before, during, and after this use case. An actor that violates an invariant mid-scenario has failed, even if the final output looks correct.}

- {invariant}

## Success outcome

{Observable state of the world when the goal is satisfied. Expressed in domain terms.}

- {outcome}

## Failure outcome

{Observable state when the goal cannot be satisfied. What is preserved? What is the user told?}

- {outcome}

## Scenario

{Steps express intent and outcomes. "Wiki content is verified against current source" gives an actor room to find the best path. Step ordering reflects what the actor values — arrange the interaction so that the actor's values are protected at every point. Domain events (marked with -->) signal meaningful state transitions.}

1. **{Actor}** — {Intent / outcome}
   --> {DomainEvent}
2. **{Actor}** — {Intent / outcome}
3. **{Actor}** — {Intent / outcome}

## Goal obstacles

{Conditions that threaten goal satisfaction. Keyed to scenario steps. Describe what is at risk — "source code is unreachable." Each obstacle includes a recovery strategy: a way to protect the goal or degrade gracefully when it cannot be fully achieved.}

### {Step}a — {What threatens the goal}

1. **{Actor}** — {Response}
2. **{Actor}** — {Recovery or graceful degradation}

## Domain events

{Events this use case produces. Published events cross bounded context boundaries or are observable to the user — each has its own file in events/. Internal events coordinate within this use case and are defined here only.}

### Published

- **[{EventName}](../events/{nn}-{slug}.md)** — {when it occurs and what it signifies}

### Internal

- **{EventName}** — {when it occurs and what it signifies}

## Notes

- {Design decisions, open questions, cross-references to other use cases}
```
