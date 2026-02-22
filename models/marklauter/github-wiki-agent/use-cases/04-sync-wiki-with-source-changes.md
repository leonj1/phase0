# 04 — Sync wiki with source changes

## Goal

Every factual claim in the wiki accurately reflects the current state of its sources of truth — source code, external references, linked resources. Claims that have drifted are corrected. Claims that are still accurate are left untouched. The user has a durable, time-stamped report showing what changed, what was verified, and what could not be checked. This is a fact-checking operation, not a full editorial review — only accuracy matters, not structure, prose quality, or copy consistency.

## Context

- **Bounded context:** [Drift detection](../contexts/04-drift-detection.md)
- **Primary actor:** [User](../actors/01-user.md)
- **Supporting actors:** [Alignment orchestrator](../actors/06-alignment-orchestrator.md) (`/refresh-wiki` command), [Fact-checkers](../actors/11-fact-checkers.md), [Correctors](../actors/15-correctors.md) (wiki-writer, shared with [Revise wiki](03-revise-wiki.md))
- **Trigger:** The user suspects the wiki has drifted from the source code — source code has been updated, time has passed since the last sync, or the user wants to increase confidence in the wiki's accuracy.

## Actor responsibilities

See also: actors/index for full actor definitions, drives, and the appearance matrix.

Each actor has a single drive. Separation exists because no single drive can protect all the concerns at play. Sync wiki with source changes is an abbreviated [Review wiki quality](02-review-wiki-quality.md) + [Revise wiki](03-revise-wiki.md) without the GitHub Issues message queue in the middle — the fact-checker replaces the proofreader's accuracy lens, and the corrector is reused from [Revise wiki](03-revise-wiki.md)'s remediation drive.

- **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Drive: alignment. Resolves the workspace, absorbs editorial context, identifies recent source code changes as priority context, dispatches fact-checkers across all wiki pages, collects assessments, dispatches correctors for pages with drift, compiles the sync report, and presents it to the user. The alignment orchestrator makes no editorial judgments and applies no corrections. Consumes the workspace config produced by [Provision workspace](05-provision-workspace.md). Produces correction assignments consumed by correctors.

- **[Fact-checkers](../actors/11-fact-checkers.md)** — Drive: verification. Each reads its assigned wiki page, identifies all sources of truth referenced in the content (source code files, external URLs, linked resources), and verifies every factual claim against those sources. The fact-checker's drive is to determine what is true — not to fix anything, not to improve prose, not to reorganize. Recent source code changes are provided as context to focus attention, but the fact-checker checks all claims on the page, not only those related to recent changes. Produces a structured fact-checker assessment for each page: every claim assessed as verified, inaccurate (with the correct fact and source reference), or unverifiable (source unreachable). Consumed by the alignment orchestrator to dispatch correctors and compile the report.

- **[Correctors](../actors/15-correctors.md)** — Drive: remediation. Each receives a page and its fact-checker assessment, reads the page, reads the cited sources to independently verify the assessment, and applies targeted corrections. The corrector's drive is to make inaccurate content accurate — it does not improve prose, restructure sections, or add new content beyond what the correction requires. This is the same remediation drive as [Revise wiki](03-revise-wiki.md)'s correctors. The corrector is reusable between [Revise wiki](03-revise-wiki.md) and sync wiki with source changes because both consume a structurally compatible input: a page, a finding (what's wrong), a recommendation (what it should say), and a source reference (the authority). Consumes correction assignments containing the page path, inaccurate claims (each with quoted text, correct fact, and source reference), audience, tone, and editorial guidance.

## Invariants

See also: invariants/index

- **Accuracy only — no editorial changes.** Sync wiki with source changes corrects facts. It does not tighten prose, fix grammar, reorganize structure, or standardize terminology. A fact-checker that flags a style problem has exceeded its mandate. A corrector that "improves" a sentence while correcting a fact has exceeded its mandate. Structure, line, and copy concerns belong to [Review wiki quality](02-review-wiki-quality.md).
- **No new pages.** Sync wiki with source changes syncs existing pages. It does not create new wiki pages, even if source code introduces features not covered by any existing page. Flagging coverage gaps is [Review wiki quality](02-review-wiki-quality.md)'s structure lens concern, not sync wiki with source changes'.
- **Targeted edits, not rewrites.** Correctors use surgical edits. Entire pages are not rewritten. The existing page structure, voice, and content beyond the correction are preserved.
- **No interaction with GitHub Issues.** Sync wiki with source changes does not read, file, close, or comment on GitHub Issues. It is decoupled from the issue system entirely. If [Review wiki quality](02-review-wiki-quality.md) has filed an accuracy issue that sync wiki with source changes independently corrects, the issue becomes stale — [Revise wiki](03-revise-wiki.md) will skip it when it finds the quoted text no longer matches. This is an accepted gap in favor of keeping sync wiki with source changes fast and focused.
- **All sources of truth are in scope.** Source code is not the only authority. External references within wiki content (URLs, linked documentation, specifications) are also sources of truth. The fact-checker verifies claims against whatever the authoritative source is for that claim.
- **Unreachable sources are skipped, not guessed.** When an external source (URL, API) is unreachable, the fact-checker skips that verification and records it in the assessment. The corrector does not attempt to correct claims it cannot verify. The report's errata section surfaces these gaps.
- **[Git](../actors/17-git.md) is the approval gate.** The user does not approve changes before they are applied. Corrections are written directly to wiki files. The user reviews changes after the fact using git (diff, log, revert). This is a deliberate design choice: sync wiki with source changes is autonomous, and git provides the safety net.
- **[Repo freshness is the user's responsibility.](../invariants/06-repo-freshness-user-responsibility.md)** The system does not pull or verify that clones are up to date. The user is responsible for ensuring the workspace reflects the state they want verified.

## Success outcome

- Every factual claim in the wiki has been checked against its source of truth. Inaccurate claims have been corrected on disk. Accurate claims are untouched.
- A durable, time-stamped sync report exists on disk showing: pages checked, corrections applied (with what changed and source references), pages verified as accurate, and claims that could not be verified (with the unreachable source).
- The user can review all changes via git diff and revert any correction they disagree with.
- Running `/refresh-wiki` again produces fewer or no corrections, increasing confidence in wiki accuracy over successive runs.

## Failure outcome

- If failure occurs before correctors are dispatched (workspace resolution, no content pages, all fact-checkers fail), no wiki files are modified. The user is told what failed.
- If some fact-checkers fail, pages they were responsible for are not checked. Pages that were successfully checked proceed through the pipeline. The report notes which pages were not covered.
- If some correctors fail, successfully applied corrections remain on disk. The report notes which corrections failed. The user retries `/refresh-wiki` to pick up uncorrected drift.
- In all cases, whatever partial report can be compiled is written to disk, and the user is told what happened.

## Scenario

1. **[User](../actors/01-user.md)** — Initiates a wiki sync by running `/refresh-wiki`.
2. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Resolves the workspace and loads config (repo identity, source dir, wiki dir, audience, tone).
3. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Absorbs editorial context for the target project.
4. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Discovers all content pages in the wiki directory. If no content pages exist, reports "nothing to sync" and stops.
5. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Identifies recent source code changes to provide as priority context for fact-checkers. This scopes attention, not coverage — fact-checkers check all claims on every page, but recent changes tell them where drift is most likely.
6. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Dispatches fact-checkers across all content pages with source context and editorial guidance.
7. **[Fact-checkers](../actors/11-fact-checkers.md)** — Each reads its assigned wiki page, identifies all sources of truth (source code files referenced or implied by the content, external URLs, linked resources), and verifies every factual claim. Each claim is assessed as: verified (accurate against source), inaccurate (with the correct fact and source reference), or unverifiable (source unreachable, with the source that could not be reached).
   --> DriftDetected (one per inaccurate claim found)
   --> DriftSkipped (one per unverifiable claim)
8. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Collects all fact-checker assessments. For pages where all claims are verified and no drift was detected, records them as up-to-date. For pages with drift, dispatches correctors.
9. **[Correctors](../actors/15-correctors.md)** — Each reads the page, reads the fact-checker's assessment, reads the cited source files to independently verify accuracy, and applies targeted corrections. For each correction, the corrector reports what changed and cites the source reference.
   --> DriftCorrected (one per applied correction)
10. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Compiles the sync report from all domain events (DriftDetected, DriftCorrected, DriftSkipped) and writes it to disk as a time-stamped report.
    --> WikiSynced
11. **[User](../actors/01-user.md)** — Reads the sync report. Reviews changes via git diff. Reverts any corrections they disagree with.

## Goal obstacles

### Step 2a — No workspace exists

1. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Reports that no workspace exists and directs the user to run `/up` first.
2. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Stops.

### Step 2b — Workspace not found for the given identifier

1. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Reports that no workspace matches the provided identifier and lists available workspaces.
2. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Stops.

### Step 4a — No content pages in wiki

1. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Reports "nothing to sync" — the wiki directory contains no content pages. Directs the user to `/init-wiki` to populate the wiki first.
2. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Stops.

### Step 7a — One or more fact-checkers fail

A fact-checker crashes, times out, or produces unusable results. The pages it was responsible for are not checked.

1. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Records which pages were not checked.
2. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Proceeds with the assessments from successful fact-checkers. Pages with drift are sent to correctors. The report notes unchecked pages.

### Step 7b — All external sources are unreachable

Network connectivity is degraded. No external URLs can be reached. Source code is still available locally.

1. **[Fact-checkers](../actors/11-fact-checkers.md)** — Verify all source-code-grounded claims normally. Record all external-reference-based claims as unverifiable.
2. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Proceeds with whatever drift was detected from source code verification. The report's errata section lists all unverifiable claims.

### Step 9a — One or more correctors fail

A corrector crashes, times out, or produces unusable results. The corrections it was responsible for are not applied.

1. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Records which pages failed. Successfully applied corrections from other correctors remain on disk.
2. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Includes the failures in the sync report. The user retries `/refresh-wiki` to pick up uncorrected drift.

### Step 9b — Corrector finds the fact-checker's assessment is wrong

The corrector reads the cited source file and finds that the wiki is actually correct — the fact-checker made an error in judgment.

1. **[Correctors](../actors/15-correctors.md)** — Skips the correction. Reports that the wiki content is accurate and the assessment was incorrect, citing the source evidence.
2. **[Alignment orchestrator](../actors/06-alignment-orchestrator.md)** — Records the skipped correction in the report. No change is made to the wiki page.

## Domain events

### Published

- **[WikiSynced](../events/05-wiki-synced.md)** — Sync operation completed.

### Internal

- **DriftDetected** — A fact-checker found a wiki claim that does not match its source of truth. Structurally compatible with [Drift detection](../contexts/04-drift-detection.md)'s correction assignment, enabling corrector reuse.
- **DriftSkipped** — A fact-checker could not verify a claim (source unreachable). Surfaces in the report's errata section.
- **DriftCorrected** — A corrector applied a correction. Materializes in the sync report.

## Notes

- **Accuracy only, by design.** Sync wiki with source changes is a single-lens operation. [Review wiki quality](02-review-wiki-quality.md) applies four editorial lenses (structure, line, copy, accuracy). Sync wiki with source changes applies only the accuracy lens equivalent — but with broader scope, since it verifies against external references as well as source code. [Review wiki quality](02-review-wiki-quality.md)'s accuracy lens is strictly source-code-grounded; sync wiki with source changes' fact-checking includes any source of truth referenced in the wiki content. This is a noted gap in [Review wiki quality](02-review-wiki-quality.md) that may be addressed in a future revision.
- **No `-plan` flag.** The command file currently supports `-plan` to stop after assessment. The use case removes this. Every run produces a different outcome based on the current state of source code and external references, making dry runs an inefficient use of tokens. The user reviews changes after the fact via git diff.
- **Git is the approval gate, not a confirmation step.** [Populate new wiki](01-populate-new-wiki.md) requires plan approval before writing. Sync wiki with source changes does not. The user trusts the system to make corrections and uses git as the post-hoc safety net. This is appropriate because sync wiki with source changes makes targeted factual corrections, not structural decisions. The risk of a bad correction is low and easily reversible.
- **Corrector reuse.** The corrector is shared between [Revise wiki](03-revise-wiki.md) and sync wiki with source changes. Both consume the same structural input: a page, a finding (what's wrong), a recommendation (what it should say), and a source reference. In [Revise wiki](03-revise-wiki.md), this input comes from parsed GitHub Issues. In sync wiki with source changes, it comes from the fact-checker assessment. The correction assignment is designed to be compatible with both sources.
- **Recent changes are context, not scope.** The orchestrator identifies recent source code changes (step 5) and provides them to fact-checkers as priority context. Fact-checkers use this to focus attention on areas where drift is most likely. But they check all claims on every page — recent changes do not filter which pages or claims are examined. A wiki page that references no recently changed source files still has its external references and stable source code claims verified.
- **Idempotent in spirit.** Running `/refresh-wiki` multiple times is expected and encouraged. Each run may catch drift that a previous run missed. Over successive runs, the wiki converges toward full accuracy. The user cannot prove completeness — you cannot prove a negative — but repeated runs increase confidence.
- **Stale [Review wiki quality](02-review-wiki-quality.md) issues are an accepted gap.** If [Review wiki quality](02-review-wiki-quality.md) has filed an accuracy issue and sync wiki with source changes independently corrects the same inaccuracy, the GitHub issue becomes stale. When the user runs `/revise-wiki` ([Revise wiki](03-revise-wiki.md)), the corrector will find that the quoted text no longer exists and skip the issue. This is a known consequence of sync wiki with source changes' independence from the issue system, accepted in favor of keeping sync wiki with source changes fast and focused.
- **Report accumulation.** Sync reports are time-stamped and stored persistently. The user can compare reports across runs to see trends: are the same pages drifting repeatedly? Are external references becoming unreachable? This supports subjective judgment about the system's effectiveness. The report path (`workspace/artifacts/{owner}/{repo}/reports/sync/`) is outside both clones, keeping them uncontaminated.
- **Implementation gap: command file scope is too narrow.** The current command file only checks wiki pages mapped to recently changed source files. The use case checks all content pages against all sources of truth, with recent changes as a priority hint. The command file needs to be updated to reflect this broader scope.
- **Implementation gap: command file supports `-plan` flag.** The use case removes this. The command file should be updated.
- **Implementation gap: command file uses "last 50 commits" heuristic.** The use case says "recent source code changes" without prescribing a specific commit count. The implementation may use 50 commits, HEAD-based diffs, or date-based ranges — this is an implementation detail.
- **Implementation gap: command file has no report output.** The command file produces a console summary table but does not write a durable report to disk. The use case requires a persistent, time-stamped sync report.
- **Implementation: editorial context sources.** Step 3 absorbs editorial context from: editorial guidance (`.claude/guidance/editorial-guidance.md`), wiki instructions (`.claude/guidance/wiki-instructions.md`), and the target project's CLAUDE.md if it exists (`{sourceDir}/CLAUDE.md`).
- **Implementation: content page discovery.** Step 4 identifies content pages by excluding structural files — those prefixed with `_` (e.g., `_Sidebar.md`, `_Footer.md`).
- **Implementation: fact-checker dispatch.** Step 6 provides each fact-checker with: the page path, the source directory, recent change context, audience, tone, and editorial guidance.
- **Relationship to other use cases:** Sync wiki with source changes requires [Provision workspace](05-provision-workspace.md) as a prerequisite. It typically follows [Populate new wiki](01-populate-new-wiki.md) — there must be content pages to sync. Its corrections may render [Review wiki quality](02-review-wiki-quality.md) accuracy findings stale (accepted gap). It has no dependency on [Revise wiki](03-revise-wiki.md) but shares the corrector protocol. It has no dependency on [Decommission workspace](06-decommission-workspace.md).
