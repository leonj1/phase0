# 02 — Review wiki quality

## Goal

Every real problem in the wiki — inaccuracies against source code, structural weaknesses, unclear prose, style violations — is exposed as a GitHub issue with enough context to act on. The wiki itself is untouched. The user has a clear picture of what is strong, what needs fixing, and where to start. The creator's production drive (01-populate-new-wiki) is insufficient to guarantee accuracy on its own; the proofreader's critique drive exists to find what the creator missed or got wrong.

## Context

- **Bounded context:** contexts/02-editorial-review
- **Primary actor:** actors/01-user
- **Supporting actors:** actors/04-oversight-orchestrator (`/proofread-wiki` command), actors/09-researchers, actors/10-proofreaders (one per editorial lens), actors/12-deduplicator
- **Trigger:** The user has a populated wiki (01-populate-new-wiki or manually authored) and wants an independent editorial review.

## Actor responsibilities

See also: actors/index for full actor definitions, drives, and the appearance matrix.

Each actor has a single drive. Separation exists because no single drive can protect all the concerns at play. The proofreader's critique drive is the complement to the production drive in 01-populate-new-wiki — not because the creator is malicious, but because a single drive cannot serve competing concerns.

- **actors/04-oversight-orchestrator** — Drive: oversight. Resolves the workspace, absorbs editorial context, dispatches researchers and proofreaders, collects results, files issues, cleans up the cache, and presents the summary. The oversight orchestrator makes no editorial judgments and performs no reviews. Consumes the workspace config produced by 05-provision-workspace. Consumes explorer summaries produced by researchers and finding reports produced by proofreaders. Produces GitHub issues (one per finding) consumed by 03-revise-wiki.

- **actors/09-researchers** — Drive: comprehension. Each examines the source code from a distinct domain facet and produces a structured summary. At minimum three facets: the public API surface (exported components — public classes, interfaces, entry points), architecture (components, abstractions, data flows), and configuration (options, constraints, limitations, edge cases). Additional facets may be warranted for some projects. Researchers are read-only — they never modify files. Produces explorer summaries consumed by proofreaders.

- **actors/10-proofreaders** — Drive: critique. Each examines the wiki content through one editorial lens. There are four lenses, each representing a distinct editorial discipline:

  - **Structure lens** — Organization, flow, gaps, redundancies. Requires whole-wiki visibility to assess how pages relate, where content is missing, and where it overlaps. Sidebar structural integrity (orphan pages, broken links) is checked here.
  - **Line lens** — Sentence-level clarity, tightening, transitions. Page-local work. Each page is examined independently.
  - **Copy lens** — Grammar, formatting, terminology consistency. Requires cross-page visibility for terminology — the same concept must be named the same way across the entire wiki.
  - **Accuracy lens** — Claims verified against source code. Requires source code access per page. Each page's code identifiers are traced back to source files and verified.

  A proofreader that finds nothing wrong reports that the content is clean. An editor who nitpicks everything is as unhelpful as one who misses real problems. The drive is to find real problems, not to generate findings. Consumes explorer summaries produced by researchers. Produces structured findings consumed by the deduplicator.

- **actors/12-deduplicator** — Drive: filtering. Compares findings against existing open GitHub issues labeled `documentation`. Its job is to prevent duplicate issues — not to suppress legitimate findings. Only drops a finding when it clearly matches an existing open issue about the same problem. A finding about a different section of the same page is not a duplicate. Consumes findings produced by proofreaders. Produces deduplicated findings consumed by the oversight orchestrator.

## Invariants

See also: invariants/index

- **Review-only — never edit wiki files.** The proofreader's output is exclusively GitHub issues (or local fallback files when actors/16-github is unreachable). A proofreader that "helpfully" fixes a problem it found has violated this invariant. This is the structural separation between review (critique drive) and 03-revise-wiki (remediation drive).
- **One issue per finding.** Findings are never grouped into a single issue. Each issue is independently actionable. This matters downstream — 03-revise-wiki consumes individual issues.
- **Source code is the authority for accuracy.** When a proofreader checks whether a wiki claim is correct, the source code is the ground truth — not training data, not inference, not external documentation. If a claim cannot be verified against source code, it is flagged as unverified rather than reported as a finding.
- **Findings must be grounded.** A finding without a quote of the problematic text is not actionable. Accuracy findings must cite the source file and line. Copy and line findings must provide corrected text. Structural findings must describe what is missing, misplaced, or redundant.
- **Err on the side of filing.** During deduplication, only skip when the match is clearly the same problem. When in doubt, file.
- **Issue template must exist.** The issue template (`.claude/forms/documentation-issue.md`) belongs to the wiki-agent repo and must be present. Filed issues conform to its schema.
- **Editorial guidance must exist.** The editorial guidance (`.claude/guidance/editorial-guidance.md`) and wiki instructions (`.claude/guidance/wiki-instructions.md`) belong to the wiki-agent repo and must be present. Proofreaders apply these standards.
- **`documentation` label is invariant.** All wiki-related issues carry the `documentation` label. Deduplication scopes to open issues with this label.
- **Proofread cache is ephemeral.** The `workspace/artifacts/{owner}/{repo}/.proofread/` cache exists only to coordinate agents during a single run. It is created at the start and cleaned up at the end. GitHub issues are the durable output.
- **invariants/06-repo-freshness-user-responsibility** The system does not pull or verify that clones are up to date. The user is responsible for ensuring the workspace reflects the state they want reviewed.

## Success outcome

- Every actionable finding exists as a GitHub issue with the `documentation` label, conforming to the issue template schema.
- Each issue quotes the problematic text, provides a recommendation, and (for accuracy issues) cites the source file and line.
- The user sees a summary: what is strong, issues filed (with numbers, pages, titles, severities, and lenses), clean pages, and any unverified items.
- The proofread cache has been cleaned up.
- The wiki content is unmodified.

## Failure outcome

- If failure occurs before proofreaders complete (workspace resolution, researcher failure, all proofreaders fail), no issues are filed. The user is told what failed.
- If some proofreaders succeed and some fail, findings from successful proofreaders proceed through the pipeline. The summary reports which pages or lenses were not covered.
- If actors/16-github is unreachable, issues are written locally to `workspace/artifacts/{owner}/{repo}/reports/review-fallback/{date-time}/` as fallback files. The summary reports locally-written issues with file paths.
- If individual issue filings fail, those issues are written locally as fallback. Other filings proceed.
- In all cases, the proofread cache is cleaned up and the user is told what happened.

## Scenario

1. **actors/01-user** — Initiates a wiki review by running `/proofread-wiki`.
2. **actors/04-oversight-orchestrator** — Resolves the workspace and loads config (repo identity, source dir, wiki dir, audience, tone).
3. **actors/04-oversight-orchestrator** — Absorbs editorial context for the target project.
4. **actors/04-oversight-orchestrator** — Discovers all content pages in the wiki directory. If no content pages exist, reports "nothing to review" and stops.
5. **actors/04-oversight-orchestrator** — Dispatches researchers to build a project summary from the source code.
6. **actors/09-researchers** — Each reads the source code and produces a summary covering its assigned facet.
7. **actors/04-oversight-orchestrator** — Dispatches proofreaders across all four editorial lenses. Each lens is applied to the wiki content.
8. **actors/10-proofreaders** — Each examines the wiki through its assigned editorial lens, using project summaries and source code as reference. Each problem found is exposed as a finding.
   --> IssueIdentified (one per finding)
9. **actors/12-deduplicator** — Collects all findings from the current review. Reads all open GitHub issues labeled `documentation`. Drops findings that clearly match existing open issues. Produces the set of findings to be filed.
   --> IssueToBeFiled (one per surviving finding)
10. **actors/04-oversight-orchestrator** — Files one GitHub issue per IssueToBeFiled event, using the issue template format.
    --> FindingFiled (one per issue)
    --> WikiReviewed
11. **actors/01-user** — Sees the review summary: what is strong, issues filed, unverified items, clean pages, failed reviews, failed filings.

## Goal obstacles

### Step 2a — No workspace exists

1. **actors/04-oversight-orchestrator** — Reports that no workspace exists and directs the user to run `/up` first.
2. **actors/04-oversight-orchestrator** — Stops.

### Step 2b — Workspace not found for the given identifier

1. **actors/04-oversight-orchestrator** — Reports that no workspace matches the provided identifier and lists available workspaces.
2. **actors/04-oversight-orchestrator** — Stops.

### Step 4a — No content pages in wiki

1. **actors/04-oversight-orchestrator** — Reports "nothing to review" — the wiki directory contains no content pages (only structural files or nothing at all).
2. **actors/04-oversight-orchestrator** — Stops.

### Step 6a — One or more researchers fail

One or more researchers fail to produce a summary (crash, timeout, or unusable results).

1. **actors/04-oversight-orchestrator** — Reports which researchers failed and which facets of the source code were not summarized.
2. **actors/04-oversight-orchestrator** — Proceeds with the summaries that succeeded. Proofreaders work with incomplete context. Accuracy verification may be less thorough, and affected findings may be flagged as lower-confidence.

### Step 8a — One or more proofreaders fail

A proofreader crashes, times out, or produces unusable results. The page or lens it was responsible for is not reviewed.

1. **actors/04-oversight-orchestrator** — Retries the failed proofreader once.
2. If the retry fails, the oversight orchestrator records the failure. Findings from other proofreaders proceed through the pipeline.
3. The summary reports which pages or lenses were not covered.

### Step 9a — GitHub is unreachable

The deduplicator cannot read open issues, and the oversight orchestrator cannot file new issues. The entire GitHub integration is unavailable.

1. **actors/04-oversight-orchestrator** — Skips deduplication (cannot compare against existing issues).
2. **actors/04-oversight-orchestrator** — Writes all findings as local fallback files to `workspace/artifacts/{owner}/{repo}/reports/review-fallback/{date-time}/`, one file per finding, using the issue frontmatter format.
3. **actors/04-oversight-orchestrator** — Reports that issues were written locally because GitHub was unreachable, and provides the file paths.

### Step 9b — All findings are duplicates

Every finding matches an existing open GitHub issue. Nothing new to file.

1. **actors/12-deduplicator** — Reports that all findings are already covered by open issues (listing the matching issue numbers).
2. **actors/04-oversight-orchestrator** — Reports this in the summary. No issues are filed. This is not a failure — the wiki's known problems are already tracked.

### Step 10a — Individual issue filing fails

The issue filing script fails for a specific finding after its internal retry.

1. **actors/04-oversight-orchestrator** — Writes the failed issue as a local fallback file to `workspace/artifacts/{owner}/{repo}/reports/review-fallback/{date-time}/`, using the issue frontmatter format.
2. **actors/04-oversight-orchestrator** — Continues filing remaining issues.
3. The summary reports locally-written issues with file paths alongside successfully filed issues.

## Domain events

### Published

- **events/02-finding-filed** — GitHub issue created for a documentation problem. Published to contexts/03-wiki-revision.
- **events/03-wiki-reviewed** — Review process completed.

### Internal

- **IssueIdentified** — A proofreader has found a documentation problem. Materialized as a finding in the proofread cache. Consumed by the deduplicator.
- **IssueToBeFiled** — (Milestone.) Deduplicator confirmed a finding is new. Consumed by the oversight orchestrator for issue filing.

## Notes

- **`--pass` flag removed.** The command file currently supports `--pass` to run a single editorial lens. The use case does not model this — every invocation runs all four lenses. The command file should be updated to remove `--pass` support. This resolves the tension with invariants/09-no-cli-style-flags.
- **Editorial lenses, not passes.** The term "editorial lens" replaces "pass" to reflect that these are parallel editorial disciplines, not serial processing steps. Each lens has its own drive and its own input requirements. The four lenses — structure, line, copy, accuracy — map to distinct editorial disciplines in a human editing department.
- **Dispatch pattern is an implementation concern.** The use case specifies what each lens requires as input (whole-wiki visibility for structure, source code access for accuracy, cross-page terminology visibility for copy, page-local for line). How those requirements are satisfied — per-page agents, multi-page agents, or hybrids — is an implementation decision driven by context window constraints and model capabilities.
- **Explorer facets are extensible.** The three named facets (API surface, architecture, configuration) are the minimum. Some projects may warrant additional facets. The use case does not prescribe a fixed count.
- **Sidebar validation is proofreader work.** Sidebar structural integrity (orphan pages, broken links) is checked by the structure lens proofreader, not by the oversight orchestrator. Orchestrators coordinate; proofreaders review.
- **actors/16-github is a sub-system.** GitHub Issues serves as the system's durable event store for findings. The issue is the published fact that 03-revise-wiki consumes. This framing means GitHub unreachability is a system degradation, not an external dependency failure.
- **Local fallback path.** When GitHub is unreachable or individual filings fail, issues are written to `workspace/artifacts/{owner}/{repo}/reports/review-fallback/{date-time}/` — outside both the source clone and wiki clone. This keeps the source clone clean (invariants/03-source-repo-readonly) and the wiki clone uncontaminated by review artifacts.
- **Implementation: editorial context sources.** Step 3 absorbs editorial context from: editorial guidance (`.claude/guidance/editorial-guidance.md`), wiki instructions (`.claude/guidance/wiki-instructions.md`), the issue template (`.claude/forms/documentation-issue.md`), and the target project's CLAUDE.md if it exists (`{sourceDir}/CLAUDE.md`).
- **Implementation: content page discovery.** Step 4 identifies content pages by excluding structural files — those prefixed with `_` (e.g., `_Sidebar.md`, `_Footer.md`).
- **Implementation: proofread cache.** Explorer summaries (step 5), proofreader findings (step 8), and deduplicated results (step 9) are coordinated through the proofread cache (`workspace/artifacts/{owner}/{repo}/.proofread/`). The cache is created at the start of a run and cleaned up when the review completes. The cache path requires both owner and repo from workspace resolution (step 2) — it lives under the artifacts tree, not at the project root.
- **Relationship to other use cases:** This use case requires 05-provision-workspace as a prerequisite and typically follows 01-populate-new-wiki, though it can review any populated wiki. Its output (FindingFiled) feeds 03-revise-wiki via the issue body protocol. It has no dependency on 04-sync-wiki-with-source-changes or 06-decommission-workspace.
