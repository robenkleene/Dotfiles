---
description: Write or revise all plan files
---

Write or revise all project plan files.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. If `PLAN_DIR/SPEC.md` exists, read it to understand the project goals, constraints, and scope
2. If `PLAN_DIR/TODO.md` exists, read it to understand the current task status
3. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
4. If `PLAN_DIR/DECISIONS.md` exists, read it to understand past decisions and their rationale
5. If `PLAN_DIR/LOGS.md` exists, read it to review saved log output
6. If the prior conversation already contains discussion about the project, use that context. Use AskUserQuestion only for gaps not covered by the conversation. Otherwise, use AskUserQuestion to clarify ambiguities or missing details, such as:
   - Unclear requirements
   - Missing acceptance criteria
   - Ambiguous scope
   - Undefined edge cases
   - Tasks that seem missing from the todo list
   - Tasks that are too large and should be broken down
   - Tasks that don't align with the spec
7. Based on the answers, suggest improvements to the plan files
8. After confirming with the user, update the plan files with the improvements
