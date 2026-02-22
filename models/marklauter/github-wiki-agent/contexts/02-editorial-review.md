# Editorial Review

## Purpose

Owns the critique of existing wiki content across four editorial lenses: structure, line, copy, and accuracy. The review process exposes problems as GitHub Issues — it never modifies wiki content. This context produces the published protocol consumed by 03-wiki-revision.

## Ubiquitous language

- **Editorial lens** — A distinct editorial discipline applied to wiki content. Four lenses: structure (organization, flow, gaps), line (sentence-level clarity), copy (grammar, formatting, terminology consistency), accuracy (claims verified against source code).
- **Finding** — A specific documentation problem identified by a actors/10-proofreaders, with quoted problematic text, a recommendation, and (for accuracy) a source file citation.
- **Severity** — Classification of a finding: must-fix or suggestion.
- **Deduplication** — Comparing new findings against existing open GitHub issues to prevent duplicates. The actors/12-deduplicator only drops a finding when it clearly matches an existing open issue about the same problem.
- **Proofread cache** — Ephemeral storage for coordinating actors during a single review run. Created at start, cleaned up at end.

## Use cases

- use-cases/02-review-wiki-quality — Review wiki quality across four editorial lenses and file GitHub issues for each finding.

## Events produced

- events/02-finding-filed — Raised each time a deduplicated finding is filed as a GitHub issue. Published to 03-wiki-revision.
- events/03-wiki-reviewed — Raised when all editorial lenses have completed their review pass and all findings have been filed or deduplicated.

## Events consumed

This context consumes no events from other contexts. Editorial review is initiated directly by the actors/01-user.

## Integration points

- **Requires:** 05-workspace-lifecycle — workspace must be provisioned.
- **Feeds:** 03-wiki-revision — findings filed as GitHub issues are consumed by actors/15-correctors.

## Notes

- Accuracy findings may become stale if 04-drift-detection independently corrects the same inaccuracy. This is an accepted trade-off — editorial review and drift detection operate independently.
