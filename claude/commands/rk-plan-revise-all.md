---
description: Review and improve all plan files by asking clarifying questions
---

Review all project plan files and suggest improvements.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the project goals, constraints, and scope
2. Read `PLAN_DIR/TODO.md` to understand the current task status
3. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
4. If `PLAN_DIR/DECISIONS.md` exists, read it to understand past decisions and their rationale
5. If `PLAN_DIR/LOGS.md` exists, read it to review saved log output
6. Use AskUserQuestion to clarify ambiguities or missing details, such as:
   - Unclear requirements
   - Missing acceptance criteria
   - Ambiguous scope
   - Undefined edge cases
   - Tasks that seem missing from the todo list
   - Tasks that are too large and should be broken down
   - Tasks that don't align with the spec
7. Based on the answers, suggest improvements to the spec and todo list
8. After confirming with the user, update the plan files with the improvements
