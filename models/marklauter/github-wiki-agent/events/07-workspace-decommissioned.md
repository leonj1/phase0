# WorkspaceDecommissioned

## Context

- **Bounded context:** contexts/05-workspace-lifecycle
- **Producer:** use-cases/06-decommission-workspace
- **Consumers:** None (workspace simply ceases to exist)
- **Materialization:** Config file, source clone, and wiki clone removed from disk

## Description

The workspace config file, source clone, and wiki clone have been removed. This is the inverse of 06-workspace-provisioned. After this event, the workspace selection procedure will no longer discover this workspace.

## Payload

- Repo slug (owner/repo)
