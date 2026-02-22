# 01 — Populate new wiki

## Goal

A project's empty wiki is populated with a complete, well-structured set of documentation pages that accurately reflect the source code. The wiki is ready for human review — every page serves the configured audience in the configured tone, and no page exists for a feature that does not exist in the source. The user can immediately run [Review wiki quality](02-review-wiki-quality.md) to verify quality, or publish to make the wiki live.

## Context

- **Bounded context:** [Wiki creation](../contexts/01-wiki-creation.md)
- **Primary actor:** [User](../actors/01-user.md)
- **Supporting actors:** [Commissioning orchestrator](../actors/03-commissioning-orchestrator.md) (`/init-wiki` command), [Researchers](../actors/09-researchers.md), [Developmental editor](../actors/07-developmental-editor.md), [Creators](../actors/14-creators.md)
- **Trigger:** The user has provisioned a workspace ([Provision workspace](05-provision-workspace.md)) and wants to create wiki documentation for a project that does not yet have any.

## Actor responsibilities

See also: actors/index for full actor definitions, drives, and the appearance matrix.

Each actor has a single drive. Separation exists because no single drive can protect all the concerns at play.

- **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Drive: commissioning. Resolves the workspace, validates the wiki is new, distributes context to actors, dispatches researchers and creators, collects results, writes _Sidebar.md, and presents the summary. The commissioning orchestrator makes no editorial judgments — it delegates comprehension to researchers, synthesis to the developmental editor, and production to creators. Consumes the workspace config produced by [Provision workspace](05-provision-workspace.md). Produces writing assignments consumed by creators.

- **[Researchers](../actors/09-researchers.md)** — Drive: comprehension. Each examines the source code from a distinct angle and produces a structured explorer report. Researchers are read-only — they never modify files. Each instance's drive is to understand its assigned facet thoroughly, citing specific files and line numbers. Produces explorer reports consumed by the developmental editor.

- **[Developmental editor](../actors/07-developmental-editor.md)** — Drive: synthesis. Receives all explorer reports and produces a coherent wiki plan — sections containing pages, each with a filename, title, description, and key source files. The developmental editor's drive is to turn raw understanding into a structure that serves the audience. It does not write content; it organizes. Consumes explorer reports produced by researchers. Produces the wiki plan consumed by the commissioning orchestrator.

- **[Creators](../actors/14-creators.md)** — Drive: production. Each receives a writing assignment with source file references, audience, tone, and editorial guidance, then reads the source files and writes one wiki page. The creator's drive is to produce well-structured, readable content. This drive is insufficient to guarantee accuracy on its own — which is exactly why [Review wiki quality](02-review-wiki-quality.md) exists as a separate use case with a critique drive. Within this use case, the creator reads source code before writing (invariant), but the production drive means it optimizes for coverage and clarity, not for catching its own mistakes. Consumes writing assignments produced by the commissioning orchestrator.

## Invariants

See also: invariants/index

- **New wikis only.** The wiki directory must contain no content pages. Structural files (Home.md, _Sidebar.md, _Footer.md) do not count as content. If content pages exist, `/init-wiki` refuses to operate. The system does not delete existing content — the user owns destructive actions.
- **Source code is the single source of truth.** Every claim in a wiki page must be grounded in the actual source code. No page may be authored from the agent's training data alone. Creators must read the relevant source files before writing.
- **No placeholder pages.** Pages are only created for capabilities that actually exist in the source code. No speculative content, no pages for hypothetical features, no stubs.
- **Audience and tone are honored throughout.** Every page respects the `audience` and `tone` values from the workspace config. These are immutable (set during [Provision workspace](05-provision-workspace.md), changed only by decommissioning then re-provisioning).
- **Wiki structure requires user approval.** The developmental editor proposes a wiki structure. The user refines it through iterative conversation until satisfied. No pages are written until the user approves the plan. An agent that writes pages without user approval has violated this invariant.
- **[Repo freshness is the user's responsibility.](../invariants/06-repo-freshness-user-responsibility.md)** The system does not pull or verify that the source clone is up to date. The user is responsible for ensuring the workspace reflects the state they want documented.

## Success outcome

- The wiki directory contains a complete set of documentation pages covering the source project — Home.md, _Sidebar.md, and all topic pages from the approved plan.
- Every page accurately reflects the source code, written for the configured audience and tone.
- _Sidebar.md provides navigation organized by section, linking to all pages.
- The user sees a summary of what was created: pages organized by section, the wiki structure, and suggested next steps.

## Failure outcome

- If failure occurs before writing begins (workspace resolution, validation, exploration, planning), no wiki pages are written. The wiki directory remains in its original state.
- If failure occurs during writing (one or more creators fail), successfully written pages remain on disk. The user is told which pages were written and which failed. The wiki is in a partial state.
- In all cases, the user is told what failed and what to do about it.

## Scenario

1. **[User](../actors/01-user.md)** — Initiates wiki population by running `/init-wiki`.
2. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Resolves the workspace and loads config (repo identity, source dir, wiki dir, audience, tone).
3. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Confirms the wiki is brand new — no content pages exist in the wiki directory.
4. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Absorbs editorial context for the target project.
5. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Dispatches researchers to comprehend the source code from distinct angles.
6. **[Researchers](../actors/09-researchers.md)** — Each reads the source code thoroughly and produces a structured report covering its assigned facet.
7. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Collects all exploration reports.
8. **[Developmental editor](../actors/07-developmental-editor.md)** — Synthesizes the exploration reports into a proposed wiki structure.
9. **[User](../actors/01-user.md)** — Reviews the proposed wiki structure and refines it through conversation with the commissioning orchestrator. Pages are added, removed, or reorganized until the user is satisfied with the plan.
10. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Dispatches creators with their page assignments and editorial context.
11. **[Creators](../actors/14-creators.md)** — Each reads the assigned source files and writes one wiki page to disk.
12. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Collects all creator results, assembles wiki navigation, and confirms all approved content is in place.
    --> WikiPopulated
13. **[User](../actors/01-user.md)** — Sees a summary: pages created organized by section, wiki structure, and suggested next steps (review pages for accuracy, run [Review wiki quality](02-review-wiki-quality.md) for editorial review, publish to make the wiki live). The summary notes that content accuracy has not been independently verified.

## Goal obstacles

### Step 2a — No workspace exists

1. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Reports that no workspace exists and directs the user to run `/up` first.
2. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Stops.

### Step 2b — Workspace not found for the given identifier

1. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Reports that no workspace matches the provided identifier and lists available workspaces.
2. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Stops.

### Step 3a — Wiki already has content

The wiki directory contains pages beyond structural files. This is not a new wiki.

1. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Reports that the wiki already has content. Directs the user to [Sync wiki with source changes](04-sync-wiki-with-source-changes.md) for updating existing pages, or to clear the wiki directory manually and retry `/init-wiki`.
2. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Stops. No content is deleted — the user owns destructive actions.

### Step 5a — One or more researchers fail

One or more researchers fail to produce a report (crash, timeout, or unusable results).

1. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Reports which researchers failed and which facets of the source code were not examined.
2. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Proceeds with the reports that succeeded. The gaps are visible to the user during plan approval (step 9), where they can account for missing coverage by adjusting the plan.

### Step 8a — Developmental editor fails

The developmental editor cannot synthesize the exploration reports into a coherent wiki structure.

1. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Reports the planning failure.
2. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Stops. The user retries `/init-wiki`.

### Step 11a — One or more creators fail

One or more creators fail to write their assigned page. Successfully written pages remain on disk.

1. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Reports which pages were written successfully and which failed.
2. **[Commissioning orchestrator](../actors/03-commissioning-orchestrator.md)** — Writes _Sidebar.md reflecting only the pages that were successfully written.
3. **[User](../actors/01-user.md)** — Is left with a partial wiki. Recovery options: manually delete the partial content and retry `/init-wiki`, or work with the partial wiki and use [Sync wiki with source changes](04-sync-wiki-with-source-changes.md) to update what exists.

## Domain events

### Published

- **[WikiPopulated](../events/01-wiki-populated.md)** — Wiki population complete. Ready for review or publishing.

### Internal

None.

## Notes

- **Accuracy is [Review wiki quality](02-review-wiki-quality.md)'s concern.** This use case populates the wiki. Review wiki quality verifies its quality. The creator's production drive is insufficient to guarantee accuracy on its own. The summary step (step 13) explicitly notes that accuracy has not been independently verified, directing the user toward review.
- **Context absorption belongs here.** Reading the target project's CLAUDE.md and editorial guidance is an editorial concern, not a workspace lifecycle concern. [Provision workspace](05-provision-workspace.md) explicitly defers this to populate new wiki and other editorial use cases. The orchestrator absorbs this context in step 4 and distributes it to downstream agents.
- **Plan approval is iterative, not one-shot.** The user and orchestrator work together to refine the wiki structure through conversation until the user is satisfied. This is closer to pair design than a confirm/reject gate.
- **Implementation note: AskUserQuestion may be too limited.** The current command file uses `AskUserQuestion` for plan approval, which presents options rather than enabling free-form conversation. This may be insufficient for the iterative design conversation envisioned in step 9. Acceptable as a first pass for MVP, but a richer interaction pattern may be needed.
- **Partial completion creates a design gap.** If creators partially fail (step 11a), the wiki has some content but not all. The user cannot re-run `/init-wiki` because the "new wikis only" invariant blocks it. [Refactor existing wiki](08-refactor-existing-wiki.md) would address this gap. For now, the user's options are to manually clear the wiki directory and retry, or to work with the partial content.
- **Audience and tone design tension.** The current model treats audience and tone as single values for the entire wiki. Different sections may warrant different audiences (e.g., library users vs. repository contributors). Noted as a future design consideration — for now, the single-value model holds.
- **Implementation: editorial context sources.** Step 4 absorbs editorial context from: editorial guidance (`.claude/guidance/editorial-guidance.md`), wiki instructions (`.claude/guidance/wiki-instructions.md`), and the target project's CLAUDE.md if it exists (`{sourceDir}/CLAUDE.md`).
- **Implementation: creator dispatch.** Step 10 dispatches one creator per approved page. `_Sidebar.md` is excluded from creator dispatch — the commissioning orchestrator writes it directly in step 12.
- **Implementation: wiki navigation.** Step 12 writes `_Sidebar.md` with navigation links reflecting the approved section structure, then verifies all approved pages exist on disk.
- **Relationship to other use cases:** This use case requires [Provision workspace](05-provision-workspace.md) as a prerequisite. Its output feeds [Review wiki quality](02-review-wiki-quality.md) and [Sync wiki with source changes](04-sync-wiki-with-source-changes.md). It has no dependency on [Revise wiki](03-revise-wiki.md) or [Decommission workspace](06-decommission-workspace.md).
