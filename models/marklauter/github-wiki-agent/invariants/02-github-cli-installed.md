# GitHub CLI is installed

## Statement

The `gh` CLI is available on the system and verified before proceeding. Authentication is the concern of `gh` itself, not this system.

## Rationale

Every workspace operation depends on GitHub API access through `gh`. Without it, cloning, publishing, and API queries all fail. Verifying its presence early prevents cryptic downstream errors.

## Scope

- use-cases/01-populate-new-wiki
- use-cases/02-review-wiki-quality
- use-cases/03-revise-wiki
- use-cases/04-sync-wiki-with-source-changes
- use-cases/05-provision-workspace

## Origin

Established by use-cases/05-provision-workspace.

## Notes

- If `gh` is not installed, the user is notified. The system does not attempt to install it.
