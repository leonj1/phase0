# Wiki Revision

## Purpose

Owns the revision of wiki content based on documented problems tracked in GitHub Issues. actors/15-correctors apply recommended corrections to wiki pages. Issue closure is a consequence of successful remediation, not the goal. This context consumes the published protocol from 02-editorial-review.

## Ubiquitous language

- **Corrector** — An actor with a remediation drive that applies recommended corrections to a wiki page.
- **Targeted edit** — A surgical change to a specific section of a wiki page, preserving surrounding content.
- **Skip reason** — Why a corrector could not apply a recommendation: quoted text no longer exists, recommendation is ambiguous, recommendation contradicts source code.
- **Correction assignment** — The input to a actors/15-correctors: page path, finding (what is wrong), recommendation (what it should say), source reference (the authority). Structurally compatible with 04-drift-detection's correction assignments, enabling corrector reuse.

## Use cases

- use-cases/03-revise-wiki — Apply recommended corrections from GitHub issues to wiki pages.

## Events produced

- events/04-wiki-remediated — Raised when all actionable findings from the current batch of GitHub issues have been applied or skipped with documented reasons.

## Events consumed

- events/02-finding-filed — From 02-editorial-review, via GitHub Issues. Each filed finding becomes a correction assignment for a actors/15-correctors.

## Integration points

- **Requires:** 05-workspace-lifecycle — workspace must be provisioned.
- **Requires:** 02-editorial-review — GitHub issues conforming to the finding schema provide the correction assignments.
- **Shares with:** 04-drift-detection — corrector protocol is structurally compatible, enabling the same actors/15-correctors to serve both contexts.

## Notes

- Correction assignments from this context and from 04-drift-detection share the same structure. This is a deliberate design decision that allows actors/15-correctors to operate without knowing which context originated the work.
