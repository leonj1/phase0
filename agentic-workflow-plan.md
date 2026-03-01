# Agentic Workflow Plan: Autonomous Coding with Claude

## Context

A software development team managing ~30 projects across two domains:
- **Email and M2M messaging**
- **Software security** (identity server/token server, policy server — PAP, PEP, PDP, etc.)

Goal: eliminate humans from feature coding, bug fixing, and refactoring. Replace with Claude-based agentic workflows.

### Stack
- .NET, TypeScript, React, Terraform
- Mostly one domain concept per repo, independently deployed
- Some well-designed library repos (1–5 cohesive NuGet packages)
- Some ASP.NET web projects with a couple of libraries each
- Some domain concepts span repos

### Current workflow
- Work items in Jira; GitLab issues as message queue for agentic work (avoids polluting backlogs)
- PRs get automated tests, security checks, lint, AI code review, and human review
- Review is ~30% mechanical, ~70% judgment — goal is to flip those values with architectural tests, better linting, and better testing

### Target
- Fully autonomous: issue posted → agent triggered → code created, reviewed, refined, tested → PR
- Bug fixes first, then features. Refactoring deferred.

---

## The core constraint

Test coverage is the gating function. An autonomous agent that can't verify its own work is just generating PRs for humans to debug. The repos naturally tier themselves:

- **Tier A** — 90% coverage, good tests. Agent-ready today for bug fixes.
- **Tier B** — 50% coverage, weak tests. Need test investment before agents can work reliably.
- **Tier C** — zero tests. Off-limits until tests exist.

The "flip 70/30 to 30/70" goal isn't just nice-to-have — it's a prerequisite for autonomy. Every judgment call encoded as a linting rule, architectural test, or convention check is one less reason a human needs to look at a PR.

---

## Proposed phases

### Phase 0: Make repos agent-ready

Foundation work that makes everything else possible.

1. **Add a `CLAUDE.md` to each repo.** Claude Code's convention file — architecture decisions, naming patterns, key abstractions, "don't touch" zones, how to run tests, how to build. Onboarding docs for an agent instead of a human.

2. **Add architectural tests** to the Tier A repos. For .NET, something like NetArchTest or ArchUnitNET — enforce layer boundaries, dependency rules, naming conventions. These turn judgment calls into mechanical checks.

3. **Strengthen linting.** Every style/convention argument that happens in PR review should become a rule instead.

4. **Backfill tests on Tier B repos.** Claude is excellent at writing tests for existing code. This could be the first agentic workflow — issue says "increase coverage on ProjectX," agent writes tests, human reviews.

### Phase 1: Bug fixes on Tier A repos

The pipeline:

```
GitLab issue created (labeled "agent-work")
  → webhook triggers CI job
    → Claude Code CLI checks out repo, reads CLAUDE.md
      → reads issue, reproduces bug, writes fix + test
        → runs full test suite
          → opens MR with explanation
            → CI runs (lint, test, security, AI review)
              → human approves or requests changes
```

Start with human approval on every MR. Track the approval rate. When it hits 95%+ on a repo, consider removing the human gate for low-risk changes.

### Phase 2: Expand to Tier B as coverage improves

As test backfill lands, repos graduate from B to A and become eligible for autonomous bug fixes.

### Phase 3: Feature work

Features require more context — user intent, design decisions, interaction with other services. This is where the `CLAUDE.md` files and architectural tests really pay off. Richer issue templates will give the agent enough context to make good decisions.

---

## Open questions

1. **GitLab CI as the orchestrator** — SaaS or self-managed? Affects webhook/trigger options.

2. **Claude Code CLI vs. Claude API** — Claude Code CLI is the fastest path (already knows how to navigate repos, run tests, make changes, runs headless in CI). The alternative is building a custom agent with the Claude Agent SDK (more control, more work).

3. **Cross-repo domain concepts** — start by scoping agents to single-repo issues only, flag cross-repo issues for humans?

4. **The test-writing bootstrap** — start there? Using Claude to backfill tests on Tier B repos could be the first win and simultaneously unblock future autonomy.
