# Drift Detection

## Purpose

Owns the ongoing verification of factual claims in the wiki against their sources of truth — source code, external references, linked specifications. Claims that have drifted are corrected. Claims that are accurate are left untouched. This context operates autonomously (actors/17-git is the approval gate) and does not interact with GitHub Issues.

## Ubiquitous language

- **Drift** — A factual claim in the wiki that no longer matches its source of truth.
- **Fact-checker assessment** — A structured report for one wiki page listing every factual claim checked, with verdict (verified, inaccurate, unverifiable), quoted text, correct fact, and source reference. Produced by a actors/11-fact-checkers.
- **Correction assignment** — The input to a actors/15-correctors: page path, list of inaccurate claims with correct facts and source references, audience, tone, editorial guidance. Structurally compatible with 03-wiki-revision's correction assignments, enabling corrector reuse.
- **Sync report** — A durable, time-stamped report showing corrections applied, pages verified, and claims that could not be checked.
- **Source of truth** — The authoritative reference for a factual claim. May be source code, an external URL, a linked specification, or other referenced material.

## Use cases

- use-cases/04-sync-wiki-with-source-changes — Fact-check wiki claims against source code and external references, correct drift.

## Events produced

- events/05-wiki-synced — Raised when all wiki pages have been fact-checked and any detected drift has been corrected.

## Events consumed

This context consumes no events from other contexts. Drift detection is initiated directly by the actors/01-user or on a scheduled basis.

## Integration points

- **Requires:** 05-workspace-lifecycle — workspace must be provisioned.
- **Shares with:** 03-wiki-revision — corrector protocol is structurally compatible, enabling the same actors/15-correctors to serve both contexts.

## Notes

- Corrections applied by drift detection may render 02-editorial-review accuracy findings stale. This is an accepted trade-off in favor of keeping drift detection fast and independent.
- Drift detection does not file GitHub Issues. Its approval gate is actors/17-git — changes are committed directly and reviewed through the normal version control workflow.
