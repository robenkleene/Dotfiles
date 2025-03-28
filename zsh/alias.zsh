# Trick to get `xargs` to use aliases, e.g., `fd foo | xargs eza` will not use
# aliases without this
alias xargs='xargs '

# Colors
alias grep="`which grep` --color=auto"
if [[ "$(uname)" = "Linux" ]]; then
  # `ls` does colors by default on macOS
  alias ls="`which ls` --color=auto"
fi

# Use `nvim` for clipboard provider
alias vim='nvim'

# egit
# These are aliases instead of shell functions because they set the `ssh`
# status of the current shell
alias rk_push='ssh_start && { egit -p || egitn } && ~/.bin/sgitt_auto'
alias rk_pull='ssh_start && ~/.bin/egit_update'
alias rk_pull_text='ssh_start && ssh_git_pull_all -t'
alias rk_pull_all='ssh_start && ssh_git_pull_all'
alias rk_pull_settings='ssh_start && ~/.bin/egit_update -s'
