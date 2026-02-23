## Structuring contexts

A context file defines one bounded context — the semantic region it governs, the ubiquitous language within it, and its integration points with other contexts through domain events.

## Structure

Context files live at `contexts/{nn}-{slug}.md` within the model directory. `{nn}` is a zero-padded number (e.g., `01`, `02`) that provides stable ordering. One file per bounded context.

```markdown
# {Title}

## Purpose

{One paragraph. What this bounded context owns.}

## Ubiquitous language

{Terms with precise meaning within this context.}

- {Term} — {What it means within this context.}

## Use cases

{Use cases that live in this context.}

- use-cases/{nn}-{slug} — {What the use case achieves, in one sentence.}

## Events produced

{Domain events this context emits.}

- events/{nn}-{slug} ({EventName}) — {When it occurs and what it signifies.}

## Events consumed

{Domain events this context reacts to.}

- events/{nn}-{slug} ({EventName}) — {What this context does in response.}

## Integration points

{How this context relates to other contexts. Three relationship types: requires, feeds, shares with.}

- Requires: contexts/{nn}-{slug} — {What must be in place and why.}
- Feeds: contexts/{nn}-{slug} — {What this context provides and why the other context needs it.}
- Shares with: contexts/{nn}-{slug} — {What is shared and the protocol that governs it.}

## Notes (optional)

- {Design decisions, open questions, cross-references. Omit this section when empty.}
```
