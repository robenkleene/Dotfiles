---
description: Read the spec and propose a todo list
---

Read the spec and propose a todo list.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the project goals, constraints, and scope
2. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
3. Analyze the spec and break it down into concrete, actionable tasks
4. Propose the todo list to the user for review before writing anything
5. After user approval, write the todo list to `PLAN_DIR/TODO.md` using this format:

## Format

```markdown
# Active

- [ ] First task
- [ ] Second task
- [ ] Third task

# Done
```

Keep tasks specific and actionable. Group related work but avoid making individual items too large. Order tasks so dependencies come first.
