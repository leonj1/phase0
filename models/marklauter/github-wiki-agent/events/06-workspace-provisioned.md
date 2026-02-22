# WorkspaceProvisioned

## Context

- **Bounded context:** contexts/05-workspace-lifecycle
- **Producer:** use-cases/05-provision-workspace
- **Consumers:** contexts/01-wiki-creation, contexts/02-editorial-review, contexts/03-wiki-revision, contexts/04-drift-detection (all operational contexts discover workspace via config file)
- **Materialization:** `workspace/artifacts/{owner}/{repo}/workspace.config.md` on disk

## Description

A new workspace configuration file has been written to disk. This is the durable fact that all other bounded contexts discover at workspace selection time by scanning for config files matching `workspace/artifacts/*/*/workspace.config.md`.

## Payload

- Repo slug (owner/repo)
- Source directory path
- Wiki directory path
- Audience
- Tone
