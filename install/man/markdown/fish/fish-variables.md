# `fish` Variables

- `set -lx VAR world`: Local exported variable
- `set -e VAR`: Erase variable
- `set result (pbpaste)`: Set a variable
- `echo $result`: Print variable separated by spaces
- `printf "%s\n" $result`: Print variable separated by line endings 
- `set --show MANPATH`: Deeper inspection into variables

## One Liner

- `key=value echo $key`: Set variable for one command

## Universal Variables

- Stored in `~/.config/fish_variables` and preserved across restarts (`abbr` are also stored in this file)
- `set -Ux`: Save universal variable (that will also be exported with `-x`, which is probably what's wanted)
- `set -e`: Remove a universal variable
- `set --names -U`: List all universal variables
- `set --names -U | grep -v "^_*fish"`: Can seems like it gets all variables that have been set manually
