---
name: authoring-skills
user-invokable: true
disable-model-invocation: false
description: Loads Anthropic's official skill authoring best practices before writing or modifying any SKILL.md file. Activates when creating, editing, renaming, or restructuring skills. Triggers on "create a skill", "new skill", "modify the skill", "rename skill", "update SKILL.md", or any task that touches .claude/skills/*/SKILL.md.
---

Use WebFetch to read this URL before any skill authoring work:

`https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices.md`

Apply every guideline from that page. Do not skip the fetch.
