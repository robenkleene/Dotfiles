---
description: Write or revise a task todo list
---

Write or revise a task todo list.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the task path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the overall project goals, constraints, and scope
2. Read `TASK_DIR/SPEC.md` to understand the task goals, constraints, and scope
3. If `TASK_DIR/TODO.md` exists, read it to understand the current task status
4. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
5. If the prior conversation already contains discussion about the task, use that context. Use AskUserQuestion only for gaps not covered by the conversation. Otherwise, use AskUserQuestion to clarify ambiguities or missing details, such as:
   - Tasks that seem missing
   - Tasks that are too large and should be broken down
   - Tasks that are out of order relative to dependencies
   - Tasks that don't align with the task spec
6. Propose the todo list to the user for review before writing anything
7. After user approval, write the todo list to `TASK_DIR/TODO.md` using this format:

## Format

```markdown
# Active

- [ ] First task
- [ ] Second task
- [ ] Third task

# Done
```

Keep tasks specific and actionable. Group related work but avoid making individual items too large. Order tasks so dependencies come first.
