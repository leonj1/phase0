# Three ideas for a better system

## Context

Review of skills, descriptions, agents, and contracts — three concrete improvement proposals.

## Body

## 1. The project instructions got too thin — the facilitator lost its floor

Three commits ago, the project instructions loaded 7 contracts via @ references: modeling-foundation, contract, contract-structure, model-structure, durability, editorial. Then it was reduced to one: facilitator.

The theory is sound — skills bring in context on demand. But it creates a circular dependency: the facilitator needs the modeling vocabulary to recognize when to activate a skill, and the vocabulary lives inside the skill. A facilitator that doesn't know what a conditional goal is can't recognize that the user is describing one, so discovering-actors never fires.

The fix isn't reverting to the old approach. It's identifying the minimum grounding layer — the context the facilitator needs before any skill activates:

- modeling-foundation.md — vocabulary (goals, drives, tensions, events, contexts). Without this, the facilitator can't parse domain conversation.
- model-structure.md — where things go. Without this, the facilitator can't orient in the model or judge what artifacts exist.
- durability.md — preservation discipline. Without this, discoveries evaporate between skill activations.

Everything else (lens depth, forms, editorial standards) works through skills. These three are the floor.

## 2. 20 mechanical skills are 20 competing descriptions

The reading/writing skill pairs are structurally identical — YAML front matter + !cat pointing at a form. Their descriptions are nearly identical too: "Read and review X files. Check Y, understand Z" / "Create and structure X files. Write X, scaffold Y."

That's 20 descriptions in the system prompt that the model has to distinguish between. When the agent needs to write an actor file, it's choosing between writing-actors, writing-contexts, writing-events, writing-invariants, writing-usecases, writing-glossaries, writing-catalogs, writing-notes, writing-todos, writing-evaluations. Ten nearly identical triggers.

Collapse by lens scope — matching how agents actually use them:

- actor-lens-forms — loads actor + catalog forms. Script references for both.
- usecase-lens-forms — loads use case + event + invariant forms. Script references for all three.
- context-lens-forms — loads context + event + catalog forms. Script references.
- cross-cutting-forms — loads glossary + note + todo forms. Script references.

Four skills instead of twenty. Each agent loads the form skill for its lens plus cross-cutting. The descriptions are differentiated by lens, not by artifact type, so they don't compete.

The reading skills disappear entirely — forms are the same contract whether you're reading or writing. reading-usecases exists to inject the usecase form when reading. writing-usecases exists to inject the same form when writing. One skill does both.

## 3. Skill descriptions compete on topic instead of differentiating on trigger

Several descriptions overlap in vocabulary, which means the model can't reliably choose between them:

- grounding-models mentions "actors, goals, drives, tensions, conditional goals, invariants, domain events, use cases, bounded contexts"
- discovering-actors mentions "actors and their goals... conditional goals, value conditions, tensions"
- modeling-usecases mentions "invariants, goal obstacles... scenarios"

These share terms because the lenses share concepts. But shared terms mean shared activation triggers. When the user says "let's talk about the actor's goals," does grounding-models fire or discovering-actors? Both match.

Rewrite descriptions as activation conditions rather than topic inventories:

- grounding-models: "Establish shared modeling vocabulary at the start of a session or when a new domain is introduced. Foundation layer — loads before lens-specific skills."
- discovering-actors: "Deepen actor-lens work. Activate when exploring a specific actor's goal, challenging a derivation chain, or surfacing tensions. Requires grounding-models as foundation."
- modeling-usecases: "Deepen use-case-lens work. Activate when walking a scenario, identifying obstacles, or naming domain events within a use case session."

The pattern: each description says when it fires and what layer it sits on. The model treats descriptions as a classifier — give it decision boundaries, not overlapping feature lists.

## References


