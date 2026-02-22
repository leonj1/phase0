# Content Mutator

## Category

Supporting actor.

## Role

Receives a page assignment with source file references from the orchestrator, reads source files for grounding, and modifies wiki content.

## Description

The Content Mutator is an abstract type whose children modify wiki content. The write permission is the defining behavioral trait — in contrast to assessors, which are strictly read-only. Children differ in the nature of their judgment:

- **Creator** — synthetic judgment. Decides what to say, constrained by the plan. Input is a plan assignment. On uncertainty, must produce something.
- **Corrector** — mechanical judgment. Applies what to fix, constrained by the source. Input is a finding plus recommendation. On uncertainty, must skip.

An actor that both produces content and evaluates whether it produced well has two jobs and will do both poorly. Two actors with opposing drives produce better outcomes than one balancing competing concerns. Production, critique, and remediation are three distinct drives — a creator cannot reliably evaluate its own output, and a corrector must not second-guess the proofreader or generate new content.

## Drive

Wiki modification.

## Children

- 14-creators — production
- 15-correctors — remediation

## Appears in

- use-cases/01-populate-new-wiki
- use-cases/03-revise-wiki
- use-cases/04-sync-wiki-with-source-changes

## Notes

- The separation rationale applies at the family level — production, critique, and remediation are three distinct drives. This separation is why use-cases/02-review-wiki-quality (critique) and use-cases/03-revise-wiki (remediation) are separate use cases rather than a single "fix the wiki" workflow.
- The creator vs. corrector distinction is not about skill level — it is about the nature of the judgment and the authority each actor follows.
