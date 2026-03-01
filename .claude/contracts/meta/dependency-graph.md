# Dependency graph

The full dependency graph of the Phase0 instruction set — from the /design command through contracts, skills, and agents. Expressed as grouped adjacency lists: each node appears once with all its connections, organized by layer. Each agent's skill list determines which contracts get injected at activation time.

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

Each authoring-{type} skill loads forms/{type}.md via inclusion, plus reading guidance and creation script. Injected into agents that read or produce artifacts.

authoring-actors, authoring-catalogs, authoring-contexts,
authoring-evaluations, authoring-events, authoring-glossaries,
authoring-invariants, authoring-notes, authoring-todos, authoring-usecases

## Agents — discovery (3)

Socratic session agents. All three share a common core (grounding-models, navigating-models, preserving-discoveries, enforcing-style, and authoring skills for catalogs, events, invariants, notes, and todos) plus their own lens skill and 2-3 additional authoring skills.

discovering-actors
  includes: discovering-actors, grounding-models, navigating-models,
            preserving-discoveries, enforcing-style,
            authoring-actors, authoring-catalogs, authoring-contexts,
            authoring-events, authoring-invariants, authoring-notes,
            authoring-todos

designing-usecases
  includes: modeling-usecases, grounding-models, navigating-models,
            preserving-discoveries, enforcing-style,
            authoring-actors, authoring-catalogs, authoring-usecases,
            authoring-events, authoring-invariants, authoring-notes,
            authoring-todos

mapping-contexts
  includes: mapping-contexts, grounding-models, navigating-models,
            preserving-discoveries, enforcing-style,
            authoring-catalogs, authoring-contexts, authoring-events,
            authoring-glossaries, authoring-invariants, authoring-notes,
            authoring-todos

## Agents — evaluation (4)

Read-only verification agents. Coherence, references, and structure share a common core (evaluating-artifacts, navigating-models, authoring-evaluations, and authoring skills for all artifact types). Coherence and references add grounding-models. Style is narrower — just evaluating-artifacts, enforcing-style, and authoring skills for evaluations, glossaries, and actors.

evaluating-coherence
  includes: evaluating-artifacts, grounding-models, navigating-models,
            authoring-evaluations, authoring-actors, authoring-catalogs,
            authoring-contexts, authoring-events, authoring-glossaries,
            authoring-invariants, authoring-notes, authoring-todos,
            authoring-usecases

evaluating-references
  includes: evaluating-artifacts, grounding-models, navigating-models,
            authoring-evaluations, authoring-actors, authoring-catalogs,
            authoring-contexts, authoring-events, authoring-glossaries,
            authoring-invariants, authoring-notes, authoring-todos,
            authoring-usecases

evaluating-structure
  includes: evaluating-artifacts, navigating-models,
            authoring-evaluations, authoring-actors, authoring-catalogs,
            authoring-contexts, authoring-events, authoring-glossaries,
            authoring-invariants, authoring-notes, authoring-todos,
            authoring-usecases

evaluating-style
  includes: evaluating-artifacts, enforcing-style,
            authoring-evaluations, authoring-glossaries, authoring-actors
