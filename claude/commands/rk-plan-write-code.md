---
description: Write or revise code pointers for the project
---

Write or revise code pointers for the project.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the project goals, constraints, and scope
2. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
3. Explore the codebase to find files, functions, and patterns relevant to the spec
4. Propose a list of code pointers to the user for review
5. After user approval, write the code pointers to `PLAN_DIR/CODE.md`

## Format

Each entry in CODE.md should include:
- File path and line number (e.g., `src/auth.ts:42`)
- Brief description of what it does and why it's relevant
