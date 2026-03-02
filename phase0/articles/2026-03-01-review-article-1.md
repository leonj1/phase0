# Review: Building an Agentic System to Design Agentic Systems

Reviewed against the Phase0 editorial standards contract and general quality for the target audience (architectural leads, CTOs, Substack readers clicking through from LinkedIn).

---

## Voice consistency

The article agreed on practitioner reflection voice — third-person analytical with first-person asides. The blend works in some places and drifts in others.

**Works well:**
- "When we mapped Phase0's architecture against Anthropic's taxonomy" (line 7) — natural practitioner voice
- "it was the advice we had to learn by violating it" (line 81) — honest, human

**Drifts:**
- "The Phase0 team spent more time on creation scripts" (line 89) — shifts to third person in a section that's otherwise first-person reflection. Either "we spent more time" or commit to third person for the whole section.
- "You write a little, you erase a little, you write again" (line 101) — shifts to second person for the whiteboard metaphor. This actually works as a rhetorical device, but it's the only second-person moment in the piece. Decide whether it's a deliberate shift or an accident.

**Recommendation:** Commit to "we" in the reflection sections (The hardest advice, Writing on the whiteboard) and third-person for the analytical sections (Three patterns, The pattern we left out). Make the boundary deliberate, not accidental.

---

## Tone

The tone is largely right — authoritative, declarative, confident. A few spots hedge when they should assert.

- Line 5: "It is, in a literal sense, an agentic system that designs agentic systems." The phrase "in a literal sense" is a hedge. Either it is or it isn't. Cut to: "It is an agentic system that designs agentic systems."
- Line 3: "hard-won guidance" — slightly informal. Acceptable for practitioner reflection but borderline. Consider "practical guidance."

---

## Structure and scannability

**Strong:**
- "Everyone is building agents. Few are modeling what those agents should do first." (line 13) — punchy opening for the problem section. CTO attention-grabber.
- "This is not a suggestion. It is an invariant enforced by the facilitator." (line 51) — authoritative, declarative. Exactly right.
- "collapsed two distinct skills into one agent. The result was an agent that did neither well." (line 85) — clean, decisive.

**Needs attention:**
- Lines 42-45: The routing section has a dense paragraph listing the three specialist agents and their input contracts. This is the right information but it reads as a wall. Consider a short list:

  > - The actor discovery agent receives a domain context and an area of focus.
  > - The use case designer receives a primary actor and their conditional goal.
  > - The context mapping agent receives an observed contradiction or area of partition.

  The list form makes the pattern visible — each specialist has a different classification criterion.

- Lines 89-91: The paragraph beginning "Anthropic's article makes this point through a different lens" covers three ideas: tool design, poka-yoke scripts, and the contract injection mechanism. These deserve to breathe. Break into two paragraphs at "The same principle extends to what Anthropic calls the agent-computer interface."

---

## Substack-specific concerns

- **No subtitle.** Substack articles benefit from a tagline visible in the preview card and email subject. Something like: "How Anthropic's agent architecture patterns compose in a real domain discovery tool."
- **No link to Article 2.** The closing says "A companion case study explores the contract system..." but does not include a URL. When Article 2 is published, this becomes a dead reference.
- **The two-article relationship is invisible until the final line.** Consider a one-line note after the opening section — something like "This is the first of two articles. The companion case study examines the architecture in detail." — so LinkedIn clickers know there's depth available.

---

## Repetition across articles

Several concepts and phrases appear in both Article 1 and Article 2. Since Article 1 links forward to the case study, readers arriving at Article 2 will have fresh memory of Article 1. Three areas overlap:

1. **The Anthropic "tools over prompts" quote** — "more time optimizing our tools than the overall prompt" appears in both articles. Use it in Article 1 (the reflection piece, where it lands as a lesson learned). Article 2 should paraphrase or reference without re-quoting.

2. **"Classifies conversation state rather than discrete inputs"** — this exact observation appears in both articles describing the routing pattern. Article 2 should rephrase or extend rather than repeat.

3. **The poka-yoke / creation scripts explanation** — Article 1 introduces creation scripts in "The hardest advice." Article 2 introduces them in "Creation scripts as poka-yoke" and then re-explains them in "Tool design and the agent-computer interface." That's three treatments. Article 1 should introduce the concept. Article 2's "Creation scripts" section should be the definitive treatment. Article 2's "Tool design" section should reference it and move on to the other ACI examples (contract injection, directory structure) without restating the scripts.

---

## Factual and editorial specifics

- Line 27: "the thing running when a user opens a terminal and starts talking" — this is informal. It works for the practitioner voice but might read as imprecise to the CTO audience. Consider: "the conversation that begins when a user starts a Claude Code session."
- Line 97: "what Phase0 calls durability" — Phase0 calls it "durable capture" in the contract. Minor, but consistency with the actual system is worth maintaining, especially since Article 2 names the skill (`preserving-discoveries`).
- Line 103: "writing as you go is not a stylistic preference. It is an architectural necessity." — strong closing line for the section. Keep.
- Line 113: "Anthropic's article closes with a principle that Phase0 embodies" — verify that this is actually the closing principle. It is from the conclusion section of the Anthropic article, so this is accurate.

---

## Summary

The article's narrative arc works: hook, insight, patterns, exclusion, hard lesson, close. The voice needs a deliberate consistency pass — commit to the blend rather than letting it drift. The dense paragraphs in the routing and ACI sections need to be broken up for scannability. Add a subtitle, link to Article 2, and hint at the two-article structure earlier. De-duplicate the concepts that also appear in Article 2.

Estimated revision effort: light. The content is sound. The fixes are structural and editorial, not conceptual.
