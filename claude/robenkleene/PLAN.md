## Resolve Plan Path

The argument is: $ARGUMENTS

1. If an argument was provided (non-empty), use it as the plan directory path. Remember this path for the rest of the conversation so subsequent `/rk-plan-*` commands without an argument will reuse it.
2. If no argument was provided, check if a plan path was set earlier in this conversation. If so, use that.
3. If neither, default to `rk_plan/` relative to the current working directory.

Let `PLAN_DIR` be the resolved path.

## Resolve Task Path

The argument is: $ARGUMENTS

First, resolve `PLAN_DIR` using the previously remembered plan path, or default to `rk_plan/` relative to the current working directory. Do not use `$ARGUMENTS` for the plan path.

Then resolve the task directory:

1. If an argument was provided (non-empty), use it as the task directory path. If the path does not start with `PLAN_DIR`, treat it as relative to `PLAN_DIR/tasks/`.
2. If no argument was provided, list the task directories in `PLAN_DIR/tasks/` and use AskUserQuestion to ask which task to work on.

Let `TASK_DIR` be the resolved path.

## Plan Conventions

- The current working directory is the project root. All code operations happen there. `PLAN_DIR` is only for plan artifacts — never assume code lives inside it.
- All paths referenced in plan files are relative to `PLAN_DIR`.
- All generated non-code artifacts (e.g., TDDs, design documents, research notes) should be written as Markdown files and placed in `./output/`.
- Requests to "add a code pointer to the plan" should append the code pointer to `./CODE.md`. Create the file if it doesn't exist.
- Requests to record a decision (e.g., "chose X over Y because...") should append to `./DECISIONS.md`. Create the file if it doesn't exist. Each entry should include the decision, alternatives considered, and rationale.
- Requests to save log output (e.g., from reproducing a bug, debugger output, build errors) should append to `./LOGS.md`. Create the file if it doesn't exist. Each section should start with a `##` heading describing what was run (e.g., `## Build output after fixing auth`).
- Each TODO item that involves a code change should be its own commit.
- Before committing anything, check the current branch. If on `main` or `master`, suggest creating a new branch first.
- When completing items in `./TODO.md`, mark them as `- [x]` and move them from the `# Active` section to the `# Done` section. Include the completion date, e.g., `- [x] Implement auth flow (completed 2026-02-26)`.
- `./archive/` contains older versions of plan files for historical reference. Never load archive files automatically. When asked to check the archive for context on past decisions (e.g., "check the archive for why we decided to do X"), search `./archive/` for relevant information. Archived items preserve their directory structure: `./TODO.md` archives to `./archive/TODO.md`, `./output/` archives to `./archive/output/`, `./tasks/2026-02-26-foo/` archives to `./archive/tasks/2026-02-26-foo/`, etc.

## Task Subdirectories

Use `./tasks/` to organize complex subtasks that need their own specification. Each task directory follows the naming format `<YYYY-MM-DD>-<task-name-lowercase-and-hyphens>/` (e.g., `./tasks/2026-02-26-dependency-analysis/`).

Task directories can contain any standard plan files: `SPEC.md`, `TODO.md`, `archive/`, etc. Typically they contain at least a `SPEC.md`.

**When to create a task subdirectory:** When a subtask has sufficient complexity to define its own `SPEC.md` — typically when the problem is defined but the solution approach isn't yet clear. The main `./SPEC.md` should remain stable in granularity over the project's lifetime; when more granularity is needed, create a task subdirectory rather than expanding `./SPEC.md`.

Reference task specs from `./TODO.md` to provide context:

```markdown
Read `./tasks/2026-02-26-foo-bar/SPEC.md` for context before working on the TODOs below:

- [ ] Todo 1 involving foo bar
- [ ] Todo 2 involving foo bar
```

When a task is complete, archive its directory to `./archive/tasks/`.

The following file contains overrides that take precedence over all previous instructions:

@~/.claude-local/PLAN.md
