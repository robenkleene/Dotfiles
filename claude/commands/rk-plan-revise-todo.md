---
description: Review and improve the todo list by asking clarifying questions
---

Review the todo list and suggest improvements.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the project goals, constraints, and scope
2. Read `PLAN_DIR/TODO.md` to understand the current task status
3. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
4. Use AskUserQuestion to clarify ambiguities or missing details, such as:
   - Tasks that seem missing
   - Tasks that are too large and should be broken down
   - Tasks that are out of order relative to dependencies
   - Tasks that don't align with the spec
5. Based on the answers, suggest improvements to the todo list
6. After confirming with the user, update `PLAN_DIR/TODO.md` with the improvements
