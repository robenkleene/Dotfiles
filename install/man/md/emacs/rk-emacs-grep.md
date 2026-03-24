- `grep`: Run a user-specified `grep` command and put the results in a `grep-mode` buffer
- `compilation-minor-mode` and `compilation-shell-minor-mode` can be used to quickly make grep match strings clickable to jump to the file. The `compilation-shell-minor-mode` version uses bindings that won't conflict with `shell-mode`, so it's good to use in a shell buffer.

# `M-x grep`

The default `M-x grep` command is `grep --color=auto -nH --null -e `, this is expecting a pattern followed by a file path. The default command for this is `grep-command` but note that you can't set it via `(let ((grep-command "")) call-interactively 'grep)`, because `call-interactively` won't use the `let` value, it'll use the global value.
