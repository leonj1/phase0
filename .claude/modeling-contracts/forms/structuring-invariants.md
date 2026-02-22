# Structuring invariants

Shared invariants that span multiple use cases get their own files. Single-use invariants stay local to the use case.

## Structure

An invariant that appears in only one use case stays local to that use case's Invariants section. An invariant that appears in multiple use cases gets its own file.

Invariant files live at `invariants/{nn}-{slug}.md` within the model directory. `{nn}` is a zero-padded number (e.g., `01`, `02`) that provides stable ordering.

```markdown
# {Name}

## Statement

{The rule itself — declarative, present tense. One or two sentences. A simple invariant has a short statement; a complex invariant may include sub-rules as a bulleted list beneath the primary statement.}

## Rationale

{Why this rule exists. What it protects. One short paragraph.}

## Scope

{Which use cases this invariant governs.}

- use-cases/{nn}-{slug}

## Origin

{Which use case or design decision established this invariant.}

Established by use-cases/{nn}-{slug}.

## Notes (optional)

- {Design decisions, open questions, cross-references. Omit this section when empty.}
```

## Simple invariants

A simple invariant states one rule. The statement is one or two sentences.

```markdown
# GitHub CLI is installed

## Statement

The `gh` CLI is available on the system and verified before proceeding. Authentication is the concern of `gh` itself.

## Rationale

Every workspace operation depends on GitHub API access through `gh`. This invariant is a precondition for every use case.

## Scope

- use-cases/01-populate-new-wiki
- use-cases/05-provision-workspace

## Origin

Established by use-cases/05-provision-workspace.
```

## Complex invariants

A complex invariant clusters related sub-rules under a single architectural concept. The statement includes a primary assertion followed by sub-rules.

```markdown
# Multi-repo workspace architecture

## Statement

Each project gets its own isolated workspace. Workspaces are independent — each workspace operates in isolation.

- Each workspace contains a source clone, a wiki clone, and a config file.
- Workspace identity is defined by the existence of `workspace/artifacts/{owner}/{repo}/workspace.config.md`.
- One workspace per repository. Each `owner/repo` maps to exactly one workspace.

## Rationale

Isolation protects each project. Each workspace maintains its own integrity independently.

## Scope

- use-cases/01-populate-new-wiki
- use-cases/03-resolve-documentation-issues

## Origin

Established by use-cases/05-provision-workspace.
```
