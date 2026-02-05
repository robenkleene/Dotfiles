# Dotfiles Repository

This is a dotfiles repository. **All files and directories in this repo are symlinked to the home directory with a dot prefix.**

## How It Works

The `install/update.sh` script creates symlinks for all top-level files and directories:
- `vim/` → `~/.vim`
- `claude/` → `~/.claude`
- `gitconfig` → `~/.gitconfig`
- etc.

**Important:** When you edit files in this repository, you're editing the actual config files used by the system (via symlinks). Changes take effect immediately.

## Working in This Repository

- Never create directories like `.claude/` - use `claude/` (without the dot)
- The dot prefix is only added in the home directory via the symlink
- Files here are the **source** - they ARE your dotfiles, not copies of them
