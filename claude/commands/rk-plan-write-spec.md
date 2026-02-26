---
description: Write or revise the project spec
---

Write or revise the project spec.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Create `PLAN_DIR` if it doesn't already exist
2. If `PLAN_DIR/SPEC.md` exists, read it to understand the current spec
3. Use AskUserQuestion to gather information:
   - If writing a new spec: ask about the problem being solved, key constraints, scope boundaries, and technical preferences
   - If revising: ask about unclear requirements, missing acceptance criteria, ambiguous scope, and undefined edge cases
4. Based on the answers, draft or update the spec and present it to the user for review
5. After user approval, write the spec to `PLAN_DIR/SPEC.md`
