## Structuring actors

An actor file captures who participates in the system and why. The form handles three categories — primary actors, supporting actors, and sub-systems — each with category-specific sections that reflect their distinct relationship to the system.

## Structure

Actor files live at `actors/{nn}-{slug}.md` within the model directory. `{nn}` is a zero-padded number (e.g., `01`, `02`) that provides stable ordering. One file per actor. The form handles three categories — primary actors, supporting actors, and sub-systems — with category-specific sections.

```markdown
# {Name}

## Category

{One of: primary actor, supporting actor, sub-system.}

## Role

{One sentence: what this actor does in the system.}

## Description

{One paragraph. What this actor is, why it exists as a separate entity, and what defines it. For abstract types, describe the shared behavioral trait that children inherit. For sub-systems, describe what capability the system depends on.}
```

The sections below vary by category. Include the sections that match this actor's category.

### Primary actor sections

```markdown
## Goals

{Life goals — who the actor wants to be. Stable across all use cases.}

- {goal}

## Experience goals

{How the actor wants to feel while interacting with the system.}

- {experience goal}

## End goals

{Per use case. Each entry names the use case and states the desired end state.}

- use-cases/{nn}-{slug} — {desired end state for this use case}
```

### Supporting actor sections

```markdown
## Drive

{One word or short phrase — the behavioral tendency this actor optimizes for.}

## Abstract parent

{If this actor inherits from an abstract type, link to the parent. Omit for abstract types and actors with no parent.}

{nn}-{slug}

## Agent type

{The agent type identifier used at runtime. Omit for abstract types.}

## Separation rationale

{Why this actor exists separately. Name the insufficient drive and the drive this actor brings.}

## Children

{For abstract types only. List concrete actors that inherit this type. Omit for concrete actors.}

- {nn}-{slug} — {drive}
```

### Sub-system sections

```markdown
## Capabilities

{What this sub-system provides. This section replaces Drive — sub-systems have capabilities, not drives.}

- {capability}
```

### Common sections (all categories)

```markdown
## Appears in / Used by

{Use cases this actor participates in. Use "Appears in" for primary and supporting actors. Use "Used by" for sub-systems.}

- use-cases/{nn}-{slug}

## Notes (optional)

- {Design decisions, open questions, cross-references to other actors or bounded contexts. Omit this section when empty.}
```
