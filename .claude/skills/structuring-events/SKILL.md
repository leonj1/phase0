---
name: structuring-events
description: Structural contract for domain event documents. Defines the artifact shape for both reading and writing event files. Load when writing or reviewing domain event documents.
---

# Structuring events

Structural contract for domain event documents. Defines the artifact shape for both reading and writing event files. Load when writing or reviewing domain event documents.

Event files live at `events/{nn}-{slug}.md` within the model directory. `{nn}` is a zero-padded number (e.g., `01`, `02`) that provides stable ordering. One file per event. Events are named in PastTense (e.g., WikiPopulated, FindingFiled).

## Structure

```markdown
# {EventName}

## Context

- **Bounded context:** [{context name}](../contexts/{nn}-{slug}.md)
- **Producer:** [{use case name}](../use-cases/{nn}-{slug}.md)
- **Consumers:** [{use case or context name}](../{topic}/{nn}-{slug}.md) ({why this consumer cares})
- **Materialization:** {How the event becomes observable — file on disk, API response, summary presented to user, issue created}

## Description

{One paragraph. What happened and why it matters. State the fact in past tense — "The wiki directory has been populated..." — then explain the significance: what becomes possible, what other work this enables, where the model stands after this transition.}

## Payload

{Data the event carries. Each item is a noun or noun phrase — the fact, not the field name.}

- {datum}
- {datum}

## Notes

- {Design decisions, open questions, cross-references to other events or use cases}
```
