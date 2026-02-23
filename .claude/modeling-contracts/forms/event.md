## Structuring events

A domain event file records a meaningful state transition — what happened, what context produced it, who consumes it, and what data it carries.

## Structure

Event files live at `events/{nn}-{slug}.md` within the model directory. `{nn}` is a zero-padded number (e.g., `01`, `02`) that provides stable ordering. One file per event. Events are named in PastTense (e.g., WikiPopulated, FindingFiled).

```markdown
# {EventName}

## Context

- Bounded context: contexts/{nn}-{slug}
- Producer: use-cases/{nn}-{slug}
- Consumers: {namespace}/{nn}-{slug} ({why this consumer cares})
- Materialization: {How the event becomes observable — file on disk, API response, summary presented to user, issue created}

## Description

{One paragraph. What happened and why it matters. Past tense.}

## Payload

{Data the event carries. Each item is a noun or noun phrase.}

- {datum}
- {datum}

## Notes (optional)

- {Design decisions, open questions, cross-references. Omit this section when empty.}
```
