# Plan Workflow

A structured workflow for using Claude to plan and implement projects. You write specs, Claude discusses them with you in plan mode, then implements them.

## Quick Reference

| Command | Purpose |
|---|---|
| `/rk-plan-write-spec` | Write or revise the project spec |
| `/rk-plan-write-todo` | Write or revise the project todo list |
| `/rk-plan-write-task-spec` | Write or revise a task spec |
| `/rk-plan-write-task-todo` | Write or revise a task todo list |
| `/rk-plan-run` | Work through the project todo list |
| `/rk-plan-run-task` | Work through a task todo list |
| `/rk-plan-continue` | Restore project context and suggest next action |
| `/rk-plan-continue-task` | Restore task context and suggest next action |

## Starting a Project

### Step 1: Write the spec

Write `rk_plan/SPEC.md` yourself in your editor. This is where you dump all the important context for the project: what you're building, constraints, requirements, links to references, etc. Writing it outside of Claude is more efficient for getting everything down, and makes it easy to include links to media or documentation.

### Step 2: Discuss the spec with Claude

Run `/rk-plan-write-spec`. Claude reads your spec and enters plan mode automatically. In plan mode, Claude can read and explore but not write code, so you can discuss freely without Claude jumping ahead. Claude asks clarifying questions until the spec is solid. When you're both satisfied, Claude exits plan mode and writes the refined spec.

### Step 3: Write the todo list

Run `/rk-plan-write-todo`. Claude reads the spec, enters plan mode, and proposes a todo list. You discuss the breakdown, reorder tasks, split items that are too large, and remove anything out of scope. After approval, Claude writes the todo list.

### Step 4: Implement

Run `/rk-plan-run`. Claude works through the todo list sequentially, implementing each item, running tests, and committing. If something fails or is ambiguous, Claude stops. Use `/rk-plan-continue` to restore context and pick up where it left off.

## Iterating with Tasks

After the first pass, you'll usually find issues: things that didn't work as expected, missing pieces, or areas that need a different approach. Tasks let you scope these into focused subtasks.

### Step 1: Write the task spec

Create a task directory under `rk_plan/tasks/` (e.g., `rk_plan/tasks/2026-02-26-fix-auth/`) and write a `SPEC.md` in it describing what needs to change and why.

### Step 2: Discuss the task spec with Claude

Run `/rk-plan-write-task-spec <task-dir>`. Same flow as the project spec: Claude reads it, enters plan mode, asks questions, refines it.

### Step 3: Write the task todo list

Run `/rk-plan-write-task-todo <task-dir>`. Claude reads the task spec and proposes a todo list scoped to that task.

### Step 4: Implement the task

Run `/rk-plan-run-task <task-dir>`. Claude works through the task todo list. Use `/rk-plan-continue-task <task-dir>` to resume if it stops.

## Plan Directory Structure

All plan artifacts live in `rk_plan/` (or a custom path passed as an argument). The project code lives in the current working directory, not inside the plan directory.

- `SPEC.md` -- project specification
- `TODO.md` -- task list with `# Active` and `# Done` sections
- `CODE.md` -- relevant code pointers (optional)
- `DECISIONS.md` -- recorded decisions with rationale (optional)
- `LOGS.md` -- saved command output and debug logs (optional)
- `tasks/` -- task subdirectories, each with their own `SPEC.md` and optionally `TODO.md`
- `archive/` -- older versions of plan files for historical reference

## Tips

- All `/rk-plan-write-*` commands enter plan mode for discussion, then exit to write. If you've already been discussing the project in the conversation, the commands use that context instead of asking from scratch.
- The plan path defaults to `rk_plan/` but you can pass a different path as an argument to any command. Once set, subsequent commands in the same conversation reuse it.
- Task directories use the naming format `<YYYY-MM-DD>-<task-name>/`. When a task is complete, archive it to `archive/tasks/`.
- Each todo item that involves a code change gets its own commit. Claude checks the branch before committing and suggests creating a new branch if on `main` or `master`.
