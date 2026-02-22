# User

## Category

Primary actor.

## Role

The human who owns the repository and authorizes all wiki operations.

## Description

The User is the primary actor in every use case. Every wiki operation begins with the User's intent and ends with the User's approval. The system exists to serve the User's goal of maintaining well-documented, trustworthy software projects. The User retains authority over what gets written and what gets published — plan approval before content is written, post-hoc review via git, and type-to-confirm before destructive actions.

## Goals

- Provide software projects that are well-documented and trustworthy.
- Be a responsible steward of project documentation.

## Experience goals

- Feel confident that the wiki accurately represents the source code.
- Feel in control of what gets written and what gets published — no surprises from autonomous agents.
- Feel that the system respects their judgment — plan approval before content is written (use-cases/01-populate-new-wiki), post-hoc review via git (use-cases/04-sync-wiki-with-source-changes), type-to-confirm before destructive actions (use-cases/06-decommission-workspace).
- Feel that their time is not wasted — summaries are actionable, failures are explained, next steps are clear.

## End goals

- use-cases/01-populate-new-wiki — a new wiki is populated with complete documentation grounded in source code.
- use-cases/02-review-wiki-quality — every real documentation problem is exposed as an actionable GitHub issue.
- use-cases/03-revise-wiki — recommended corrections are applied so the wiki content is fixed.
- use-cases/04-sync-wiki-with-source-changes — every factual claim is brought in line with current sources of truth.
- use-cases/05-provision-workspace — a workspace is set up so wiki operations can begin.
- use-cases/06-decommission-workspace — the workspace is removed cleanly, with no silent loss of unpublished work.

## Appears in

- use-cases/01-populate-new-wiki
- use-cases/02-review-wiki-quality
- use-cases/03-revise-wiki
- use-cases/04-sync-wiki-with-source-changes
- use-cases/05-provision-workspace
- use-cases/06-decommission-workspace

## Notes

- The User is the only actor that spans all six use cases.
- use-cases/07-publish-wiki-changes is out of scope and excluded.
