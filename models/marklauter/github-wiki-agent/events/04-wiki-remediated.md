# WikiRemediated

## Context

- **Bounded context:** contexts/03-wiki-revision
- **Producer:** use-cases/03-revise-wiki
- **Consumers:** actors/01-user (remediation results are ready for review)
- **Materialization:** Summary presented to user; wiki files corrected on disk; GitHub issues closed

## Description

The remediation run has completed. Every actionable issue has been processed — either corrected and closed, or skipped with a reason.

## Payload

- Issues corrected count
- Issues skipped count
- Issues close-deferred count
- Remaining open count
