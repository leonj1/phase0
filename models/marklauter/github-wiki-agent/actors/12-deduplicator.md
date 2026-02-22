# Deduplicator

## Category

Supporting actor.

## Role

Compares findings against existing open GitHub issues to prevent duplicate issue filing without suppressing legitimate findings.

## Description

The deduplicator compares proofreader findings against existing open GitHub issues labeled `documentation`. It prevents duplicate issues without suppressing legitimate findings. Only drops a finding when it clearly matches an existing open issue about the same problem. A finding about a different section of the same page is not a duplicate.

## Drive

Filtering.

## Abstract parent

08-assessor

## Separation rationale

The read-only judgment drive shared by all assessors is insufficient to protect the User's goal of actionable issue filing — the filtering drive determines how to match new findings against existing issues, distinguish true duplicates from distinct problems on the same page, and preserve legitimate findings that happen to be near existing issues. Without filtering, the system would flood the issue tracker with duplicates, undermining the User's experience goal of actionable summaries.

## Appears in

- use-cases/02-review-wiki-quality

## Notes

- The deduplicator operates after proofreaders and before issue filing — it sits at the boundary between assessment and action.
- A finding about a different section of the same page is not a duplicate — the matching criterion is the *problem*, not the *page*.
