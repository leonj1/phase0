# Invariants

Cross-cutting rules that apply continuously — before, during, and after execution.

## Entries

- 01-multi-repo-workspace-architecture — Each project gets its own isolated workspace; workspaces are independent.
  Governs: all use cases.
- 02-github-cli-installed — The `gh` CLI is available on the system.
  Governs: use-cases/01-populate-new-wiki, use-cases/02-review-wiki-quality, use-cases/03-revise-wiki, use-cases/04-sync-wiki-with-source-changes, use-cases/05-provision-workspace.
- 03-source-repo-readonly — Source clones are reference material; no use case may modify them.
  Governs: use-cases/01-populate-new-wiki, use-cases/02-review-wiki-quality, use-cases/03-revise-wiki, use-cases/04-sync-wiki-with-source-changes.
- 04-config-source-of-truth — Workspace identity is defined by the existence of workspace.config.md.
  Governs: all use cases.
- 05-one-workspace-per-repo — A workspace for a given owner/repo either exists or it does not.
  Governs: use-cases/05-provision-workspace, use-cases/06-decommission-workspace.
- 06-repo-freshness-user-responsibility — The system does not pull or verify that clones are up to date.
  Governs: use-cases/01-populate-new-wiki, use-cases/02-review-wiki-quality, use-cases/03-revise-wiki, use-cases/04-sync-wiki-with-source-changes.
- 07-scripts-own-deterministic-behavior — All deterministic operations belong in scripts; the LLM handles judgment only.
  Governs: use-cases/02-review-wiki-quality, use-cases/03-revise-wiki, use-cases/05-provision-workspace, use-cases/06-decommission-workspace.
- 08-commands-do-not-chain — Each command is self-contained and never invokes another.
  Governs: all use cases.
- 09-no-cli-style-flags — Commands are agent interactions; confirmation happens through conversation.
  Governs: use-cases/03-revise-wiki, use-cases/06-decommission-workspace.
