---
name: authoring-usecases
user-invokable: false
disable-model-invocation: false
description: Writes, reads, and manages use case files — scenarios, goals, invariants, goal obstacles, domain events, triggers, supporting actor responsibilities, recovery strategies. Use when writing, reading, or modifying use case artifacts.
---

!`cat .claude/contracts/forms/usecase.md`

## Reading use cases

Use cases live at `use-cases/` within the model directory, with an `index.md` catalog.

- **Start with the index** — `use-cases/index.md` maps each use case to its bounded context and primary actor. Read the index before drilling into individual files.
- **Cross-reference actors** — the Context section names the primary and supporting actors. Read `actors/index.md` to understand who participates and their drives.
- **Scenario is the spine** — the numbered scenario steps tell the story. Each step names the actor and expresses intent. Domain events (marked with `-->`) are the meaningful state transitions.
- **Obstacles branch from steps** — goal obstacles are keyed to scenario steps (e.g., "Step 3a"). Read them as threats to the goal, not alternate flows.

## Authoring use cases

Use the `create-usecase.sh` script to create use case files. The script handles file naming, directory creation, and section scaffolding with TODO placeholders.

```
bash .claude/scripts/create-usecase.sh <model-dir> <nn> <slug> <title> <goal> <context-ref> <primary-actor-ref> <trigger>
```

- **model-dir** — path to the model directory (e.g., `models/marklauter/github-wiki-agent`)
- **nn** — zero-padded number (e.g., `01`). Check `use-cases/index.md` or list the directory for the next available.
- **slug** — derive from the goal, imperative voice (e.g., `populate-new-wiki`, `review-wiki-quality`)
- **title** — the use case title (e.g., `Populate New Wiki`)
- **goal** — one paragraph describing the desired end state
- **context-ref** — bounded context path (e.g., `contexts/01-wiki-creation`)
- **primary-actor-ref** — primary actor path (e.g., `actors/01-user`)
- **trigger** — what prompts the actor to pursue this goal

The script outputs the created file path. Add an entry to `use-cases/index.md` after creating.
