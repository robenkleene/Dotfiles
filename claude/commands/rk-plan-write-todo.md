---
description: Write or revise the project todo list
---

Write or revise the project todo list.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the project goals, constraints, and scope
2. If `PLAN_DIR/TODO.md` exists, read it to understand the current task status
3. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
4. Enter plan mode to discuss the todo list with the user
5. If the prior conversation already contains discussion about the project, use that context. Use AskUserQuestion only for gaps not covered by the conversation. Otherwise, use AskUserQuestion to clarify ambiguities or missing details, such as:
   - Tasks that seem missing
   - Tasks that are too large and should be broken down
   - Tasks that are out of order relative to dependencies
   - Tasks that don't align with the spec
6. Draft the todo list and present it to the user by exiting plan mode
7. After user approval, write the todo list to `PLAN_DIR/TODO.md` using this format:

## Format

```markdown
# Active

- [ ] First task
- [ ] Second task
- [ ] Third task

# Done
```

Keep tasks specific and actionable. Group related work but avoid making individual items too large. Order tasks so dependencies come first.
