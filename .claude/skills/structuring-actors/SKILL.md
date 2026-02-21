---
name: structuring-actors
description: Structural contract for actor documents. Defines the artifact shape for both reading and writing actor files. Load when writing or reviewing actor documents.
---

# Structuring actors

Structural contract for actor documents. Defines the artifact shape for both reading and writing actor files. Load when writing or reviewing actor documents.

Actor files live at `actors/{nn}-{slug}.md` within the model directory. `{nn}` is a zero-padded number (e.g., `01`, `02`) that provides stable ordering. One file per actor. The form handles three categories — primary actors, supporting actors, and sub-systems — with category-specific sections.

## Structure

```markdown
# {Name}

## Category

{One of: primary actor, supporting actor, sub-system.}

## Role

{One sentence: what this actor does in the system.}

## Description

{One paragraph. What this actor is, why it exists as a separate entity, and what behavioral trait defines it. For supporting actors, trace the genealogy — which tension between a primary actor's goal and reality demanded this actor? For abstract types, describe the shared behavioral trait that children inherit. For sub-systems, describe what capability the system depends on.}
```

The sections below vary by category. Include the sections that match this actor's category.

### Primary actor sections

```markdown
## Goals

{Life goals — who the actor wants to be. Aspirational and stable across all use cases.}

- {goal}

## Experience goals

{How the actor wants to feel while interacting with the system.}

- {experience goal}

## End goals

{What the actor wants to accomplish, per use case. Each entry links to the use case and states the desired end state.}

- [{Use case title}](../use-cases/{nn}-{slug}.md) — {desired end state for this use case}
```

### Supporting actor sections

```markdown
## Drive

{One word or short phrase — the behavioral tendency this actor optimizes for.}

## Abstract parent

{If this actor inherits from an abstract type, link to the parent. Omit for abstract types and actors with no parent.}

[{Parent name}](../actors/{nn}-{slug}.md)

## Agent type

{The agent type identifier used at runtime. Omit for abstract types.}

## Separation rationale

{Why this actor exists separately. Name the drive that is insufficient to protect the primary actor's goal, and the drive this actor brings to fill that gap.}

## Children

{For abstract types only. List concrete actors that inherit this type. Omit for concrete actors.}

- [{Child name}](../actors/{nn}-{slug}.md) — {drive}
```

### Sub-system sections

```markdown
## Capabilities

{What this sub-system provides to the system. Not a drive — sub-systems optimize for nothing.}

- {capability}
```

### Common sections (all categories)

```markdown
## Appears in

{Use cases this actor participates in. Primary and supporting actors use "appears in." Sub-systems use "used by."}

- [{Use case title}](../use-cases/{nn}-{slug}.md)

## Notes

- {Design decisions, open questions, cross-references to other actors or bounded contexts}
```
