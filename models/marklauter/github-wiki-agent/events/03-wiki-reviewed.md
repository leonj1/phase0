# WikiReviewed

## Context

- **Bounded context:** contexts/02-editorial-review
- **Producer:** use-cases/02-review-wiki-quality
- **Consumers:** actors/01-user (knows what is strong, what needs fixing, and where to start)
- **Materialization:** Summary presented to user; GitHub issues as durable record

## Description

The review process has completed. The user knows what is strong, what needs fixing, and where to start.

## Payload

- Pages reviewed count
- Issues identified count
- Issues filed count
- Clean pages
- Failed reviews
- Failed filings
