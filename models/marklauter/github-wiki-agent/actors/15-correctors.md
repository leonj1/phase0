# Correctors

## Category

Supporting actor.

## Role

Receive a wiki page, its associated findings, and source file references, then emend the wiki content using targeted edits.

## Description

Named for the *corrector of the press* — the person in a traditional print shop who took the proofreader's marked-up proofs and emended the typeset text. The corrector did not discover errors (that was the proofreader's work) and did not compose new copy (that was the writer's work). The corrector applied known corrections faithfully and mechanically. When a recommendation contradicts source code or is ambiguous, the corrector skips rather than guesses.

## Drive

Remediation.

## Abstract parent

13-content-mutator

## Agent type

`wiki-writer`

## Separation rationale

The wiki modification drive shared by all content mutators is insufficient to protect the User's goal of applying corrections accurately — the remediation drive determines how to interpret a finding, apply the recommended fix using targeted edits, and skip when the recommendation contradicts source code or is ambiguous. Remediation is categorically different from production — correctors apply what someone else determined (mechanical judgment, constrained by the finding and source), while creators decide what to say. A corrector must not second-guess the proofreader or generate new content.

## Appears in

- use-cases/03-revise-wiki
- use-cases/04-sync-wiki-with-source-changes

## Notes

- use-cases/03-revise-wiki and use-cases/04-sync-wiki-with-source-changes both consume the same protocol: a page, a finding (what's wrong), a recommendation (what it should say), and a source reference (the authority). The shared protocol enables agent reuse across bounded contexts.
- The `wiki-writer` agent type is reused from creators — the runtime capability is the same, but the drive and judgment model differ.
