# Multi-repo workspace architecture

## Statement

This system manages wiki documentation for multiple GitHub projects simultaneously. Each project gets its own isolated workspace. Workspaces are independent — operations on one workspace never affect another.

- Each workspace contains a source clone, a wiki clone, and a config file.
- Config is the source of truth for workspace identity — the existence of `workspace/artifacts/{owner}/{repo}/workspace.config.md` defines whether a workspace exists. See 04-config-source-of-truth.
- One workspace per repository — a given `owner/repo` maps to exactly one workspace, with no partial state or overlap. See 05-one-workspace-per-repo.

The workspace directory structure enforces isolation:

```
workspace/
  artifacts/{owner}/{repo}/
    workspace.config.md
    reports/
  {owner}/{repo}/           # source clone (readonly)
  {owner}/{repo}.wiki/      # wiki clone (mutable)
```

## Rationale

Isolation protects each project from cross-contamination. Each workspace maintains its own clones, config, and artifacts independently, so failures or changes in one project never ripple into another.

## Scope

- use-cases/01-populate-new-wiki
- use-cases/02-review-wiki-quality
- use-cases/03-revise-wiki
- use-cases/04-sync-wiki-with-source-changes
- use-cases/05-provision-workspace
- use-cases/06-decommission-workspace

## Origin

Established by use-cases/05-provision-workspace.

## Notes

- Sub-rules 04-config-source-of-truth and 05-one-workspace-per-repo also stand as independent invariants because they govern use cases beyond workspace architecture.
