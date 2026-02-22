# Wiki Creation

## Purpose

Owns the transition from an empty wiki to a populated wiki. The source code is explored, a wiki structure is proposed and approved by the user, and creators produce pages. This context assumes the wiki has no existing content pages — restructuring an existing wiki belongs to 06-wiki-restructuring.

## Ubiquitous language

- **Exploration report** — A structured summary of one facet of the source code (API surface, architecture, configuration), produced by a actors/09-researchers.
- **Wiki plan** — A hierarchical structure of sections containing pages, each with filename, title, description, and key source files. Proposed by the actors/07-developmental-editor, refined and approved by the actors/01-user.
- **Writing assignment** — The input to a actors/14-creators: page file path, title, description, key source files, audience, tone, and editorial guidance.

## Use cases

- use-cases/01-populate-new-wiki — Populate a new wiki from source code with a user-approved structure.

## Events produced

- events/01-wiki-populated — Raised when all writing assignments have been fulfilled and the wiki contains its initial set of content pages.

## Events consumed

This context consumes no events from other contexts. Wiki creation is initiated directly by the actors/01-user.

## Integration points

- **Requires:** 05-workspace-lifecycle — workspace must be provisioned before wiki creation.
- **Feeds:** 02-editorial-review — populated wiki is ready for quality review.
- **Feeds:** 04-drift-detection — populated wiki has content pages to sync.

## Notes

- Wiki creation is a one-time operation per workspace. If the wiki already has content, the actors/01-user is directed to 06-wiki-restructuring instead.
- The actors/02-orchestrator coordinates exploration, planning, and writing phases sequentially — each phase completes before the next begins.
