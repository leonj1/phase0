---
name: authoring-invariants
user-invokable: false
disable-model-invocation: false
description: Writes, reads, and manages invariant files — rules, constraints, scope, rationale, origin, cross-use-case enforcement, what must always be true. Use when writing, reading, or modifying invariant artifacts.
---

!`cat .claude/contracts/forms/invariant.md`

## Reading invariants

Shared invariants live at `invariants/` within the model directory, with an `index.md` catalog. Single-use invariants stay local to their use case's Invariants section.

- **Start with the index** — `invariants/index.md` lists shared invariants with their scope. Read the index to understand which rules span multiple use cases.
- **Check use cases too** — local invariants only appear in individual use case files. To find all invariants governing an interaction, read both the shared invariants index and the specific use case's Invariants section.
- **Scope** — lists every use case the invariant governs. Use this to understand the invariant's reach.
- **Origin** — names the use case or design decision that established the invariant. Use this to trace why the rule exists.

## Creating invariants

Use the `create-invariant.sh` script to create shared invariant files. The script handles file naming, directory creation, and section scaffolding.

```
bash .claude/scripts/create-invariant.sh <model-dir> <nn> <slug> <name> <statement> <rationale> <origin>
```

- **model-dir** — path to the model directory (e.g., `models/marklauter/github-wiki-agent`)
- **nn** — zero-padded number (e.g., `01`). Check `invariants/index.md` or list the directory for the next available.
- **slug** — rule name in kebab-case (e.g., `source-repo-readonly`, `gh-cli-installed`)
- **name** — the invariant's display name (e.g., `Source repository is read-only`)
- **statement** — the rule itself, declarative, present tense
- **rationale** — why this rule exists, what it protects
- **origin** — which use case established this invariant (e.g., `Established by use-cases/01-populate-new-wiki.`)

The script outputs the created file path. Only create files for invariants that span multiple use cases. Single-use invariants stay in the use case's Invariants section. Add an entry to `invariants/index.md` after creating.
