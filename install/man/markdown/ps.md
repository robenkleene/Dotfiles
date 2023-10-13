%

# `ps`

- `ps -fp <pid>`: Show info about process
- Just pipe to `cat` to stop `ps` from truncating, e.g., `ps -fp <pid> | cat`

## `ps aux`

- `a`: All users
- `u`: Show owner
- `x`: Include processes not attached to a terminal

## Examples

- `ps auxo pgid`: Adds `pgid`, but truncates the command
- `ps -ww -A -o pid,pgid,args`: The `-ww` in these shows the full output
