# Documentation review

Review of all files in `phase0/` against the writing principles in `.claude/modeling/principles/writing-documentation.md`. Reviewed 2026-02-21.

## Writing principles under review

1. Lead with what the reader needs, not background
2. Second person ("you") — direct, conversational, professional
3. Present tense
4. Short sentences, short paragraphs — scannable
5. Sentence-case headings
6. Numbered steps for tasks, bullets for options
7. Self-contained pages with links to supporting concepts
8. Define by presence — positive assertions; reserve negations for governance

---

## Summary

- **manifesto.md** — vision article — compliant
- **conditional-goals.md** — vision article — compliant
- **design-cycle.md** — vision article — compliant
- **agentic-architecture.md** — vision article — needs revision (heading negation, missing second person)
- **goal-directed-scenarios.md** — vision article — needs revision (contrast framing leans on negation)
- **socratic-method.md** — vision article — needs revision (heading negation)
- **historian.md** — vision article — needs revision (section defined by absence)
- **elevator-case-study.md** — case study — needs revision (negations in intro and common-mistakes section)
- **README.md** — navigation — compliant
- **VISION.md** — living document — noted (Title Case headings, tables, mixed voice)
- **design-conversations.md** — context dump — preserve as seed material
- **UC-AGENT-REVIEW.md** — context dump — preserve as seed material

---

## Vision articles

### manifesto.md — compliant

Sentence-case headings throughout. Present tense. Short sentences. Self-contained with further reading links. Opens with what Phase0 is and what it produces.

Minor observation: the article uses third-person declarative voice rather than second person. This works for a manifesto — it reads as authoritative statement rather than instruction. No revision needed.

### conditional-goals.md — compliant

Strong compliance across all principles. Uses "you" naturally ("you start from first principles," "if someone gifts you the guitar"). Sentence-case headings. Present tense. Each section is self-contained. The gift test section is a model of scannable writing.

The genealogy test section uses negations ("if you cannot answer that question, the actor should not exist") but these function as governance — a validation rule the reader applies. Appropriate.

### design-cycle.md — compliant

Sentence-case headings. Present tense. Numbered steps for the actor lens phases. Bullets for feedback loop examples. Self-contained with links. The "Open" notes on undeveloped lenses are honest gaps, not negations.

### agentic-architecture.md — needs revision

**Heading negation.** "The lenses (not a pipeline)" defines the concept by what it is not. Consider: "The lenses (a complete graph)" or simply "The lenses."

**Second person.** The article rarely addresses the reader directly. Most sentences use third person ("the facilitator shifts," "the specialist agents are formalizers"). Adding occasional "you" would match the conversational tone of the stronger articles.

**Positive framing opportunity.** Line 67: "This multidirectional flow is why a pipeline architecture would fail" — could become "This multidirectional flow is why the architecture is a graph." The positive assertion is stronger.

Everything else complies: sentence-case headings, present tense, short sentences, self-contained with links, no tables.

### goal-directed-scenarios.md — needs revision

**Contrast framing.** The article's structure is "traditional approach does X, Phase0 does Y." This is effective pedagogy but produces negations that could be reframed.

- Line 9-10: "Traditional use cases have preconditions and postconditions... This is insufficient." The insufficiency claim is the point, but leading with the Phase0 concept and then noting the contrast would be stronger.
- Line 27: "This is not a UX trick." Unnecessary negation — the paragraph already explains what it *is* (a consequence of designing from goals). Removing the sentence loses nothing.

**Heading negation.** "Obstacles are threats to the goal, not alternate paths" — the positive half ("threats to the goal") stands on its own.

The article is short, well-structured, and scannable. The revisions are minor reframings, not structural changes.

### socratic-method.md — needs revision

**Heading negation.** "Why extraction, not declaration" defines the concept partly by what it rejects. Consider: "Why extraction works" (which is already the next heading's phrasing — the two sections could merge).

**Negation in technique description.** Line 27: "The facilitator does not project their model onto the domain." This is a governance-style assertion in a vision article. The positive version is already present: "They keep asking why until the domain's own structure emerges." The negation is redundant.

Everything else complies well. The three technique sections (why-chain, noun refinement, contradictions as gold) are models of clear, scannable writing.

### historian.md — needs revision

**Section defined by absence.** The heading "The historian is not the facilitator" (line 69) and its body define the historian through four consecutive negations: "does not route conversations," "does not invoke specialists," "does not ask questions," "does not make design decisions." The positive assertion follows ("it listens and writes") but arrives late.

Consider reframing the section as "What the historian does" — leading with "The historian listens and writes" and letting that assertion stand. The boundary with the facilitator is already clear from the preceding sections.

**Architecture box negation.** The "Never: asks questions, makes design decisions" line in the architecture diagram (line 59) is governance language in a vision article. The "Watches" and "Writes" lines already define the role by presence.

The rest of the article is strong. The four categories of significance (decisions, contradictions, new terms, deferrals) are well-structured. The five examples distinguishing historian output from specialist output are excellent.

---

## Case study

### elevator-case-study.md — needs revision

**Introductory negation.** Line 5: "This is not a use case specification. There are no scenarios or step-by-step flows here." Defining the article by what it is not. The next sentence ("This is an actor model") is the positive assertion and stands alone.

**Common mistakes section (line 394).** This section is inherently negative — it names errors and explains why they are wrong. The content is valuable for teaching but belongs to governance or a proofreader's checklist, not a vision article. Options:

- Move it to a separate governance document that a proofreader loads
- Reframe as "Actor-hood tests" — positive assertions about what qualifies as an actor, with the mistakes becoming test applications

**Occasional negations in actor descriptions.** Some actor entries use "does not" to sharpen boundaries: "The State does not ride the elevator," "The Emergency Dispatcher does not fix the elevator." These are brief and serve clarity. They are minor compared to the structural issues above.

**Length.** At 507 lines, this is the longest document by a wide margin. It is comprehensive and well-organized, but a reader scanning the table of contents sees 15+ actor categories before reaching the genealogy test and discovery path. The discovery path section (line 408-500) is particularly valuable — it teaches the *process*, not just the result. Consider whether it deserves its own article.

Everything else complies: sentence-case headings, present tense, no tables, self-contained, prose over tables throughout.

---

## Navigation documents

### README.md — compliant

Clean navigation structure. Sentence-case headings. Bullets for links. Opens with what Phase0 is. Links to all vision articles with one-line descriptions. No issues.

---

## Living document

### VISION.md — noted (lighter review)

This is the original source from which the vision articles were refined. It remains as a verification reference. Findings are noted for awareness, not as revision targets.

**Title Case headings.** "What Phase0 Produces," "Why Phase0 Exists," "The Natural Group Process," "The Agentic Architecture," "The Entry Point: Actors and Goals, From First Principles," "Conditional Goals: The Foundational Concept," "Why Socratic Extraction Works," "Who Holds the Threads?" — all use Title Case. The vision articles extracted from this document already use sentence case.

**Tables.** The elevator derivation table (line 153) and the historian comparison table (line 252) use table format. The vision articles that cover this content have already replaced them with prose and bullets.

**Mixed voice.** Alternates between second person ("you ask domain experts"), third person ("the facilitator asks"), and informal direct address. The extracted articles each settled on a consistent voice.

**Contractions.** Uses contractions throughout ("doesn't," "don't," "won't"). The extracted articles use uncontracted forms.

**Negations.** Frequent negations in the source material were already cleaned up during extraction into individual articles. The remaining negations in VISION.md are part of the historical record.

No revision recommended. The extracted articles are the polished expression of this material.

---

## Context dumps — preserve as seed material

### meta/design-conversations.md

A design decision record from the UC-01/02/03 sessions. Captures the elevator conversation that produced the drive concept, the actor separation principle, and the application to the wiki system. Also records minor unwritten nuances (per-section audience values, GitHub as subsystem, milestone vs. domain event, editorial lens terminology).

**Value for future work:** High. The drive discovery narrative (lines 42-68) is the origin story for a core modeling concept. The minor nuances section contains decisions that may need to be formalized as the system matures.

**Compliance assessment:** Not applicable — this is a session record, not a published article. Applying vision-article standards would destroy the conversational context that gives it value.

**Recommendation:** Preserve as-is. When any of these decisions need to be expressed as published prose, use this document as source material and apply writing principles during extraction.

### meta/UC-AGENT-REVIEW.md

A post-mortem assessment of the use-case-designer agent. Evaluates strengths, identifies structural weaknesses, proposes improvements. Written in a review voice with "Preserve" and "Remediation" directives.

**Value for future work:** High. The six structural weaknesses and four improvement proposals are actionable inputs for agent redesign. The "What is not a weakness" section (line 130) documents design choices that were deliberately preserved — this prevents future reviewers from re-raising settled questions.

**Compliance assessment:** Not applicable — this is an assessment document, not a vision article. The review format (strengths, weaknesses, improvements, verdict) is appropriate for its purpose. Negative assertions are expected in a review.

**Recommendation:** Preserve as-is. The improvement proposals feed directly into agent development work. The strengths section identifies patterns worth preserving as the agent evolves.
