# Assessor

## Category

Supporting actor.

## Role

Receives an assignment from the orchestrator, reads inputs, and applies judgment to produce structured output — without modifying wiki content or source material.

## Description

The Assessor is an abstract type whose children specialize in read-only judgment. The read-only constraint is the defining behavioral trait. Each child specializes in what it judges and what vocabulary its output uses, but the protocol with the orchestrator is the same: assignment in, structured assessment out. The assessor family exists because the tension between the User's goal of accurate documentation and the reality of large, evolving codebases demands judgment that is separate from the act of writing — an actor that both evaluates and writes has two jobs and will do both poorly.

## Drive

Read-only judgment.

## Children

- 09-researchers — comprehension
- 10-proofreaders — critique
- 11-fact-checkers — verification
- 12-deduplicator — filtering

## Appears in

- use-cases/01-populate-new-wiki
- use-cases/02-review-wiki-quality
- use-cases/04-sync-wiki-with-source-changes

## Notes

- The read-only constraint is what unifies the assessor family. Children differ in what they judge, not in whether they modify content.
- Assessors appear in use-cases/01-populate-new-wiki (researchers), use-cases/02-review-wiki-quality (researchers, proofreaders, deduplicator), and use-cases/04-sync-wiki-with-source-changes (fact-checkers). They do not appear in use-cases/03-revise-wiki — that use case consumes assessments already produced.
