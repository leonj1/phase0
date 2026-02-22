# 08 — Refactor existing wiki

**Status:** Not yet designed.

**Bounded context:** contexts/06-wiki-restructuring

## Known context

Discovered during 01-populate-new-wiki design. The gap: if creators partially fail during `/init-wiki`, the wiki has content, so `/init-wiki` refuses to run again (new wikis only invariant). `/refresh-wiki` syncs facts but is not interactive — it cannot restructure pages, add missing pages, or reorganize sections. There is no command for interactively restructuring an existing wiki with user approval.

This use case would cover:

- Adding pages that were never written (partial `/init-wiki` failure, or new source features)
- Removing pages that are no longer relevant
- Reorganizing the wiki structure (splitting, merging, renaming pages)
- Updating `_Sidebar.md` to reflect the new structure

The key constraint is that this must be interactive (like 01-populate-new-wiki's plan approval) — the user decides what changes to make, not the system.
