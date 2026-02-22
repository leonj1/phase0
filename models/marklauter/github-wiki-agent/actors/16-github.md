# GitHub

## Category

Sub-system.

## Role

Remote repository host and durable event store.

## Description

GitHub provides repository hosting and — through GitHub Issues — a durable event store that serves as the message queue between use-cases/02-review-wiki-quality (producer) and use-cases/03-revise-wiki (consumer). The issue body conforming to `documentation-issue.md` is the published protocol. GitHub is a sub-system, not an external dependency — issues are the durable facts that cross bounded context boundaries.

## Capabilities

- Issue filing — creating new documentation issues with structured bodies.
- Issue reading — retrieving open issues for consumption by downstream use cases.
- Issue lifecycle management — closing, commenting, and labeling issues after corrections.
- Deduplication support — querying existing open issues labeled `documentation` for comparison.
- Repository validation — confirming repository existence and accessibility.

## Used by

- use-cases/02-review-wiki-quality — issue filing and deduplication.
- use-cases/03-revise-wiki — issue reading, closing, and labeling.
- use-cases/05-provision-workspace — repository validation.

## Notes

- GitHub Issues serves as the message queue between the editorial review context (contexts/01-wiki-creation) and the wiki revision context (contexts/03-wiki-revision). The issue body schema is the published protocol that crosses this boundary.
