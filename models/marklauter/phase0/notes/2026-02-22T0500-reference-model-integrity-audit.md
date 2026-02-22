# Reference model integrity audit findings

## Context

Ran a full referential integrity audit of the github-wiki-agent reference model — all 53 artifact files, 5 index files, and the glossary cross-checked. One factual error was fixed immediately. The remaining findings are being preserved here as exercise material for the governance skills.

## Body

The audit checked dangling references, index coverage, bidirectional consistency, context mapping, invariant scoping, event flow, scenario actor declarations, and naming consistency. No dangling references or index gaps were found. The remaining findings fall into five categories:

**Bidirectional reference mismatches (3 findings)**

- events/01-wiki-populated and events/06-workspace-provisioned list contexts as consumers, but those context files explicitly deny consuming events. The contexts express the dependency as integration points, not event consumption. One representation or the other needs to yield.
- use-cases/index assigns UC-07 to contexts/05-workspace-lifecycle, but the context file does not list UC-07. UC-07 is out of scope, so the asymmetry may be intentional — but the one-directional claim is inconsistent.

**Undeclared scenario actor (2 findings)**

- UC-05 and UC-06 reference "System" as the acting entity in scenario steps, but "System" is not declared in the actors directory. UC-05's actor responsibilities section says "No agents are involved," yet System performs most steps. Either System needs to be modeled or the scenario convention for non-agent use cases needs to be established.

**Invariant scope asymmetries (5 findings)**

- invariants/02-github-cli-installed claims governance over UC-01 and UC-04. UC-01 never references it. UC-04 explicitly avoids GitHub interaction.
- UC-02 references invariants/09-no-cli-style-flags in its notes, but the invariant's scope excludes UC-02.
- Three invariants (01, 04, 08) say "Governs: all use cases" in the index but list only UC-01 through UC-06 in their individual files.
- Four invariants (01, 02, 04, 05) are never referenced by identifier in any use case. Governance is one-directional.

**Semantic tensions (2 findings)**

- The glossary says sub-systems are "not an actor," but actors/16-github and actors/17-git live in the actors directory with actor-style numbering. The index uses a separate "Sub-systems" heading, but placement contradicts the glossary's categorical exclusion.
- contexts/01-wiki-creation references the abstract parent actors/02-orchestrator instead of the concrete child actors/03-commissioning-orchestrator. Every use case references the concrete child — this is the only place using the abstract parent for context-specific behavior.

**Minor (2 findings)**

- events/07-workspace-decommissioned references "06-workspace-provisioned" without the events/ namespace prefix.
- The three abstract actor parents (02, 08, 13) lack "Appears in" annotations in the index, though their individual files have them.

## References

- cross-cutting (referential integrity across all artifact types in the reference model)
- cross-cutting (governance skill exercise material)
