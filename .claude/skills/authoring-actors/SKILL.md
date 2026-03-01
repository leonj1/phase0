---
name: authoring-actors
user-invokable: false
disable-model-invocation: false
description: Writes, reads, and manages actor files — primary, supporting, or sub-system actors with categories, conditional goals, drives, tensions, value conditions, cross-references. Use when writing, reading, or modifying actor artifacts.
---

!`cat .claude/contracts/forms/actor.md`

## Reading actors

Actors live at `actors/` within the model directory, with an `index.md` catalog.

- **Start with the index** — `actors/index.md` lists every actor with their drive and use case participation. Read the index to understand the actor landscape before drilling into individuals.
- **Category determines sections** — primary actors have Goals, Experience goals, and End goals. Supporting actors have Drive and Separation rationale. Sub-systems have Capabilities. Check the Category section first.
- **Abstract parents and children** — some supporting actors are abstract types with concrete children. The Children section lists inheritors. The Abstract parent section links upward.
- **Appears in / Used by** — cross-references to use cases. Use this to trace which interactions an actor participates in.

## Creating actors

Use the `create-actor.sh` script to create actor files. The script handles file naming, directory creation, and category-specific section scaffolding.

```
bash .claude/scripts/create-actor.sh <model-dir> <nn> <slug> <name> <category> <role> <description>
```

- **model-dir** — path to the model directory (e.g., `models/marklauter/github-wiki-agent`)
- **nn** — zero-padded number (e.g., `01`). Check `actors/index.md` or list the directory for the next available.
- **slug** — actor name in lowercase (e.g., `user`, `orchestrator`, `proofreaders`)
- **name** — display name, capitalized (e.g., `User`, `Orchestrator`, `Proofreaders`)
- **category** — one of: `primary`, `supporting`, `sub-system`. Determines which sections are scaffolded.
- **role** — one sentence: what this actor does in the system
- **description** — one paragraph: what this actor is and why it exists

The script outputs the created file path. Add an entry to `actors/index.md` after creating.
