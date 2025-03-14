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
- `%j`: Repeat command with each file in selection (e.g., `printf "Searching for string in %s\n" "%j"; grep "string" "%j"`)
- `%J`: Append each file in selection to end of command (e.g., `tar uvf archive.tar %J`)
