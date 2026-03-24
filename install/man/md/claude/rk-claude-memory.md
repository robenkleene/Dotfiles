# Memory Locations

- `/Library/Application Support/ClaudeCode/CLAUDE.md`: Managed policy (e.g., for an organization)
- `./CLAUDE.md` or `./.claude/CLAUDE.md`: Project shared (checked into source control for the project)
- `./.claude/rules/*.md`: Project rules
- `~/.claude/CLAUDE.md`: User memory, personal preferences for all projects
- `./CLAUDE.local.md`: Personal, project-specific, preferences (not checked into source control)

## Imports

Paths can be imported with `@path/to/import`, e.g.:

```
See @README for project overview and @package.json for available npm commands for this project.

# Additional Instructions
- git workflow @docs/git-instructions.md
```

## Project Workflow

Put a `CLAUDE.local.md` at the root of the project repo, and add an import to the project specific instructions:

```
# Individual Preferences
- @~/.claude/my-project-instructions.md
```
