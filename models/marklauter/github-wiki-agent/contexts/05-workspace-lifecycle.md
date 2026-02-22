# Workspace Lifecycle

## Purpose

Owns the provisioning and decommissioning of project workspaces. A workspace is the configuration, source clone, and wiki clone for one GitHub project. All other bounded contexts discover workspaces at runtime by scanning for config files. This context does not read or interpret project content — that belongs to the editorial contexts.

## Ubiquitous language

- **Workspace config** — A `workspace.config.md` file containing repo identity, source dir, wiki dir, audience, and tone. The contract between Workspace Lifecycle and all other bounded contexts.
- **Source clone** — A readonly clone of the source repository, used as reference material.
- **Wiki clone** — A clone of the wiki repository, the mutable working copy for all editorial operations.
- **Safety check** — Inspection of the wiki working tree for uncommitted changes and unpushed commits before decommissioning.

## Use cases

- use-cases/05-provision-workspace — Clone repos and write config for a new project workspace.
- use-cases/06-decommission-workspace — Remove a project workspace with safety checks for unpublished work.

## Events produced

- events/06-workspace-provisioned — Raised when repos have been cloned and the workspace config has been written.
- events/07-workspace-decommissioned — Raised when a workspace has been safely removed after passing all safety checks.

## Events consumed

This context consumes no events from other contexts. Workspace provisioning and decommissioning are initiated directly by the actors/01-user.

## Integration points

- **Feeds:** 01-wiki-creation — workspace must exist before wiki creation.
- **Feeds:** 02-editorial-review — workspace must exist before editorial operations.
- **Feeds:** 03-wiki-revision — workspace must exist before revision operations.
- **Feeds:** 04-drift-detection — workspace must exist before drift detection.

## Notes

- Provisioning and decommissioning are inverse operations. They never chain — a workspace is either being created or destroyed, never both in sequence.
- The workspace config file is the single integration contract. Other contexts depend on its structure, not on the provisioning process itself.
