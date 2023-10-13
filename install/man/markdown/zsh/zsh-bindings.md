%

# `zsh` Bindings

## Editing

- `C-_` / `C-X u` / `C-X C-u`: Undo
- `M-C--`: Insert previous parameter
    - This can take a prefix argument to get other parameters, for example `M-2 M-.` to get the second last
- `M-.` / `M-_`: Insert last parameter of previous command
    - This can take a prefix argument to get other parameters, for example `M-2 M-.` to get the second last
    - Subsequent presses go back through previous commands (e.g., `M-. M-.` gets the last parameter two commands ago)
- `M-'`: Quote the line (e.g., to use `su -c` or `ssh`)
- `M-h`: Help for current command (runs `man`)
- `C-q` or `^[q`: Push current line (clears the line, execute one command and then return the line)
- `C-y`: Yank
- `C-w`: Kill last word (or parameter)
- `M-<return>`: Insert new line (to extend the command to multiple lines)

### Autoload

```
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey -e "^[m" copy-earlier-word
```

`copy-earlier-word`

- Cycle through previous parameters.

## History

- `^r`: Reverse history search
- `^s`: Reverse history search
- `⇥`: Accept a history match, without executing it
- `history 0`: Dump full history

(Just use a movement command (like `^[a` or `^[e`) to dismiss the search.)

### Menu

When the menu is visible to select various options.

### Bindings

`man zshzle` for what each widget does.

- `zle -la`: List all available commands to bind
- `bindkey -l`: List key maps
- `bindkey -M emacs`: List bindings for a key map
- `bindkey -M menuselect`: Bindings for tab menu
- `bindkey -L`: List currently active bindings
- `bindkey -e "^X^E" edit-command-line`: Set a binding for emacs key map
