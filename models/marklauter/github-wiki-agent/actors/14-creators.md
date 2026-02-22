# Creators

## Category

Supporting actor.

## Role

Receive a page assignment with source file references, audience, tone, and editorial guidance, then read the source files and write one wiki page.

## Description

Named for the *staff writer* in publishing — the person who produces original content from source material and editorial direction. Each creator receives a page assignment with source file references, audience, tone, and editorial guidance, then reads the source files and writes one wiki page. The creator optimizes for coverage and clarity, not for catching its own mistakes. This drive is insufficient to guarantee accuracy — which is why use-cases/02-review-wiki-quality exists with a separate critique drive.

## Drive

Production.

## Abstract parent

13-content-mutator

## Agent type

`wiki-writer`

## Separation rationale

The wiki modification drive shared by all content mutators is insufficient to protect the User's goal of populating a wiki with complete, grounded documentation — the production drive determines how to synthesize source material into original content that serves the reader. Production is categorically different from remediation — creators decide what to say (synthetic judgment, constrained by the plan), while correctors apply what someone else determined (mechanical judgment, constrained by the finding). An actor that both produces and evaluates would do both poorly.

## Appears in

- use-cases/01-populate-new-wiki

## Notes

- Creators are dispatched in parallel — one per page assignment.
- The creator's authority is the plan produced by the developmental editor. On uncertainty, the creator must produce something — unlike the corrector, which must skip.
