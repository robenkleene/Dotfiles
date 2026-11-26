# Login shells, e.g., `ssh <host> zsh -lc <command>`. On macOS, `/etc/zprofile`
# runs `path_helper` after `zshenv`, which moves the system paths ahead of ours,
# so `path.zsh` moves them back to the front.
source ~/.zsh/path.zsh
