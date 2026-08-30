# Response Format

## File References

EVERY reference to a file location in EVERY response MUST use grep format: `<absolute-path>:<line>:<column>` (e.g., `~/Developer/Dotfiles/claude/CLAUDE.md:5:1`). Replace the home directory with `~/`. When referencing a file without a specific line, use the absolute path alone.

Never truncate or abbreviate any part of the path. Use the complete path with every directory component — never use `...` or `…` to shorten intermediate directories.

Never describe a location in prose. Before sending any response, check that all file references use this format.

- Bad: "lines 34-35 of IGRevealStickerDualExport.swift"
- Bad: "at line 89-90 of IGRevealStickerDualExport.swift"
- Bad: "in `IGStoryMediaCompositionExporter.m` (~line 3288)"
- Bad: `~/fbsource-eden2/fbobjc/.../IGRevealStickerDualExport.swift:34:1` (truncated with `...`)
- Good: `~/fbsource-eden2/fbobjc/Apps/Instagram/Instagram/SomeDir/IGRevealStickerDualExport.swift:34:1`

# Style Guides

When editing files, check for a style guide by running `man rk-<ext>-style` (where `<ext>` matches the file extension, e.g., `man rk-sh-style`). The local style of existing nearby files takes precedence; use the style guide as a secondary reference.

When writing comments in any language, follow the comment style guide at `man rk-comment-style`.

# Git

When I refer to the "current commit" (e.g., `current_commit`, `current commit`, `the current commit`), it always means the commit at HEAD. Resolve it with `git rev-parse HEAD`.

# Mercurial

When the user refers to the "current commit", `current_commit`, or "current diff", always run `sl log -l 1` first to verify which commit is actually checked out.

# Version Control

When working with version controlled files, never commit changes unless explicitly told to do so (e.g., wait for a explicit command like "amend the current commit" or "continue the rebase").

# Print Debugging

When adding print statements to debug an issue, try to minimize noise. Avoid statements that print every frame, or that keep printing when nothing important is happening. Prefer printing at meaningful state transitions or only when a relevant condition changes.

If a potentially noisy print statement is necessary, look for a way to gate it. For example, only print the message once, or only after a specific previous event has occurred. Always try to find ways to reduce noise rather than accepting it.

Keep each print statement on a single line whenever possible. Output will likely be filtered with `grep`, and line breaks in the printed message won't appear in the filtered output.

Always include a consistent prefix on every print statement, like `[Foo]`, so the output can be filtered on that prefix (e.g., with `grep '\[Foo\]'`).

When the current commit contains only print debugging and you want to apply a fix or other changes based on what the prints revealed, always apply that fix as a new, separate commit. Never fold the fix into the existing print-debugging commit (e.g., do not amend it). Keeping the print-debugging commit isolated makes it easy to drop or revert later without entangling the fix.

# Abstraction and Design

Before writing new code, ask: "Does an abstraction already exist or want to exist here?" Search the codebase for existing patterns that solve the same or a similar problem. Prefer reusing and extending existing patterns over inventing new ones. If you find yourself writing a lot of new logic (new helpers, new abstractions, new control flow, new state) to support a change, treat that as a signal to stop and look harder for an existing pattern you may have missed.

If you're about to duplicate logic, write a shared helper first. Prefer small, focused classes/functions over complex interdependencies. Default to the simplest abstraction that eliminates duplication.

# Generated Output

Never delete output you generated while working — renders, screenshots, exports,
logs, intermediate files. This includes test and preview output from iterating,
output superseded by a later version, and output from an approach that was tried
and abandoned. Keep all of it, and leave it where it was written.

The intermediate output is how I see what you actually tried, not just what you
settled on. Cleaning it up destroys the record of the process, and a failed or
superseded attempt is often the most useful thing to look at. Tidiness is never
a reason to remove it.

Delete generated output only when I explicitly ask for that specific deletion.

# Animation Renders

Video and animation renders are for checking motion, not for looking at. Always
render them small and at whatever the cheapest sampling or preview quality the
tool offers, and never spend a long render on one.

Motion reads fine at low resolution, and a high quality animation costs hours
for something I am only going to watch to see whether the movement works. Judge
image quality from stills instead, where a single frame is cheap.

If a final high quality animation is ever wanted, I will ask for it.

# Local Overrides

The following file contains overrides that take precedence over all previous instructions:

@~/.agents-local/AGENTS.md
