# 05 — Provision workspace

## Goal

A new project workspace exists and is ready for wiki operations. The user can immediately run any downstream command (`/init-wiki`, `/proofread-wiki`, `/revise-wiki`, `/refresh-wiki`) and have it resolve the workspace without error.

## Context

- **Bounded context:** contexts/05-workspace-lifecycle
- **Primary actor:** actors/01-user
- **Supporting actors:** actors/16-github (remote repository host), actors/17-git (cloning tool)
- **Trigger:** The user wants to manage wiki documentation for a GitHub project that does not yet have a workspace in this system.

## Actor responsibilities

No agents are involved. The actors/01-user drives the interaction directly through the `/up` command, which coordinates all steps. This is a human-driven workflow, not an agent-orchestrated one.

- **actors/16-github** — Hosts the source repository and wiki repository. The system validates existence of both repositories against actors/16-github before cloning.

- **actors/17-git** — Clones the source repository and wiki repository into the workspace. Produces the local working trees consumed by all downstream use cases.

## Invariants

See also: invariants/index

- **Provisioning never tears down.** `/up` will not remove, modify, or overwrite an existing workspace. Teardown is exclusively the concern of 06-decommission-workspace.
- **Both repos must pre-exist on actors/16-github.** The source repository and its wiki repository must both exist on actors/16-github before provisioning can complete. The wiki must have its Home page created via the actors/16-github UI — no CLI or API endpoint exists to create a wiki programmatically.

## Success outcome

- Source repository is cloned into `workspace/{owner}/{repo}/` as a readonly reference.
- Wiki repository is cloned into `workspace/{owner}/{repo}.wiki/`.
- `workspace/artifacts/{owner}/{repo}/workspace.config.md` is written with repo identity, paths, audience, and tone.
- The user sees a summary of what was provisioned: repo identity, clone paths, config values (audience, tone), and suggested next steps (run `/init-wiki` to populate the wiki).

## Failure outcome

- No config file is written. No orphaned config or partial workspace state is left behind.
- The user is told what failed and what to do about it (fix authentication, correct the URL, etc.).
- Any directories created before the failure are cleaned up.

## Scenario

1. **actors/01-user** — Initiates provisioning by running `/up`.
2. **actors/01-user** — Provides the source repository clone URL, target audience, and writing tone in response to the interview prompts.
3. **System** — Identifies the target repository from the provided clone URL.
4. **System** — Confirms no workspace exists for this repository.
5. **System** — Validates that the source repository exists on actors/16-github.
6. **System** — Validates that the wiki repository exists on actors/16-github.
7. **actors/17-git** — Clones the source repository into the workspace.
8. **actors/17-git** — Clones the wiki repository into the workspace.
9. **System** — Writes the workspace configuration file.
   --> WorkspaceProvisioned
10. **actors/01-user** — Sees a summary of the provisioned workspace: repo identity, clone paths, config values (audience, tone), and suggested next steps (run `/init-wiki` to populate the wiki).

## Goal obstacles

### Step 3a — Clone URL is not a recognized GitHub URL

1. **System** — Reports that the URL could not be parsed and shows the accepted formats (HTTPS and SSH).
2. **actors/01-user** — Provides a corrected URL. The scenario resumes at step 3.

### Step 4a — Workspace already exists for this repository

1. **System** — Reports that a workspace for this repository already exists and directs the user to run `/down` first if they want to start fresh.
2. **System** — Stops. No state is modified.

### Step 5a — Source repository does not exist on GitHub

1. **System** — Reports that the repository could not be found on actors/16-github (not found, or permission denied).
2. **System** — Stops. The user verifies the URL and their access, then retries `/up`.

### Step 6a — Wiki does not exist on GitHub

1. **System** — Reports that the wiki repository does not exist. The most likely cause is that the wiki has not been initialized.
2. **System** — Provides instructions: navigate to the repository on actors/16-github, go to the Wiki tab, and create the Home page. GitHub wikis can only be initialized through the web UI — no CLI or API endpoint exists.
3. **System** — Waits for the user to confirm they have created the wiki.
4. **actors/01-user** — Creates the Home page on actors/16-github and confirms.
5. **System** — Re-validates that the wiki now exists. If it does, the scenario resumes at step 7 (clone source). If it still does not exist, the system reports the issue and waits again.

### Step 7a — Source clone fails

1. **actors/17-git** — Reports the clone failure (network error, permission denied, authentication failure).
2. **System** — Cleans up any partial directory state. No config file is written.
3. **System** — Stops. The user resolves the underlying issue and retries `/up`.

### Step 8a — Wiki clone fails

1. **actors/17-git** — Reports the wiki clone failure. The wiki was validated as existing in step 6, so this is likely a network or authentication issue.
2. **System** — Cleans up any partial directory state (source clone already created in step 7). No config file is written.
3. **System** — Stops. The user resolves the underlying issue and retries `/up`.

## Domain events

### Published

- **events/06-workspace-provisioned** — Workspace config written; discoverable by all operational contexts.

### Internal

None.

## Notes

- **Validate before cloning.** The system verifies both the source repo and wiki repo exist on actors/16-github before attempting any clones. This provides clear, actionable error messages and enables the wait-and-retry flow for wiki creation.
- **Context absorption belongs to the editorial domain.** Reading the target project's CLAUDE.md and the wiki's `_Sidebar.md` is an editorial concern (01-populate-new-wiki, 02-review-wiki-quality, 04-sync-wiki-with-source-changes), not a workspace lifecycle concern. Provisioning does not read or present project content.
- **invariants/07-scripts-own-deterministic-behavior** The provisioning script (`provision-workspace.sh`) is the single source of truth for provisioning mechanics. The `/up` command delegates to it after collecting user inputs.
- **Audience and tone are immutable.** There is currently no edit path for these values. Changing them requires `/down` then `/up`.
- **Workspace config is the contract between Workspace Lifecycle and all other bounded contexts.** The config file (`workspace.config.md`) written in step 9 is consumed by the workspace selection procedure that every downstream command executes before operating. Its schema (repo, sourceDir, wikiDir, audience, tone) is the shared contract.
- **Implementation: repository identification.** Step 3 extracts the owner and repository name by parsing the clone URL (supports both HTTPS and SSH formats).
- **Relationship to other use cases:** Provision workspace is a prerequisite for 01-populate-new-wiki, 02-review-wiki-quality, 03-revise-wiki, and 04-sync-wiki-with-source-changes. 06-decommission-workspace is its inverse.
