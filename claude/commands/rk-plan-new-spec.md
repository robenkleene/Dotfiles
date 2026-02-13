---
description: Scaffold a new spec by asking clarifying questions about the project
---

Scaffold a new project spec.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Create `PLAN_DIR` if it doesn't already exist
2. Use AskUserQuestion to understand the project by asking about:
   - What problem is being solved or what feature is being added
   - Key constraints or requirements
   - Scope boundaries (what's in and out of scope)
   - Any known technical approach or preferences
3. Based on the answers, draft a spec and present it to the user for review
4. After user approval, write the spec to `PLAN_DIR/SPEC.md`
