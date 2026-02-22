# Source repo is readonly

## Statement

Source clones are reference material. No use case may stage, commit, or push to a source repo.

## Rationale

The source clone exists so the system can read repository structure and content. Treating it as immutable prevents accidental modifications to the user's codebase and keeps the system's concern limited to wiki documentation.

## Scope

- use-cases/01-populate-new-wiki
- use-cases/02-review-wiki-quality
- use-cases/03-revise-wiki
- use-cases/04-sync-wiki-with-source-changes

## Origin

Established by use-cases/05-provision-workspace.

## Notes

- This invariant is born in use-cases/05-provision-workspace (which creates the clone) and enforced by every use case that reads from the source.
