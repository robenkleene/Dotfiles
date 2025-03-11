- `$(command)`: Command substitution, the result of the command replaces the  `cat $(ls)` command.
- `( list )` and `{ list; }` are used to group commands, e.g., `(ls *.js; ls *.css) | grep test`. The difference is that `()` creates a sub-shell and `{}` does not. (Note that the `;` is required only with `{}`.)
- `type <command>`: Tells whether a command is a function, built-in, or alias.
- `fc`: Edit last command in `$EDITOR`.
- `!:q` in Bash prints out the previous command escaped

# One Liner

Use the following to work with a variable:

    var=".test"; echo "$var ${var#.}"

# `getopts`

In `while getopts ":a:bh" option`, the first `:` runs `getopts` in "silent error checking mode", e.g., if you want to handle error messages yourself. In `a:`, it means the `a` flag can have arguments.

# Terminal Emulator

Opening files:

    fd ultisnips -0 | xargs -o -0 vim

- `-o` / `--open-tty`: Re-open stdin as a tty, this suppresses the "Input is not from a terminal" warning in Vim
