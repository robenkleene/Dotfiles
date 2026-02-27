---
description: Write or revise the project spec
---

Write or revise the project spec.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Create `PLAN_DIR` if it doesn't already exist
2. If `PLAN_DIR/SPEC.md` exists, read it to understand the current spec
3. If the prior conversation already contains discussion about the project, use that context. Use AskUserQuestion only for gaps not covered by the conversation. Otherwise, use AskUserQuestion to gather information about the project: the problem being solved, key constraints, scope boundaries, technical preferences, and any unclear requirements or edge cases
4. Based on the answers, draft or update the spec and present it to the user for review
5. After user approval, write the spec to `PLAN_DIR/SPEC.md`
