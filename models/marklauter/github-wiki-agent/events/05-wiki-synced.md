# WikiSynced

## Context

- **Bounded context:** contexts/04-drift-detection
- **Producer:** use-cases/04-sync-wiki-with-source-changes
- **Consumers:** actors/01-user (sync results are ready for review)
- **Materialization:** Sync report on disk at `workspace/artifacts/{owner}/{repo}/reports/sync/{date-time}-sync-report.md`

## Description

The sync operation has completed. Every factual claim has been checked, drift has been corrected, and the user has a durable report.

## Payload

- Pages checked count
- Corrections applied count
- Claims skipped (unverifiable) count
- Pages up-to-date count
- Pages unchecked (fact-checker failure) count
