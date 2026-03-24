Note that these commands won't work with just `z` (e.g., `z query <term>` won't work), because `z` is special command that jumps to a directory

# Query

- `zoxide query <term>`: Return the best match
- `zoxide query --list <term>`: Return a list of matches
- `zoxide query --list` (`-l`): Dump all potential matches
- `zoxide query -i`: Interactive query

# Add

- `zoxide add -- <path>`: Add a path to the database (not sure if the `--` is necessary?)

