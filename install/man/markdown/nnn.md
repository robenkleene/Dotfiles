# `nnn`

- `␣`: Tag file
- `^G`: Quit cd
- `1` / `2` / `3` / `4`: Switch to tab
- `␣` / `+`: Toggle selection
- `nnn <file-path>`: Open `nnn` with file highlighted

## Navigation

- `C-u` / `C-d`: Page up / down

## Filter

- `/`: Filter
- `⎋`: Exit prompt (e.g., a filter)
- `^L`: Toggle last filter
- `^N`: Type to nav
- `.`: Toggle show hidden files

## Help

- `?`: Show shortcuts (dumped to terminal so you can see them on quit)

## Operations

- `o`: Choose program to open with
- `e`: Edit file (e.g., an empty file that can't be edited with return)
- `x` / `^X`: Delete file
- `^R`: Rename file
- `^R`: Duplicate file (hit enter when prompted to rename and it will ask for a new name to copy to)
- `p`: Copy to new location
- `v`: Move to new location
- `n`: Create new
    - `d`: Directory
    - `f`: File
- `!` / `^]`: Spawn new shell on top of `nnn` (use `exit` to get back to `nnn`, `echo $NNNLVL` will show the current level)
- `]`: Open native shell prompt to enter shell commands

## Plugins

- `;`: Run a plugin (followed by assigned key) or `↩` to select a plugin to run
- `⌥<key>`: Can also be used to run a plugin

## Selection

- `a`: Select all
- `A`: Invert selection

## Shell Commands

### Native Command Prompt

- `]`: Enters the native command prompt
- `^D`: Exit native command prompt
- To run a command on the currently hovered file: `]` to enter the native command prompt, then `<command> $nnn`. E.g., `open $nnn` will open the currently hovered file.

#### Variables & Substitutions

- `$nnn`: Hovered file (e.g., `open $nnn`)
- `$d<number>`: Directory in context `<number>` (e.g., `cp "$f1" "$d3"`)
- `$f<number>`: Hovered file in context `<number>` (e.g., `cp "$f1" "$d3"`)
- `%j`: Repeat command with each file in selection (e.g., `printf "Searching for string in %s\n" "%j"; grep "string" "%j"`)
- `%J`: Append each file in selection to end of command (e.g., `tar uvf archive.tar %J`)
