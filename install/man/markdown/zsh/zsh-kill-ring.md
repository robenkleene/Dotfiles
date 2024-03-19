# `zsh` Kill Ring

## Modifying Previous Commands

Say you've already setup a search like `rg <term>` and you want to use the flags from a previous command.

1. Go before `<term>` and `C-k` to kill to the end of the line
2. Find the previous command in the history
3. Delete the end of the previous command with `C-k`
4. Yank with `C-y` cycling with `M-y` until the previously killed `<term>` is yanked
