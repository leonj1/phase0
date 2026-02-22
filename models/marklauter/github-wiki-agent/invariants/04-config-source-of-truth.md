# Config is source of truth for workspace identity

## Statement

The existence of `workspace/artifacts/{owner}/{repo}/workspace.config.md` defines whether a workspace exists. Directories without a config file are not workspaces. All workspace discovery is done by scanning for config files matching `workspace/artifacts/*/*/workspace.config.md`.

## Rationale

A single, scannable artifact anchors workspace identity. This eliminates ambiguity — there is no guessing based on directory presence alone, and discovery is a straightforward filesystem glob.

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

- Also a sub-rule of 01-multi-repo-workspace-architecture.
