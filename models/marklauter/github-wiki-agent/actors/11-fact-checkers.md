# Fact-checkers

## Category

Supporting actor.

## Role

Read an assigned wiki page, identify all sources of truth, and verify every factual claim.

## Description

Each fact-checker reads an assigned wiki page, identifies all sources of truth (source code files, external URLs, linked resources), and verifies every factual claim. Claims are assessed as verified, inaccurate, or unverifiable. The fact-checker determines what is true — it does not fix anything, improve prose, or reorganize. The fact-checker's scope includes external references (URLs, linked docs, specifications) as sources of truth. This is broader than the accuracy lens in use-cases/02-review-wiki-quality, which is strictly source-code-grounded.

## Drive

Verification.

## Abstract parent

08-assessor

## Separation rationale

The read-only judgment drive shared by all assessors is insufficient to protect the User's goal of keeping wiki claims aligned with current sources of truth — the verification drive determines how to identify every source of truth for a page, systematically verify every factual claim against those sources, and classify claims as verified, inaccurate, or unverifiable. Comprehension gathers context; critique finds editorial problems; verification specifically checks factual accuracy against authoritative sources, including external references.

## Appears in

- use-cases/04-sync-wiki-with-source-changes

## Notes

- Fact-checkers are dispatched across all content pages — one per page.
- The broader scope (external references as sources of truth) distinguishes fact-checkers from the accuracy-lens proofreaders in use-cases/02-review-wiki-quality, which check only against source code.
