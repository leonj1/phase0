# Alignment orchestrator

## Category

Supporting actor.

## Role

Coordinates the wiki sync workflow — from source change detection through fact-checking to correction and sync reporting.

## Description

Named for the *revisions editor* in reference publishing — the person who manages the process of updating existing content to reflect new information across editions. The alignment orchestrator identifies recent source code changes as priority context, dispatches fact-checkers across all content pages, collects assessments, dispatches correctors for pages with drift, and compiles the durable sync report.

## Drive

Alignment.

## Abstract parent

02-orchestrator

## Separation rationale

The coordination drive shared by all orchestrators is insufficient to protect the User's goal of keeping wiki claims aligned with source code — the alignment drive determines how to prioritize recent source changes, dispatch fact-checkers, assess drift, and compile a sync report. This change-detection-to-correction pipeline is unique to the sync workflow.

## Appears in

- use-cases/04-sync-wiki-with-source-changes

## Notes

- The alignment orchestrator is the only orchestrator that dispatches fact-checkers.
- Post-hoc approval via git diff/revert gives the User a review gate after autonomous corrections.
