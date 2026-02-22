# Events

Domain events are meaningful state transitions that cross bounded context boundaries or are exposed to the user as observable outcomes.

## Entries

- 01-wiki-populated — The wiki directory has been populated with documentation pages from an approved plan.
  Producer: use-cases/01-populate-new-wiki. Consumers: actors/01-user, contexts/02-editorial-review, contexts/04-drift-detection.
- 02-finding-filed — A GitHub issue has been created for a documentation problem.
  Producer: use-cases/02-review-wiki-quality. Consumers: contexts/03-wiki-revision.
- 03-wiki-reviewed — The review process has completed.
  Producer: use-cases/02-review-wiki-quality. Consumers: actors/01-user.
- 04-wiki-remediated — The remediation run has completed.
  Producer: use-cases/03-revise-wiki. Consumers: actors/01-user.
- 05-wiki-synced — The sync operation has completed.
  Producer: use-cases/04-sync-wiki-with-source-changes. Consumers: actors/01-user.
- 06-workspace-provisioned — A new workspace configuration has been written to disk.
  Producer: use-cases/05-provision-workspace. Consumers: all operational contexts.
- 07-workspace-decommissioned — The workspace has been removed from disk.
  Producer: use-cases/06-decommission-workspace. Consumers: none.
