---
description: Review and improve plan files by asking clarifying questions
---

Review a project plan and suggest improvements.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the project goals, constraints, and scope
2. Read `PLAN_DIR/TODO.md` to understand the current task status
3. Use AskUserQuestion to clarify ambiguities or missing details, such as:
   - Unclear requirements
   - Missing acceptance criteria
   - Ambiguous scope
   - Undefined edge cases
   - Tasks that seem missing from the TODO list
4. Based on the answers, suggest improvements to the spec and TODO list
5. After confirming with the user, update the plan files with the improvements
