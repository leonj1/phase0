---
name: testing-content-injection
description: This skill should be used when the user asks to "test content injection" or "verify skill injection". Tests that the !`command` dynamic injection syntax works inside skill files.
---

## Injected content

!`cat .claude/skills/testing-content-injection/test-payload.md`

## Verification

If you can see "INJECTION_SUCCESS: Hello, world!" above, report that injection worked. If you see the literal `!`cat ...`` text instead, report that injection failed.
