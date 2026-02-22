# 06 — Decommission workspace

## Goal

A project workspace ceases to exist. The system returns to the state it was in before the workspace was provisioned — no config file, no source clone, no wiki clone, no leftover directories. The user can re-provision with `/up` if they choose, or simply move on. Unpublished wiki work is never silently destroyed.

## Context

- **Bounded context:** [Workspace lifecycle](../contexts/05-workspace-lifecycle.md)
- **Primary actor:** [User](../actors/01-user.md)
- **Supporting actors:** [Git](../actors/17-git.md) (working tree inspection)
- **Trigger:** The user no longer needs the workspace for a given repository — the wiki work is done, the project is archived, or the user wants to re-provision with different settings (audience, tone).

## Actor responsibilities

No agents are involved. The [User](../actors/01-user.md) drives the interaction directly through the `/down` command, which coordinates all steps. This is a human-driven workflow, not an agent-orchestrated one.

- **[Git](../actors/17-git.md)** — Inspects the wiki working tree for uncommitted changes and unpushed commits. Produces the safety report consumed by the system before removal proceeds.

## Invariants

See also: invariants/index

- **Decommissioning never provisions.** `/down` will not create, modify, or initialize any workspace state. Provisioning is exclusively the concern of [Provision workspace](05-provision-workspace.md).
- **Unpublished work is never silently destroyed.** If the wiki working tree has uncommitted changes or unpushed commits, the system must inform the user and require explicit confirmation before proceeding. The system never skips the safety check.
- **Single workspace per invocation.** `/down` decommissions exactly one workspace. Batch removal is out of scope.

## Success outcome

- The source clone directory (`workspace/{owner}/{repo}/`) is removed.
- The wiki clone directory (`workspace/{owner}/{repo}.wiki/`) is removed.
- The artifacts directory (`workspace/artifacts/{owner}/{repo}/`) is removed — config, reports, and proofread cache are all deleted.
- Empty parent directories under `workspace/artifacts/` and `workspace/` are cleaned up.
- The user sees confirmation of what was removed: repo identity, directories deleted, config file deleted, and remaining workspace count. If other workspaces remain, lists them. If none remain, notes that `/up` can provision a new one.

## Failure outcome

- The workspace remains intact — config, source clone, and wiki clone are all preserved.
- The user is told why decommissioning did not proceed (no workspace found, or user chose not to discard unpublished work).

## Scenario

1. **[User](../actors/01-user.md)** — Initiates decommissioning by running `/down`.
2. **System** — Resolves which workspace to decommission using the standard workspace selection procedure.
3. **System** — Identifies the workspace components to remove.
4. **[Git](../actors/17-git.md)** — Checks the wiki working tree for uncommitted changes and unpushed commits.
5. **System** — Removes all workspace artifacts.
   --> WorkspaceDecommissioned
6. **[User](../actors/01-user.md)** — Sees confirmation of what was removed: repo identity, directories deleted, config file deleted, and remaining workspace count. If other workspaces remain, lists them. If none remain, notes that `/up` can provision a new one.

## Goal obstacles

### Step 2a — No workspaces exist

1. **System** — Reports that there are no workspaces to remove and suggests running `/up` first if the user intended to provision.
2. **System** — Stops.

### Step 2b — Workspace not found for the given identifier

1. **System** — Reports that no workspace matches the provided identifier and lists the available workspaces.
2. **System** — Stops.

### Step 4a — Wiki has unpublished work

The wiki working tree has uncommitted changes, unpushed commits, or both. This is the critical safety gate.

1. **System** — Reports the unsaved state: lists uncommitted files and/or unpushed commits.
2. **System** — Informs the user: they can cancel and commit and push their changes using git before retrying, or type the repository name (e.g., `acme/WidgetLib`) to confirm deletion and discard the unpublished changes.
3. **[User](../actors/01-user.md)** — Either types the repo name to confirm, or cancels.
4. If the user confirms, the scenario resumes at step 5. If the user cancels, the system stops and the workspace remains intact.

### Step 5a — Removal fails

1. **System** — Reports the failure (filesystem permissions, directory locked by another process).
2. **System** — Stops. The workspace may be in a partial state. The user resolves the underlying issue and retries `/down`.

## Domain events

### Published

- **[WorkspaceDecommissioned](../events/07-workspace-decommissioned.md)** — Workspace removed; no longer discoverable.

### Internal

None.

## Notes

- **No `--force` flag.** The system always checks for unsaved changes. This is an agent interaction, not a CLI tool. If unsaved changes exist, the user confirms by typing the repo name — there is no flag to bypass the check.
- **No `--all` flag.** Decommissioning is single-workspace only. Batch removal, if needed, would be a separate use case.
- **[Commands do not chain.](../invariants/08-commands-do-not-chain.md)** When unsaved work is detected, the system tells the user to publish their work using git (commit and push) but does not do it for them. The user cancels `/down`, publishes independently using whatever git tool they prefer, and then re-runs `/down`.
- **Source clone has no safety concern.** The source repo is readonly ([Source repo readonly](../invariants/03-source-repo-readonly.md) invariant from [Provision workspace](05-provision-workspace.md)). It was never mutated, so it can always be deleted without data loss. Only the wiki clone requires a safety check.
- **[Scripts own deterministic behavior.](../invariants/07-scripts-own-deterministic-behavior.md)** The safety check (`check-wiki-safety.sh`) and removal (`remove-workspace.sh`) are separate scripts by design. The safety check produces a report; the removal script acts on it. The `/down` command delegates to both scripts rather than inlining git commands.
- **Implementation gap: command vs. use case reconciliation.** The current `/down` command file supports `--force`, `--all`, and inlines git commands rather than delegating to scripts. It also uses a simple "proceed or abort" confirmation rather than requiring the user to type the repo name. The command file should be updated to match this use case: single workspace, always check safety, type-to-confirm, delegate to scripts.
- **Implementation: workspace discovery.** Step 3 reads `workspace.config.md` to locate the source and wiki directory paths.
- **Implementation: workspace removal.** Step 5 removes three things: the source clone (`workspace/{owner}/{repo}/`), the wiki clone (`workspace/{owner}/{repo}.wiki/`), and the entire artifacts directory (`workspace/artifacts/{owner}/{repo}/`). Empty parent directories under `workspace/artifacts/` and `workspace/` are cleaned up afterward.
- **Relationship to other use cases:** Decommission workspace is the inverse of [Provision workspace](05-provision-workspace.md). It has no direct relationship to the editorial use cases ([Populate new wiki](01-populate-new-wiki.md) through [Sync wiki with source changes](04-sync-wiki-with-source-changes.md)) — it simply removes the workspace they operate on. If the user has unpublished wiki work, they should commit and push their changes using git before decommissioning.
