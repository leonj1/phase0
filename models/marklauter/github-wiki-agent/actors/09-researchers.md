# Researchers

## Category

Supporting actor.

## Role

Perform read-only examination of source code from distinct angles or domain facets and produce structured reports.

## Description

Named for the *researcher* in publishing — the person who gathers background material, verifies references, and provides raw factual groundwork for writers and editors. Each researcher examines source code from a distinct angle or domain facet and produces a structured report. In use-cases/01-populate-new-wiki, reports feed the developmental editor. In use-cases/02-review-wiki-quality, summaries serve as shared context for proofreaders. Researchers never modify files. The minimum facets in use-cases/02-review-wiki-quality are: public API surface, architecture, and configuration. Facet count is extensible per project.

## Drive

Comprehension.

## Abstract parent

08-assessor

## Agent type

`wiki-explorer`

## Separation rationale

The read-only judgment drive shared by all assessors is insufficient to protect the User's goal of grounded documentation — the comprehension drive determines how to decompose a codebase into meaningful facets, what to examine within each facet, and how to structure findings so that downstream actors (developmental editor, proofreaders) can consume them. Raw source code is not actionable context — the researcher transforms it into structured reports.

## Appears in

- use-cases/01-populate-new-wiki
- use-cases/02-review-wiki-quality

## Notes

- Researchers are dispatched in parallel — each examines one facet independently.
- In use-cases/01-populate-new-wiki, researcher reports are the primary input to the developmental editor. In use-cases/02-review-wiki-quality, they provide shared context for proofreaders but do not directly produce findings.
