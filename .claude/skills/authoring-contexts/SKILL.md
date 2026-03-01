---
name: authoring-contexts
user-invokable: false
disable-model-invocation: false
description: Writes, reads, and manages bounded context files — boundaries, ubiquitous language, integration points, term ownership, events produced and consumed, dependency relationships. Use when writing, reading, or modifying bounded context artifacts.
---

!`cat .claude/contracts/forms/context.md`

## Reading contexts

Contexts live at `contexts/` within the model directory, with an `index.md` catalog.

- **Start with the index** — `contexts/index.md` maps each context to its use cases. Read the index for the full context map before drilling into individuals.
- **Ubiquitous language** — terms defined here have precise meaning within this context. The same term may mean something different in another context — that divergence is the boundary.
- **Events produced and consumed** — these are the integration contracts. Produced events flow outward; consumed events flow inward. Together they define how this context communicates.
- **Integration points** — three relationship types: requires (depends on), feeds (provides to), shares with (bilateral). These map the dependency graph between contexts.

## Authoring contexts

Use the `create-context.sh` script to create bounded context files. The script handles file naming, directory creation, and section scaffolding with TODO placeholders.

```
bash .claude/scripts/create-context.sh <model-dir> <nn> <slug> <title> <purpose>
```

- **model-dir** — path to the model directory (e.g., `models/marklauter/github-wiki-agent`)
- **nn** — zero-padded number (e.g., `01`). Check `contexts/index.md` or list the directory for the next available.
- **slug** — derive from what the context owns (e.g., `wiki-creation`, `editorial-review`)
- **title** — the context title (e.g., `Wiki Creation`, `Editorial Review`)
- **purpose** — one paragraph describing what this bounded context owns

The script outputs the created file path. Add an entry to `contexts/index.md` after creating.
