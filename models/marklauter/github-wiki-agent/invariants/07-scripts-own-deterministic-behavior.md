# Scripts own deterministic behavior

## Statement

All deterministic operations — git clone, `gh` API calls, config I/O, filesystem manipulation — belong in `.scripts/`, not inlined in command prompts. The LLM's role is judgment: interviews, analysis, content authoring.

## Rationale

Scripts are testable, predictable, and immune to prompt drift. Separating deterministic execution from LLM judgment keeps each side doing what it does best and prevents regressions when prompts evolve.

## Scope

- use-cases/02-review-wiki-quality
- use-cases/03-revise-wiki
- use-cases/05-provision-workspace
- use-cases/06-decommission-workspace

## Origin

Established by use-cases/05-provision-workspace.

## Notes

- This invariant draws a clean boundary between what scripts handle (deterministic, repeatable) and what the LLM handles (judgment, creativity, conversation).
