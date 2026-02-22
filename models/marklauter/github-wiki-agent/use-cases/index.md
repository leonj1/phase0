# Use cases

Each use case describes one goal pursued by one primary actor.

## Entries

- 01-populate-new-wiki — Populate new wiki from source code with user-approved structure.
  Context: contexts/01-wiki-creation. Actor: actors/01-user.
- 02-review-wiki-quality — Review wiki quality across four editorial lenses, file GitHub issues.
  Context: contexts/02-editorial-review. Actor: actors/01-user.
- 03-revise-wiki — Apply recommended corrections from GitHub issues to wiki pages.
  Context: contexts/03-wiki-revision. Actor: actors/01-user.
- 04-sync-wiki-with-source-changes — Fact-check wiki claims against source code and external references, correct drift.
  Context: contexts/04-drift-detection. Actor: actors/01-user.
- 05-provision-workspace — Clone repos and write config for a new project workspace.
  Context: contexts/05-workspace-lifecycle. Actor: actors/01-user.
- 06-decommission-workspace — Remove a project workspace with safety checks for unpublished work.
  Context: contexts/05-workspace-lifecycle. Actor: actors/01-user.
- 07-publish-wiki-changes — Commit and push wiki changes *(out of scope)*.
  Context: contexts/05-workspace-lifecycle. Actor: actors/01-user.
- 08-refactor-existing-wiki — Interactively restructure an existing wiki *(not yet designed)*.
  Context: contexts/06-wiki-restructuring. Actor: actors/01-user.
