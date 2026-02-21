---
name: structuring-invariants
description: Structural contract for invariant documents. Defines the artifact shape for both reading and writing invariant files. Load when writing or reviewing invariant documents.
---

# Structuring invariants

Structural contract for invariant documents. Defines the artifact shape for both reading and writing invariant files. Load when writing or reviewing invariant documents.

An invariant is a domain rule that holds continuously -- before, during, and after execution. Each shared invariant gets its own file. An invariant that appears in only one use case stays local to that use case. An invariant that appears in multiple use cases is shared and gets its own file.

Invariant files live at `invariants/{nn}-{slug}.md` within the model directory. `{nn}` is a zero-padded number (e.g., `01`, `02`) that provides stable ordering.

## Structure

```markdown
# {Name}

## Statement

{The rule itself — declarative, present tense. One or two sentences. A simple invariant has a short statement; a complex invariant may include sub-rules as a bulleted list beneath the primary statement.}

## Rationale

{Why this rule exists. What goes wrong if it is violated. One short paragraph.}

## Scope

{Which use cases this invariant governs.}

- [{Use case name}](../use-cases/{nn}-{slug}.md)

## Origin

{Which use case or design decision established this invariant.}

Established by [{use case or decision name}](../use-cases/{nn}-{slug}.md).

## Notes

- {Design decisions, open questions, cross-references}
```

## Simple invariants

A simple invariant states one rule. The statement is one or two sentences.

```markdown
# GitHub CLI is installed

## Statement

The `gh` CLI is available on the system. If it is not, the user is notified. Authentication is the concern of `gh` itself.

## Rationale

Every workspace operation depends on GitHub API access through `gh`. Without it, no use case can proceed.

## Scope

- [Populate new wiki](../use-cases/01-populate-new-wiki.md)
- [Provision workspace](../use-cases/05-provision-workspace.md)

## Origin

Established by [Provision workspace](../use-cases/05-provision-workspace.md).
```

## Complex invariants

A complex invariant clusters related sub-rules under a single architectural concept. The statement includes a primary assertion followed by sub-rules.

```markdown
# Multi-repo workspace architecture

## Statement

Each project gets its own isolated workspace. Workspaces are independent -- operations on one workspace never affect another.

- Each workspace contains a source clone, a wiki clone, and a config file.
- Workspace identity is defined by the existence of `workspace/artifacts/{owner}/{repo}/workspace.config.md`.
- One workspace per repository. A workspace for a given `owner/repo` either exists or it does not.

## Rationale

Isolation prevents cross-contamination between projects. A failure in one workspace leaves every other workspace unaffected.

## Scope

- [Populate new wiki](../use-cases/01-populate-new-wiki.md)
- [Resolve documentation issues](../use-cases/03-resolve-documentation-issues.md)

## Origin

Established by [Provision workspace](../use-cases/05-provision-workspace.md).
```
