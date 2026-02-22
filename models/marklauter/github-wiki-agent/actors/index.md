# Actors

Every actor that interacts with or operates within the system — who they are, what drives them, and where they appear.

## Entries

### Human actors

- 01-user — Primary actor in every use case; responsible for a GitHub project's wiki documentation.
  Appears in: all use cases.

### Supporting actors

- 02-orchestrator — Abstract parent for the four coordinating actors in editorial use cases.
  Drive: coordination.
- 03-commissioning-orchestrator — Coordinates wiki population.
  Drive: commissioning. Appears in: use-cases/01-populate-new-wiki.
- 04-oversight-orchestrator — Coordinates editorial review.
  Drive: oversight. Appears in: use-cases/02-review-wiki-quality.
- 05-fulfillment-orchestrator — Coordinates wiki revision.
  Drive: fulfillment. Appears in: use-cases/03-revise-wiki.
- 06-alignment-orchestrator — Coordinates drift detection.
  Drive: alignment. Appears in: use-cases/04-sync-wiki-with-source-changes.
- 07-developmental-editor — Synthesizes research into wiki structure.
  Drive: synthesis. Appears in: use-cases/01-populate-new-wiki.
- 08-assessor — Abstract parent for read-only judgment actors.
  Drive: read-only judgment.
- 09-researchers — Examine source code from distinct angles.
  Drive: comprehension. Appears in: use-cases/01-populate-new-wiki, use-cases/02-review-wiki-quality.
- 10-proofreaders — Examine wiki content through editorial lenses.
  Drive: critique. Appears in: use-cases/02-review-wiki-quality.
- 11-fact-checkers — Verify factual claims against sources of truth.
  Drive: verification. Appears in: use-cases/04-sync-wiki-with-source-changes.
- 12-deduplicator — Prevents duplicate GitHub issues.
  Drive: filtering. Appears in: use-cases/02-review-wiki-quality.
- 13-content-mutator — Abstract parent for wiki-writing actors.
  Drive: wiki modification.
- 14-creators — Write original wiki pages from source code.
  Drive: production. Appears in: use-cases/01-populate-new-wiki.
- 15-correctors — Apply known corrections to wiki pages.
  Drive: remediation. Appears in: use-cases/03-revise-wiki, use-cases/04-sync-wiki-with-source-changes.

### Sub-systems

- 16-github — Remote repository host and durable event store.
  Used by: use-cases/02-review-wiki-quality, use-cases/03-revise-wiki, use-cases/05-provision-workspace.
- 17-git — Cloning, working tree inspection, post-hoc approval.
  Used by: use-cases/04-sync-wiki-with-source-changes, use-cases/05-provision-workspace, use-cases/06-decommission-workspace.
