# Dependency graph

The full dependency graph of the Phase0 instruction set — from the /design command through contracts, skills, and agents. Expressed as grouped adjacency lists: each node appears once with all its connections, organized by layer. Shared dependencies are factored out to avoid repetition; per-node entries list only the delta.

## Edge types

- **includes** — the node loads or incorporates the target at activation time.
- **references** — implicit or conditional dependency (not always loaded).

## Entry point

/design command
  includes: principles/roles/facilitator.md, principles/best-practices/facilitation.md
  references: principles/roles/onboarding.md, principles/modeling-foundation.md

## Contracts — meta (3)

Self-description: what contracts are, instruction set layout, model output layout.

contract.md
  references: contract-structure.md
contract-structure.md
  references: model-structure.md
model-structure.md

## Contracts — principles (10)

Bind how agents think: facilitator role, three lenses, evaluation stance, editorial voice, durable capture, modeling vocabulary.

roles/facilitator.md
roles/onboarding.md
modeling-foundation.md
  references: lenses/actor.md, lenses/usecase.md, lenses/context.md
best-practices/evaluation.md
best-practices/editorial.md
best-practices/facilitation.md
lenses/actor.md
lenses/usecase.md
lenses/context.md
best-practices/durability.md

## Contracts — forms (10)

Bind what agents produce: one form per artifact type.

actor.md, catalog.md, context.md, evaluation.md, event.md,
glossary.md, invariant.md, note.md, todo.md, usecase.md

## Skills — behavioral (8)

Each includes one principle contract. Injected into agents to shape reasoning.

grounding-models       includes: principles/modeling-foundation.md
discovering-actors     includes: principles/lenses/actor.md
modeling-usecases      includes: principles/lenses/usecase.md
mapping-contexts       includes: principles/lenses/context.md
evaluating-artifacts   includes: principles/best-practices/evaluation.md
enforcing-style        includes: principles/best-practices/editorial.md
preserving-discoveries includes: principles/best-practices/durability.md
navigating-models      includes: meta/model-structure.md

## Skills — standalone (4)

User-invocable skills that load contracts directly. Not included in any agent.

facilitating-discovery             includes: principles/best-practices/facilitation.md
getting-started                    includes: principles/roles/onboarding.md
understanding-contracts            includes: meta/contract.md
understanding-contract-structure   includes: meta/contract-structure.md

## Skills — authoring (10)

Each authoring-{type} skill loads forms/{type}.md via inclusion, plus reading guidance and creation script.

authoring-actors, authoring-catalogs, authoring-contexts,
authoring-evaluations, authoring-events, authoring-glossaries,
authoring-invariants, authoring-notes, authoring-todos, authoring-usecases

## Agents — discovery (3)

Socratic session agents. Each includes its own lens skill plus a shared core of behavioral and authoring skills.

Shared across all three:
  behavioral: grounding-models, navigating-models, preserving-discoveries, enforcing-style
  authoring:  authoring-catalogs, authoring-events, authoring-invariants,
              authoring-notes, authoring-todos

discovering-actors
  lens: discovering-actors
  also: authoring-actors, authoring-contexts

designing-usecases
  lens: modeling-usecases
  also: authoring-actors, authoring-usecases

mapping-contexts
  lens: mapping-contexts
  also: authoring-contexts, authoring-glossaries

## Agents — evaluation (4)

Read-only verification agents. Each produces findings via authoring-evaluations.

Shared across coherence, references, and structure:
  behavioral: evaluating-artifacts, navigating-models
  authoring:  authoring-evaluations, authoring-actors, authoring-catalogs,
              authoring-contexts, authoring-events, authoring-glossaries,
              authoring-invariants, authoring-notes, authoring-todos,
              authoring-usecases

evaluating-coherence
  also: grounding-models

evaluating-references
  also: grounding-models

evaluating-structure
  (shared set only)

evaluating-style
  behavioral: evaluating-artifacts, enforcing-style
  authoring:  authoring-evaluations, authoring-glossaries, authoring-actors

## Layer summary

| Layer | Count | Role |
|---|---|---|
| /design command | 1 | Entry point. Loads facilitator and facilitation contracts via inclusion, conditionally reads onboarding and modeling-foundation. |
| Contracts — meta | 3 | Self-description: what contracts are, instruction set layout, model output layout. |
| Contracts — principles | 10 | Bind how agents think: facilitator role, three lenses, evaluation stance, editorial voice, durable capture, modeling vocabulary. |
| Contracts — forms | 10 | Bind what agents produce: one form per artifact type. |
| Skills — behavioral | 8 | Each loads one principle contract via inclusion. Injected into agents to shape reasoning. |
| Skills — standalone | 4 | User-invocable skills that load contracts directly. Not included in any agent. |
| Skills — authoring | 10 | Each loads one form contract via inclusion plus reading guidance and creation script. Injected into agents that read or produce artifacts. |
| Agents — discovery | 3 | Socratic session agents: one per lens (actor, use case, context). Each agent's skill list determines which contracts get injected. |
| Agents — evaluation | 4 | Read-only verification: structure, references, coherence, style. Each produces a findings report. |
