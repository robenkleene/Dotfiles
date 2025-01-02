- `␣`: Tag file
- `^G`: Quit and `cd` (if `cd` on quit is configured to always happen, there's no way to not `cd` on quit)
- `1` / `2` / `3` / `4`: Switch to tab
- `nnn <file-path>`: Open `nnn` with file highlighted
- `^L`: Redraw (force a refresh)
- `F`: Show details (like file modification time) about the current file
- `D`: Toggle details mode
- `.`: Toggle show hidden files

# Selection

- `␣` / `+`: Toggle selection
- `a`: Select all
- `A`: Invert selection

# Navigation

- `C-u` / `C-d`, `PgUp` / `PgDn`: Page up / down

# Filter

- `/`: Filter file list
- `^L`: Toggle last filter
- `^N`: Toggle `type-to-nav` (`⌃D` to exit)

## Active Filter

Including `type-to-nav` mode.

- `⎋`, `⌃D`: Exit an active filter.

# Help

- `?`: Show shortcuts (dumped to terminal so you can see them on quit)

# Operations

- `o`: Choose program to open with
- `e`: Edit file (e.g., an empty file that can't be edited with return)
- `x`, `^X`: Delete file or directory (recursively)
- `^R`: Rename file
- `^R`: Duplicate file (hit enter when prompted to rename and it will ask for a new name to copy to)
- `p`: Copy to new location
- `v`: Move to new location
- `nf`: New file
- `nd`: New directory

# Plugins

- `;`: Run a plugin (followed by assigned key) or `↩` to select a plugin to run
- `⌥<key>`: Can also be used to run a plugin

# Shell Commands

- `!`, `^]`: Spawn new shell on top of `nnn` (use `exit` to get back to `nnn`, `echo $NNNLVL` will show the current level)
- `]`: Open native command prompt to enter shell commands

## Native Command Prompt

- `^D`: Exit native command prompt
- To run a command on the currently hovered file: `]` to enter the native command prompt, then `<command> $nnn`. E.g., `open $nnn` will open the currently hovered file.

### Variables & Substitutions

- `$nnn`: Hovered file (e.g., `open $nnn`)
- `$d<number>`: Directory in context `<number>` (e.g., `cp "$f1" "$d3"`)
- `$f<number>`: Hovered file in context `<number>` (e.g., `cp "$f1" "$d3"`)
- `%j`: Repeat command with each file in selection (e.g., `printf "Searching for string in %s\n" "%j"; grep "string" "%j"`)
- `%J`: Append each file in selection to end of command (e.g., `tar uvf archive.tar %J`)
