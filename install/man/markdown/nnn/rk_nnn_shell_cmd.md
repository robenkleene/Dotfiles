- `!`, `^]`: Spawn new shell on top of `nnn` (use `exit` to get back to `nnn`, `echo $NNNLVL` will show the current level)
- `]`: Open native command prompt to enter shell commands
- In shells and command prompts, `$f1` holds the selected file path in the first pane, and `$d1` holds the directory in the first pane, `$f2` and `$d2` is the same for the second pane, etc...

# Native Command Prompt

- `^D`: Exit native command prompt
- To run a command on the currently hovered file: `]` to enter the native command prompt, then `<command> $nnn`. E.g., `open $nnn` will open the currently hovered file.

## Variables & Substitutions

- `$nnn`: Hovered file (e.g., `open $nnn`)
- `$d<number>`: Directory in context `<number>` (e.g., `cp "$f1" "$d3"`)
- `$f<number>`: Hovered file in context `<number>` (e.g., `cp "$f1" "$d3"`)

### These don't seem to work?

- `%j`: Run command separately for each file in the selection (e.g., `echo %j`)
- `%J`: Run command on all files in the selection (e.g., `echo %j`)
