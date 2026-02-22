# 03 — Revise wiki

## Goal

Every actionable documentation problem tracked in GitHub Issues has its recommended correction applied to the wiki. The wiki content is fixed — inaccuracies corrected, prose tightened, structure improved, terminology standardized. Issue closure is a consequence of successful remediation, not the goal itself. An issue closed without the fix actually applied is a violation.

## Context

- **Bounded context:** [Wiki revision](../contexts/03-wiki-revision.md)
- **Primary actor:** [User](../actors/01-user.md)
- **Supporting actors:** [Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md) (`/revise-wiki` command), [Correctors](../actors/15-correctors.md) (one per wiki page with issues)
- **Trigger:** The user has open documentation issues (typically produced by [Review wiki quality](02-review-wiki-quality.md)) and wants the recommended corrections applied to the wiki.

## Actor responsibilities

See also: actors/index for full actor definitions, drives, and the appearance matrix.

Each actor has a single drive. Separation exists because no single drive can protect all the concerns at play.

- **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Drive: fulfillment. Resolves the workspace, absorbs editorial context, fetches and parses issues, filters out unapplicable issues, groups actionable issues by wiki page, dispatches correctors, collects results, closes or comments on issues, and presents the summary. The fulfillment orchestrator makes no editorial judgments and applies no fixes. Consumes the workspace config produced by [Provision workspace](05-provision-workspace.md). Consumes GitHub issues (conforming to the `documentation-issue.md` schema) produced by [Review wiki quality](02-review-wiki-quality.md). Produces issue closure events and correction summaries.

- **[Correctors](../actors/15-correctors.md)** — Drive: remediation. Each receives a wiki page and its associated issues, reads the page, reads source code for accuracy issues, and applies each recommendation using targeted edits. The corrector's drive is to apply known fixes to known problems — it does not discover new problems (that is the critique drive in [Review wiki quality](02-review-wiki-quality.md)) and it does not create new content (that is the production drive in [Populate new wiki](01-populate-new-wiki.md)). The corrector trusts the recommendation unless it contradicts source code, the target text no longer exists, or the recommendation is ambiguous. When the corrector cannot apply a recommendation, it skips the issue with a reason rather than guessing. Consumes page assignments with parsed issue data produced by the fulfillment orchestrator. Produces correction reports consumed by the fulfillment orchestrator.

## Invariants

See also: invariants/index

- **Remediate, never create.** Correctors apply corrections to existing wiki content. They do not add new pages, new sections, or substantial new content. If a structural issue's recommendation calls for adding a new section, the corrector applies it. But the corrector never generates content beyond what the recommendation describes.
- **Only close what you fixed.** An issue is closed only when the recommended correction has been applied to the wiki file and the edit tool reported success. An issue closed without the fix applied is a violation. This is the structural guarantee that issue closure tracks actual remediation.
- **[Source repo readonly.](../invariants/03-source-repo-readonly.md)** Correctors read source code to verify accuracy recommendations but never modify it. If an accuracy recommendation contradicts the source code, the corrector skips the issue — it does not "fix" the source.
- **Targeted edits, not rewrites.** Correctors use the Edit tool for surgical changes. Entire pages are not rewritten unless a structural issue specifically requires it. The existing page structure, voice, and content beyond the finding are preserved.
- **Unstructured issues are skipped.** Issues that do not follow the `documentation-issue.md` template format (missing Page, Finding, or Recommendation fields) are not actionable by the system. They are skipped without comment — the system does not attempt to interpret freeform issue text.
- **Idempotency.** Running `/revise-wiki` twice is safe. If the quoted text from a finding no longer exists in the wiki (because a previous run or manual edit already addressed it), the corrector skips the issue. New issues filed since the last run are picked up.
- **Editorial guidance is current.** Correctors read the current editorial guidance and wiki instructions before applying fixes. Editorial standards may have evolved since the issue was filed. The applied fix conforms to current guidance, not just the recommendation text.
- **[No CLI-style flags.](../invariants/09-no-cli-style-flags.md)** The command applies corrections to all open actionable documentation issues. There are no flags, issue number filters, or page name filters. If scope narrowing is ever needed, it happens through conversation, not arguments.
- **[Repo freshness is the user's responsibility.](../invariants/06-repo-freshness-user-responsibility.md)** The system does not pull or verify that clones are up to date. The user is responsible for ensuring the workspace reflects the state they want corrected.

## Success outcome

- Every actionable documentation issue has its recommended correction applied to the corresponding wiki page.
- Corrected issues are closed on GitHub with a comment noting the fix.
- Skipped issues remain open with a comment explaining why.
- Issues that needed clarification are labeled `needs-clarification` on GitHub.
- The user sees a brief summary: issues corrected, issues skipped, remaining open count.
- Wiki files on disk reflect all applied corrections.

## Failure outcome

- If failure occurs before correctors are dispatched (workspace resolution, issue fetching, parsing), no wiki files are modified. The user is told what failed.
- If some correctors succeed and others fail, successfully applied corrections remain on disk. The summary reports which pages were corrected and which correctors failed.
- If [GitHub](../actors/16-github.md) is unreachable when fetching issues, the system cannot operate — issues are the input. The user is told and the system stops.
- If issue closing fails after a fix is applied, the fix remains on disk. The user is told which issues were fixed but not closed so they can close them manually.
- In all cases, the user is told what happened and what to do about it.

## Scenario

1. **[User](../actors/01-user.md)** — Initiates revision by running `/revise-wiki`.
2. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Resolves the workspace and loads config (repo identity, source dir, wiki dir, audience, tone).
3. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Absorbs editorial context for the target project.
4. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Fetches all open GitHub issues labeled `documentation` for this repository.
5. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Extracts actionable information from each issue. Issues that lack required structured fields are set aside as unapplicable.
6. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Organizes actionable issues for remediation.
7. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Dispatches correctors with their page assignments and context.
8. **[Correctors](../actors/15-correctors.md)** — Each reads the wiki page, reads source files for accuracy issues, and applies each recommended correction. For each issue, the corrector reports: applied (with a description of the change) or skipped (with reason).
   --> IssueCorrected (one per applied issue)
   --> IssueSkipped (one per skipped issue)
9. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — For applied issues, closes the GitHub issue with a comment noting the correction. For skipped issues, comments on the GitHub issue explaining why it was skipped. For issues skipped due to ambiguity or need for clarification, also adds the `needs-clarification` label.
   --> IssueCloseDeferred (one per issue where closing or commenting fails)
10. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Presents a brief summary: issues corrected, issues skipped (with reasons), issues where close failed, remaining open count.
    --> WikiRemediated

## Goal obstacles

### Step 2a — No workspace exists

1. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Reports that no workspace exists and directs the user to run `/up` first.
2. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Stops.

### Step 2b — Workspace not found for the given identifier

1. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Reports that no workspace matches the provided identifier and lists available workspaces.
2. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Stops.

### Step 4a — GitHub is unreachable

The system cannot fetch issues. Unlike [Review wiki quality](02-review-wiki-quality.md) (which has a local fallback for output), this use case has no fallback for input — the issues live in GitHub.

1. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Reports that GitHub is unreachable and issues cannot be fetched.
2. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Stops. The user resolves the connectivity issue and retries.

### Step 4b — No open documentation issues

No open issues with the `documentation` label exist. There is nothing to remediate.

1. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Reports that there are no open documentation issues.
2. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Stops. This is not a failure — the wiki has no known problems.

### Step 5a — All issues are unstructured

Every open documentation issue lacks the structured fields from the `documentation-issue.md` template. None are actionable by the system.

1. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Reports that all open issues lack structured fields and cannot be processed. Suggests the user review them manually on GitHub.
2. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Stops.

### Step 8a — One or more correctors fail

A corrector crashes, times out, or produces unusable results. The page it was responsible for is not corrected.

1. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Reports which pages failed and which were successfully corrected.
2. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Proceeds with closing/commenting on issues for the pages that were successfully corrected.
3. The summary reports which pages were not addressed. The user retries `/revise-wiki` to pick up the remaining issues.

### Step 8b — Recommendation contradicts source code

A corrector reads the source file for an accuracy issue and finds that the wiki is actually correct — the recommendation is wrong.

1. **[Correctors](../actors/15-correctors.md)** — Skips the issue. Reports that the recommendation contradicts the source code, citing the specific disagreement.
2. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Comments on the GitHub issue explaining the contradiction. The issue remains open for human review.

### Step 9a — Issue close or comment fails

The fix was applied to the wiki file on disk, but the GitHub API call to close or comment on the issue fails.

1. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Records the failure. The wiki file already contains the correction.
   --> IssueCloseDeferred
2. **[Fulfillment orchestrator](../actors/05-fulfillment-orchestrator.md)** — Continues processing remaining issues.
3. The summary reports issues that were fixed on disk but not closed on GitHub, so the user can close them manually.

## Domain events

### Published

- **[WikiRemediated](../events/04-wiki-remediated.md)** — Remediation run completed.

### Internal

- **IssueCorrected** — A corrector has applied a recommendation. Consumed by the fulfillment orchestrator to close the GitHub issue.
- **IssueSkipped** — A corrector could not remediate an issue. Consumed by the fulfillment orchestrator to comment on the GitHub issue.
- **IssueCloseDeferred** — Fix applied but GitHub issue could not be closed (API failure). Exposed in summary.

## Notes

- **Revision, not resolution.** The corrector's drive is remediation — applying known fixes to known problems, not closing tickets. The command is named `/revise-wiki` because this is what an editorial team does after proofreading: revise the manuscript. An agent that optimizes for closing issues would be tempted to close without fixing. An agent that optimizes for remediation applies the fix and lets closure follow naturally.
- **Consuming review output.** This use case consumes FindingFiled events from [Review wiki quality](02-review-wiki-quality.md) via GitHub Issues. The issue body conforming to `documentation-issue.md` is the published protocol. This use case has no dependency on the review's internal state (proofread cache, explorer summaries) — only on the durable GitHub issues. Proofreading produces the marks; revision applies corrections.
- **Unstructured issues are invisible.** Manually created issues that do not follow the template format are skipped silently. The system does not comment on them or mark them. This is a deliberate boundary: the system only processes what it can parse. Users who want manual issues resolved must do so manually.
- **Conflicting edits on the same section.** When multiple issues affect the same section of a wiki page, the corrector must coordinate edits so they do not conflict. This is an implementation concern — the corrector applies edits sequentially within a page, reading the page state between edits if necessary. Not modeled as a use-case-level obstacle because it is a coordination problem internal to the corrector, not a threat to the goal.
- **`needs-clarification` label.** When a corrector skips an issue because the recommendation is ambiguous or needs human input, the fulfillment orchestrator adds a `needs-clarification` label to the GitHub issue (in addition to commenting). This makes ambiguous issues filterable and queryable on GitHub. The `documentation` label remains.
- **Implementation: editorial context sources.** Step 3 absorbs editorial context from: editorial guidance (`.claude/guidance/editorial-guidance.md`), wiki instructions (`.claude/guidance/wiki-instructions.md`), and the target project's CLAUDE.md if it exists (`{sourceDir}/CLAUDE.md`).
- **Implementation: issue parsing.** Step 5 parses each issue body against the `documentation-issue.md` template schema, extracting structured fields: Page, Editorial lens, Severity, Finding, Recommendation, Source file, Notes.
- **Implementation: corrector dispatch.** Step 6 groups actionable issues by wiki page and notes source file references for accuracy issues. Step 7 dispatches one corrector per wiki page, providing the page path, parsed issues, source file paths, editorial guidance, audience, and tone.
- **Relationship to other use cases:** This use case requires [Provision workspace](05-provision-workspace.md) as a prerequisite. It consumes FindingFiled events from [Review wiki quality](02-review-wiki-quality.md) via GitHub Issues. It has no dependency on [Populate new wiki](01-populate-new-wiki.md), [Sync wiki with source changes](04-sync-wiki-with-source-changes.md), or [Decommission workspace](06-decommission-workspace.md). Review wiki quality and this use case share a published protocol (the issue body schema) but operate independently — they do not share internal state.
