# Style Guides

When editing files, check for a style guide by running `man rk_<ext>_style` (where `<ext>` matches the file extension, e.g., `man rk_sh_style`). The local style of existing nearby files takes precedence; use the style guide as a secondary reference.

When writing comments in any language, follow the comment style guide at `man rk_comment_style`.

# File References

When referencing a specific location in a file, always use grep format: `<absolute-path>:<line>:<column>` (e.g., `~/Developer/Dotfiles/claude/CLAUDE.md:5:1`). Replace the home directory with `~/` where applicable. Never describe a location in prose (e.g., "at line 62 in Foo.m it says...") — always provide a machine-readable reference the user can cut and paste to jump to the location. When referencing a file without a specific location, use the absolute path alone (e.g., `~/Developer/Dotfiles/claude/CLAUDE.md`).

# Git

When I refer to the "current commit" (e.g., `current_commit`, `current commit`, `the current commit`), it always means the commit at HEAD. Resolve it with `git rev-parse HEAD`.

# Mercurial

When the user refers to the "current commit", `current_commit`, or "current diff", always run `sl log -l 1` first to verify which commit is actually checked out.

# Version Control

When working with version controlled files, never commit changes unless explicitly told to do so (e.g., wait for a explicit command like "amend the current commit" or "continue the rebase").

# Abstraction and Design

Before writing new code, ask: "Does an abstraction already exist or want to exist here?" Search the codebase for existing patterns that solve the same or a similar problem. Prefer reusing and extending existing patterns over inventing new ones. If you find yourself writing a lot of new logic (new helpers, new abstractions, new control flow, new state) to support a change, treat that as a signal to stop and look harder for an existing pattern you may have missed.

If you're about to duplicate logic, write a shared helper first. Prefer small, focused classes/functions over complex interdependencies. Default to the simplest abstraction that eliminates duplication.
