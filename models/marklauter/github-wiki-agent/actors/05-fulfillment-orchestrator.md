# Fulfillment orchestrator

## Category

Supporting actor.

## Role

Coordinates the wiki revision workflow — from issue retrieval through correction to issue lifecycle management.

## Description

Named for the *production editor* — the person who manages the flow of corrections through the production pipeline, ensuring that marked-up proofs are corrected and ready for publication. The fulfillment orchestrator fetches GitHub issues, parses them against the published schema, filters out unapplicable issues, groups actionable issues by wiki page, dispatches correctors, and manages issue lifecycle (closing, commenting, labeling).

## Drive

Fulfillment.

## Abstract parent

02-orchestrator

## Separation rationale

The coordination drive shared by all orchestrators is insufficient to protect the User's goal of applying corrections — the fulfillment drive determines how to parse issue schemas, filter unapplicable issues, group corrections by page, and manage issue lifecycle after corrections are applied. This issue-to-correction pipeline is unique to the revision workflow.

## Appears in

- use-cases/03-revise-wiki

## Notes

- The fulfillment orchestrator consumes GitHub issues produced by use-cases/02-review-wiki-quality, making GitHub Issues the message queue between the two use cases.
- Issue body conforming to `documentation-issue.md` is the published protocol.
