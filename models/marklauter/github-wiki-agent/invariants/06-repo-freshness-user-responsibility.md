# Repo freshness is the user's responsibility

## Statement

The system does not pull or verify that clones are up to date. All use cases operate against whatever state the local clone is in. The user is responsible for pulling before running a command if they want to operate against the latest remote state.

## Rationale

Freshness is a user intent — sometimes operating against a known-stale snapshot is deliberate. Automatic pulls would introduce network dependencies, latency, and silent state changes. Leaving freshness to the user keeps command behavior predictable.

## Scope

- use-cases/01-populate-new-wiki
- use-cases/02-review-wiki-quality
- use-cases/03-revise-wiki
- use-cases/04-sync-wiki-with-source-changes

## Origin

Established by use-cases/05-provision-workspace.

## Notes

- use-cases/05-provision-workspace satisfies freshness trivially — it performs a fresh clone.
