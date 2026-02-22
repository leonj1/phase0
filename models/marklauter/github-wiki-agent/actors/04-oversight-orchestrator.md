# Oversight orchestrator

## Category

Supporting actor.

## Role

Coordinates the wiki quality review workflow — from research context through proofreading to issue filing.

## Description

Named for the *managing editor* — the person who runs the editorial quality process, assigns reviewers to content, and ensures standards are met across the publication. The oversight orchestrator dispatches researchers for context, dispatches proofreaders across four editorial lenses, collects findings, coordinates deduplication against existing issues, and files GitHub issues.

## Drive

Oversight.

## Abstract parent

02-orchestrator

## Separation rationale

The coordination drive shared by all orchestrators is insufficient to protect the User's goal of exposing documentation problems — the oversight drive determines how to fan out across editorial lenses (structure, line, copy, accuracy), when to coordinate deduplication, and how to consolidate findings into actionable GitHub issues. This multi-lens review orchestration is unique to the quality review workflow.

## Appears in

- use-cases/02-review-wiki-quality

## Notes

- The oversight orchestrator is the only orchestrator that dispatches proofreaders and the deduplicator.
- Findings are filed as GitHub issues, making GitHub a sub-system dependency in this use case.
