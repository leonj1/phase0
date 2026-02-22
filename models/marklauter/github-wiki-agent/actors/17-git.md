# Git

## Category

Sub-system.

## Role

Cloning, working tree inspection, and post-hoc approval.

## Description

Git provides repository cloning, change detection, and the post-hoc approval gate for autonomous corrections in use-cases/04-sync-wiki-with-source-changes. In use-cases/06-decommission-workspace, git working tree inspection detects unpublished work before destructive actions. Git is a sub-system — it executes exactly what is requested with no judgment or decision-making.

## Capabilities

- Repository cloning — creating local working copies of repositories.
- Change detection — identifying recent source code changes for priority context in use-cases/04-sync-wiki-with-source-changes.
- Post-hoc approval gate — exposing diffs and supporting reverts so the User can review autonomous corrections.
- Working tree inspection — detecting unpublished work before destructive actions in use-cases/06-decommission-workspace.

## Used by

- use-cases/04-sync-wiki-with-source-changes — approval gate via diff/revert.
- use-cases/05-provision-workspace — cloning.
- use-cases/06-decommission-workspace — safety checks for unpublished work.

## Notes

- Git's post-hoc approval gate in use-cases/04-sync-wiki-with-source-changes is the mechanism behind the User's experience goal of feeling in control — the User reviews diffs and can revert before anything is published.
