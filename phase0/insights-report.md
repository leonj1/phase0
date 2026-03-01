# Claude Code Insights

544 messages across 36 sessions (53 total) | 2026-02-20 to 2026-02-22

## At a Glance

**What's working:** You've built a disciplined practice of treating LLM-facing documentation as first-class code -- running systematic audits across dozens of interconnected files, enforcing editorial standards like positive framing, and driving multi-file refactors to full completion. Your discovery of the `!cat` injection syntax and immediate refactoring of 16 skills and contracts shows a strong instinct for finding the right abstraction rather than tolerating tech debt.

**What's hindering you:** On Claude's side, it repeatedly confused your artifact types (skills vs. forms, notes vs. memory entries) and applied changes to files it shouldn't have touched, forcing you to interrupt and revert -- a pattern that cost real time across multiple sessions. On your side, Claude's recurring confusion around your project-specific vocabulary (what counts as a 'note,' which files get front matter) suggests these distinctions aren't yet codified somewhere Claude can reliably reference at the start of each session.

**Quick wins to try:** Turn your most-repeated audit patterns -- staleness sweeps, drift checks across idea pairs, positive-language compliance -- into custom slash-command skills so each one is a single `/audit-drift` instead of a multi-turn conversation. You could also add a post-edit hook that flags when form files are accidentally modified, catching the skill-vs-form confusion before it lands.

**Ambitious workflows:** As models get more capable, imagine a persistent integrity guardian that watches every file edit and enforces your conventions in real-time -- no more manually auditing 14 idea pairs across sessions. Your 24-file editorial sweeps could also be parallelized across Task sub-agents, each carrying your writing principles and processing files independently, turning multi-hour sequential passes into a single orchestrated command.

---

## Stats

| Metric | Value |
|---|---|
| Messages | 544 |
| Lines changed | +4,451 / -625 |
| Files touched | 248 |
| Days | 3 |
| Messages/day | 181.3 |

---

## What You Work On

**Domain Modeling & Contract Architecture** (~10 sessions)
Extensive work on a Phase0 design system's architecture, including refining domain modeling agents, separating concerns across contract files (structuring-todos, structuring-notes, preserving-discoveries), establishing contracts-based modeling patterns, and defining source-of-truth conventions for 'idea' file pairs (skill + form). Claude Code was used heavily for multi-file reads, edits, and grep/glob searches to maintain consistency across interconnected artifacts.

**Content Editing & Editorial Standards** (~10 sessions)
Systematic editorial sweeps across documentation files to enforce positive-language framing ('define by presence'), remove negation patterns, reframe negative language, apply bold formatting conventions, and review vision articles against VISION.md for completeness. Claude Code performed bulk edits across 24+ files per pass, auditing against writing principles and applying recommended changes.

**Skill & Documentation Synchronization** (~9 sessions)
Auditing and fixing drift between skill files and their modeling counterparts, eliminating duplication via a DRY injection mechanism (!`cat` syntax), adding YAML front matter to skill files, consolidating philosophy docs, and ensuring referential integrity across all project artifacts. Claude Code's Read, Edit, and Grep tools were used extensively to compare file pairs, detect staleness, and apply synchronized updates across 14+ file pairs.

**Project Hygiene & Refactoring** (~5 sessions)
Renaming directories and files with full reference updates (e.g., renaming 9 form files with 32 edits across 28+ files), running staleness audits to find broken links and deprecated references, verifying legacy-to-modern model migrations with no data loss, and cleaning up stale project instruction references. Claude Code handled systematic search-and-replace operations and verification passes.

**Vision & Thesis Refinement** (~4 sessions)
Iterative refinement of the Phase0 project's thesis statement and manifesto, eliminating outdated 'discovery process' / 'four rounds' concepts from vision docs, updating design-cycle.md wiring, and restoring key framing elements like the Cooper reference. Claude Code was used for targeted edits to vision and manifesto files and for verifying cross-document consistency.

### What you wanted most

1. Content Editing -- 8 sessions
2. Contract Refinement -- 6 sessions
3. Architecture Documentation Updates -- 6 sessions
4. Content Editing and Synchronization -- 6 sessions
5. Agent Behavior Refinement -- 4 sessions
6. Architectural Discussion -- 3 sessions

### Top tools used

1. Read -- 500
2. Edit -- 414
3. Grep -- 78
4. Glob -- 63
5. Write -- 59
6. Bash -- 58

### Languages

1. Markdown -- 956
2. JSON -- 6
3. Shell -- 4

### Session types

1. Iterative Refinement -- 21
2. Single Task -- 6
3. Multi Task -- 4
4. Quick Question -- 4
5. Exploration -- 1

---

## How You Use Claude Code

You are a **meticulous systems architect** who uses Claude Code as a documentation and domain-modeling workbench rather than a traditional coding tool. Across 36 sessions in just three days, you drove an extraordinary volume of work -- 544 messages over 65 hours -- almost entirely in Markdown, iteratively refining contracts, principles, agent definitions, and editorial standards for your Phase0 design system. Your workflow is deeply **iterative and audit-driven**: you repeatedly ask Claude to sweep files for drift, staleness, broken references, and terminology inconsistencies, then systematically fix everything it finds. You don't write detailed upfront specs; instead, you **steer through correction**, giving Claude a direction and then course-correcting when it misunderstands or over-applies changes. For example, when Claude added YAML front matter to both skill and form files, you interrupted to clarify that only skills get front matter. When it dropped your agent memory section during a merge, you called it out directly. This pattern of launch-then-redirect is your primary interaction mode.

Your sessions reveal someone who is **deeply invested in architectural consistency** across a large artifact surface. You frequently commission audits -- referential integrity checks across 14 file pairs, positive-language compliance sweeps across 24 files, staleness audits across 11+ files -- and then expect Claude to apply every recommended fix systematically. The Read tool was invoked 500 times and Edit 414 times, reflecting a workflow that is fundamentally about reading existing state, identifying drift, and correcting it. You also use Claude as a **thinking partner for naming and framing**: iteratively refining a thesis statement, defining the term 'idea' as a formal concept, establishing a 'define by presence' editorial standard. When friction arises, it's typically because Claude guessed instead of researching (you had to push it to find the correct `!cat` skill syntax) or because it misinterpreted scope (treating 'add a note' as a memory entry rather than a structured artifact). You're patient but firm -- you'll redirect multiple times but expect Claude to lock in after correction.

Notably, you have **zero commits** across all sessions, suggesting you either commit outside Claude's workflow or are building up a body of work before a major checkpoint. Your 69% fully-achieved rate with 89% satisfaction signals a productive but sometimes bumpy collaboration, where Claude's main failure mode is **over-applying or misunderstanding the boundaries** of your carefully scoped requests. You treat Claude less like an autocomplete engine and more like a junior editor who needs clear guardrails but can execute systematically once pointed in the right direction.

**Key pattern:** You operate as an audit-and-correct architect, commissioning systematic sweeps across large artifact surfaces and steering Claude through real-time course corrections rather than detailed upfront specifications.

### User response time distribution

| Window | Count |
|---|---|
| 2-10s | 11 |
| 10-30s | 71 |
| 30s-1m | 80 |
| 1-2m | 99 |
| 2-5m | 76 |
| 5-15m | 59 |
| >15m | 15 |

Median: 82.1s -- Average: 221.1s

### Multi-clauding (parallel sessions)

- 18 overlap events
- 23 sessions involved
- 21% of messages sent during overlapping sessions

You run multiple Claude Code sessions simultaneously. Multi-clauding is detected when sessions overlap in time, suggesting parallel workflows.

### User messages by time of day (PT / UTC-8)

| Period | Count |
|---|---|
| Morning (6-12) | 0 |
| Afternoon (12-18) | 183 |
| Evening (18-24) | 231 |
| Night (0-6) | 130 |

### Tool errors encountered

| Type | Count |
|---|---|
| Other | 20 |
| Command Failed | 8 |
| User Rejected | 8 |
| File Too Large | 4 |
| File Not Found | 3 |
| Edit Failed | 1 |

---

## Impressive Things You Did

Over 36 sessions in just 3 days, you've been intensively building and refining a contracts-based design system (Phase0) with remarkable consistency and a 69% full-achievement rate.

**Systematic Cross-File Consistency Auditing**
You've developed a disciplined practice of running comprehensive audits -- staleness checks, referential integrity sweeps, drift analysis across 14+ file pairs, and positive-language compliance reviews -- then systematically applying fixes. This iterative audit-then-fix cycle across sessions has kept your growing documentation architecture remarkably clean and internally consistent.

**DRY Architecture Through Discovery**
You discovered the `!cat` skill injection syntax and immediately leveraged it to refactor all 16 skills and contracts, eliminating duplication between skill files and modeling contracts. This shows a strong instinct for finding the right abstraction rather than tolerating redundancy, and you drove the refactoring to full completion across documentation and implementation.

**Principled Editorial Standards at Scale**
You've established and enforced sophisticated writing principles -- positive framing ('define by presence'), no negation patterns, consistent terminology, bold formatting conventions -- across dozens of LLM-facing instruction files. You treat these documents as first-class code, running multi-pass reviews against your own standards and correcting Claude when edits violate your editorial philosophy.

### What helped most (Claude's capabilities)

1. Multi-file Changes -- 21
2. Good Explanations -- 5
3. Correct Code Edits -- 5
4. Proactive Help -- 2
5. Fast/Accurate Search -- 1
6. Good Debugging -- 1

### Outcomes

| Result | Count |
|---|---|
| Not Achieved | 1 |
| Partially Achieved | 3 |
| Mostly Achieved | 7 |
| Fully Achieved | 25 |

---

## Where Things Go Wrong

Your sessions reveal a pattern of Claude misinterpreting the scope or target of your requests, applying changes too broadly across file types, and guessing at solutions rather than researching them when uncertain.

### Misinterpreted Request Scope and Intent

Claude frequently misunderstood what you were asking for -- confusing artifact types, mixing up concepts, or taking action on the wrong target. You could reduce this by front-loading the specific artifact type and destination in your initial prompt (e.g., 'create a structured note file at X' rather than 'add a note').

- When you asked Claude to 'add a note' about an insight, it interpreted this as adding a memory entry instead of creating a structured note artifact, forcing you to manually provide the skill context and redirect it.
- When you asked Claude to recall a built-in skill from a prior session, it cycled through wrong guesses -- agents, custom skills, slash commands -- never landing on the right answer and wasting an entire session that ended with nothing achieved.

### Overly Broad or Incorrect File Targeting

Claude repeatedly applied changes to file types that shouldn't have been touched, particularly confusing your skill files with form files. You had to interrupt and revert multiple times. Explicitly stating exclusion rules up front (e.g., 'only skill files, never form files') or codifying these constraints in project instructions could prevent this recurring mistake.

- When you asked for YAML front matter to be added to skill files, Claude also incorrectly added it to form files -- which should remain free of front matter -- requiring you to catch the error, explain the distinction, and have it reverted.
- During a merge operation, Claude dropped the agent memory section and output conventions entirely, and you had to call it out directly ('why did you remove memory section and all that good output stuff?'), indicating it wasn't preserving the full scope of content it should have retained.

### Guessing Instead of Researching Solutions

When Claude was uncertain about tooling or configuration, it fell back on unreliable guesses rather than investigating the correct approach, costing you time and trust. Pushing Claude to verify its suggestions against actual documentation or tool output before presenting them would help, and you might consider adding a project instruction that says 'research before suggesting.'

- You had to call Claude out for previously suggesting a read-file approach that was unreliable, and had to explicitly push it to research the correct solution (the `!cat` skill syntax) instead of guessing -- a detour that delayed your DRY refactoring work.
- When helping you update Claude Code via winget, Claude suggested npm as a fallback (which you rejected), then could only provide manual instructions it couldn't execute -- a chain of guesses that never resolved the actual problem within the session.

### Primary friction types

1. Misunderstood Request -- 9
2. Wrong Approach -- 7
3. User Rejected Action -- 3
4. Excessive Changes -- 2
5. Buggy Code -- 1

### Inferred satisfaction (model-estimated)

| Level | Count |
|---|---|
| Frustrated | 2 |
| Dissatisfied | 5 |
| Likely Satisfied | 63 |
| Satisfied | 34 |
| Happy | 6 |

---

## Existing CC Features to Try

### Suggested project instruction additions

**File Type Conventions**
```
## File Type Conventions
- Skill files (`.claude/skills/`) get YAML front matter. Form files (`modeling/`) do NOT get front matter.
- When editing pairs of files (skill + form/model), always confirm which file type you're editing before applying structural changes like front matter.
```
*Why:* Claude repeatedly added front matter to form files that shouldn't have it, requiring user correction across multiple sessions.

**Language Standards**
```
## Language Standards
- All documentation and skill files target LLM agents as readers. Use positive-framing language ('define by presence') -- avoid negation patterns like 'don't', 'never', 'you lack', 'avoid'.
- Reframe constraints as what TO do, not what NOT to do.
```
*Why:* User ran multiple full-project sweeps across 24+ files to eliminate negative language and repeatedly corrected Claude for using 'you lack' phrasing -- this standard should be baked in.

**Artifacts & Notes**
```
## Artifacts & Notes
- When the user says 'add a note' or 'capture this as a note', create a structured note artifact file in the project's notes directory -- do NOT add a memory entry unless explicitly asked.
```
*Why:* Claude misinterpreted 'add a note' as a memory entry instead of a project note artifact, requiring manual correction.

**Source of Truth Pairs**
```
## Source of Truth Pairs
- An 'idea' is a source-of-truth modeling file paired with a skill file. The modeling file owns domain content; the skill file owns invocation behavior.
- When editing one file in a pair, always check the counterpart for drift. Skills inject modeling content via `!cat` syntax -- do not duplicate content across the pair.
```
*Why:* User spent many sessions auditing and syncing 14+ idea file pairs, establishing DRY conventions, and fixing drift -- this core architecture concept must be documented.

**Edit Scope Discipline**
```
## Edit Scope Discipline
- Only modify files explicitly in scope. When asked to edit skill files, do not also edit form files (or vice versa) unless instructed.
- Before bulk operations, confirm the exact set of target files with the user if there's any ambiguity about scope.
```
*Why:* Multiple friction events involved Claude over-applying changes (adding front matter to wrong file types, dropping sections during merges, editing beyond scope), requiring user rollbacks.

### Custom Skills

Define reusable prompt workflows as markdown files triggered by /command.

**Why for you:** You repeatedly run the same multi-file audits: staleness checks, positive-language sweeps, drift detection across skill/form pairs, and referential integrity reviews. A /audit-drift or /sweep-language skill would eliminate re-explaining the process each session.

```bash
mkdir -p .claude/skills/audit-drift && cat > .claude/skills/audit-drift/SKILL.md << 'EOF'
# Audit Drift Between Idea Pairs

1. Read all files in `modeling/` and `.claude/skills/` directories
2. Match each skill file to its modeling counterpart by name
3. For each pair, compare domain content and flag any drift
4. Use `!cat` injection syntax as the canonical DRY mechanism
5. Report findings as a structured markdown table: file pair, status (synced/drifted), details
6. Do NOT edit any files -- report only unless asked
EOF
```

### Hooks

Auto-run shell commands at lifecycle events like post-edit.

**Why for you:** Your project is 99% Markdown and you care deeply about consistency (front matter presence, positive language, no stale references). A post-edit hook could run a simple grep check to catch negative language patterns or missing front matter before you even review Claude's output.

```json
// Add to .claude/settings.json:
{
  "hooks": {
    "postEdit": {
      "command": "grep -rnl \"don't\\|never\\|avoid\\|you lack\" --include='*.md' .claude/skills/ modeling/ || true",
      "description": "Warn if negative language detected in edited markdown files"
    }
  }
}
```

### Task Agents

Claude spawns focused sub-agents for parallel exploration work.

**Why for you:** You already use Task/TaskUpdate heavily (37+22 invocations). Your audits often involve checking 14+ file pairs independently -- explicitly requesting sub-agents for parallel pair-checking could speed up your drift audits and referential integrity reviews significantly.

Prompt: "Spawn a task agent for each of the 14 idea pairs in modeling/ and .claude/skills/. Each agent should compare its pair for content drift, front matter compliance, and positive-language adherence. Collect all results into a single audit report."

---

## New Ways to Use Claude Code

### Repeated full-project sweeps are your biggest time sink

Codify your audit patterns into reusable skills so each sweep is a one-command operation instead of a multi-turn conversation.

Across 36 sessions, at least 10 were dedicated to auditing and fixing drift, staleness, language compliance, or referential integrity across the same file sets. Each time you re-explain the scope, the rules, and the output format. By encoding these as /audit-drift, /sweep-language, and /check-staleness skills, you'd cut session overhead dramatically and get consistent output formatting every time.

> **Paste into Claude Code:** Create a custom skill at .claude/skills/sweep-language/SKILL.md that reviews all .md files in modeling/ and .claude/skills/ for negative language patterns (don't, never, avoid, lack, instead of). Report violations as a markdown table with file, line number, original text, and suggested positive reframe. Do not edit files unless I say 'apply fixes'.

### Misunderstanding friction clusters around ambiguous terms

Define project-specific vocabulary in project instructions to prevent recurring misinterpretations.

9 of your friction events involved Claude misunderstanding requests -- 'add a note' vs memory entry, 'skill' vs built-in feature, which files get front matter. These aren't code bugs; they're terminology gaps. Your project has specific meanings for 'idea', 'skill', 'form', 'note', and 'principle' that differ from Claude's defaults. A glossary in the project instructions would eliminate most of these.

> **Paste into Claude Code:** Add a ## Glossary section to the project instructions with these definitions: 'idea' = a modeling file + skill file pair; 'skill' = a .claude/skills/ markdown file with front matter; 'form' = a modeling/ markdown file without front matter; 'note' = a structured artifact file in the notes directory; 'principle' = a governing rule document. Always use these definitions in this project.

### Zero commits across 36 sessions -- consider automating

You're doing significant multi-file refactoring but never committing from Claude sessions. A /commit skill or hook would create natural checkpoints.

With 414 edits and 59 writes across 36 sessions but 0 commits, you're likely committing separately or batching changes. Given that several sessions involve renaming directories and updating 28+ files at once, a single bad edit could cascade. A commit skill that summarizes changes in your preferred format would give you safe rollback points mid-session, which is especially valuable during your large sweeps.

> **Paste into Claude Code:** Create a skill at .claude/skills/commit/SKILL.md that: 1) runs git status to show all changes, 2) groups changes by type (renamed, modified, new), 3) generates a conventional commit message summarizing the changes, 4) shows me the message for approval before committing. Use positive framing in the commit message.

---

## On the Horizon

Your 36 sessions reveal a sophisticated documentation architecture practice that's ripe for autonomous agents to handle the repetitive auditing, syncing, and integrity work that currently dominates your workflow.

### Autonomous Cross-File Integrity Guardian Agent

Your most frequent work -- staleness audits, referential integrity checks, skill/form pair syncing, and stale reference sweeps -- consumed at least 12 of your 36 sessions. A persistent agent could continuously monitor all file pairs, detect drift the moment it occurs, and either auto-fix or queue structured reports. Imagine never manually auditing 14 idea pairs again because an agent watches every edit and enforces your conventions in real-time.

**Getting started:** Use Claude Code's Task tool to spawn parallel sub-agents: one for referential integrity, one for skill/form pair drift detection, and one for terminology compliance. Chain them into a single orchestration prompt that writes a structured report and applies safe fixes.

> **Paste into Claude Code:**
>
> Run a comprehensive project integrity audit using parallel sub-tasks:
>
> 1. REFERENTIAL INTEGRITY: Glob all .md files, extract every internal link and file reference, verify each target exists, and list all broken links with file:line locations.
>
> 2. SKILL/FORM PAIR SYNC: For every file in skills/ and its counterpart in modeling/, diff the semantic content (ignoring front matter). Flag any pair where the skill has drifted from its form source-of-truth. Categorize drift as: missing-content, added-content, or terminology-mismatch.
>
> 3. CONVENTION COMPLIANCE: Check all files for: (a) negative language patterns ('don't', 'avoid', 'never', 'lack') that should be reframed as positive presence statements, (b) bold formatting that violates editorial standards, (c) front matter present in form files where it shouldn't be.
>
> Write results to .phase0/audit-report.md with sections for each check, severity ratings, and concrete fix suggestions. Then apply all safe fixes (broken links, terminology) automatically and list what you changed.

### Test-Driven Documentation Contract Enforcement

Your contracts-based modeling architecture (structuring-todos, structuring-notes, preserving-discoveries) has clear invariants that could be expressed as executable tests. Instead of manually verifying separation of concerns after each refactor, an agent could run a validation suite that asserts routing logic stays out of structuring contracts, all principles have matching skills, and every agent definition resolves its file references. You'd refactor fearlessly knowing violations are caught instantly.

**Getting started:** Create a shell-based test harness that encodes your architectural rules as grep/glob assertions, then have Claude Code iterate against those tests -- fixing violations until all pass, exactly like TDD for code.

> **Paste into Claude Code:**
>
> Help me create an executable documentation architecture test suite:
>
> 1. Create tests/doc-architecture.sh with these test cases:
>    - Every file in skills/ has a corresponding file in modeling/ (and vice versa)
>    - No structuring-* contract file contains routing/dispatch logic keywords
>    - Every file referenced in project instructions actually exists
>    - Every agent definition in .claude/ resolves all its skill file paths
>    - No form file contains YAML front matter
>    - All .md files pass positive-language check (no 'don\'t', 'avoid', 'never', 'you lack' patterns)
>    - README.md links all resolve to existing files
>    - No duplicate content blocks exist across skill/form pairs (>80% similarity = flag)
>
> 2. Make each test output PASS/FAIL with file locations for failures.
>
> 3. Run the test suite, then iteratively fix every failure. After each fix, re-run to confirm the fix didn't break other tests. Continue until all tests pass.
>
> 4. Document the test suite in project instructions so future sessions can run it before any PR.

### Parallel Agents for Bulk Editorial Sweeps

Sessions like your 24-file positive-language sweep and 12-file editorial review took multiple passes and significant back-and-forth. With parallel Task agents, you could dispatch one agent per file (or file group), each applying your writing principles independently, then aggregate results -- turning a multi-hour editorial sweep into a single orchestrated command that finishes in minutes. Each sub-agent would carry your editorial standards as context and produce consistent results without the drift that accumulates over long sequential sessions.

**Getting started:** Leverage Claude Code's Task tool to fan out editorial work across parallel sub-agents, each scoped to a subset of files with your writing principles injected as instructions. Use a coordinator agent to merge results and verify consistency.

> **Paste into Claude Code:**
>
> Perform a parallelized editorial review and revision of all documentation files:
>
> First, read the writing principles from the principles/ directory and editorial standards to build a shared rubric.
>
> Then spawn parallel sub-tasks, one per directory (skills/, modeling/, principles/, vision/, agents/), each with these instructions:
> - Review every .md file in your assigned directory against the editorial rubric
> - Apply all fixes directly: positive-language reframing, consistent terminology, proper formatting, no redundant content
> - For each file, log what you changed and why in a structured format
> - If you encounter content that contradicts another directory's files, flag it but don't fix it
>
> After all sub-tasks complete:
> 1. Aggregate all change logs into .phase0/editorial-sweep-report.md
> 2. Review all cross-directory contradiction flags and resolve them
> 3. Run a final consistency check: grep for any remaining negative-language patterns, verify no editorial drift was introduced between related file pairs
> 4. Summarize total files reviewed, edits made, and any items needing human judgment

---

*"User spent an entire weekend building a philosophy of positive language -- then had to keep scolding Claude for being negative"*

Across a marathon 65-hour weekend, the user obsessively refined a 'define by presence, not absence' writing standard for their LLM-facing docs -- eliminating all negation patterns from 24+ files -- while simultaneously having to tell Claude off for using phrases like 'you lack' and for dropping important sections during merges. The AI kept failing the very editorial standard it was being asked to enforce.
