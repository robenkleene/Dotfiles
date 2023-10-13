%

# Helix Compiling

1. Compile with `cargo install --path helix-term`
2. After compiling, before running, add create a symlink to the runtime path: 

        ln -s $PWD/runtime ~/.config/helix/runtime

## Notes

Package managers make a wrapper script that sets the Helix runtime path:

```
$ cat (which hx)  Dotfiles (master=)
#!/bin/bash
HELIX_RUNTIME="/home/linuxbrew/.linuxbrew/Cellar/helix/22.08.1/libexec/runtime" exec "/home/linuxbrew/.linuxbrew/Cellar/helix/22.08.1/libexec/bin/hx"  "$@"
```
