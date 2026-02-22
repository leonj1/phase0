# Commands do not chain

## Statement

Each command is a self-contained interaction. One command never invokes another. If a command detects that the user should run a different command, it informs the user and stops.

## Rationale

Chaining commands creates hidden coupling and unpredictable cascades. Self-contained commands keep each interaction auditable and let the user decide what to run next.

## Scope

- use-cases/01-populate-new-wiki
- use-cases/02-review-wiki-quality
- use-cases/03-revise-wiki
- use-cases/04-sync-wiki-with-source-changes
- use-cases/05-provision-workspace
- use-cases/06-decommission-workspace

## Origin

Established by use-cases/05-provision-workspace.

## Notes

- The user remains in control of sequencing. The system advises but never acts on its own behalf across command boundaries.
