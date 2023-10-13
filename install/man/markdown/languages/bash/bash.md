%

# Bash

- `$(command)`: Command substitution, the result of the command replaces the  `cat $(ls)` command.
- `( list )` and `{ list; }` are used to group commands, e.g., `(ls *.js; ls *.css) | grep test`. The difference is that `()` creates a sub-shell and `{}` does not. (Note that the `;` is required only with `{}`.)
- `type <command>`: Tells whether a command is a function, built-in, or alias.
- `fc`: Edit last command in `$EDITOR`.

## One Liner

Use the following to work with a variable:

    var=".test"; echo "$var ${var#.}"

## `set`

- `set -e`: Exit on non-zero exit status
- `set -o pipefail`: Fail if any command fails when using pipes, not just the last one
- `set -x`: Print each command
- `set -u`: Error on unset variables (to test for a variable with this setting on use `${CODESPACES-}`)

## `getopts`

In `while getopts ":a:bh" option`, the first `:` runs `getopts` in "silent error checking mode", e.g., if you want to handle error messages yourself. In `a:`, it means the `a` flag can have arguments.

## Variables

- `${parameter:-word}`: Set the default value for a variable
