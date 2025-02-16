# alias -- -='cd -'
# alias ..='cd ..'

# Trick to get `xargs` to use aliases, e.g., `fd foo | xargs eza` will not use
# aliases without this
alias xargs='xargs '
if [[ "$(uname)" = "Linux" ]]; then
  alias ls='ls --color=auto'
fi
alias grep="`which grep` --color=auto"

if [[ "$TERM" = 'xterm-ghostty' ]]; then
  # Check for `${aliases[<alias>]}` to allow `zshrc_local` to override
  if [[ ! ${aliases[rg]} ]]; then
    # alias rg="`which rg` --hyperlink-format file://{host}{path}"
    alias rg="`which rg` --hyperlink-format vscode://file/{path}:{line}:{column}"
  fi
  if [[ ! ${aliases[delta]} ]]; then
    alias delta="`which delta` --hyperlinks --hyperlinks-file-link-format vscode://file/{path}:{line}"
  fi
  alias fd="`which fd` --hyperlink"
  alias eza="`which eza` --hyperlink"
fi

# egit
# These are aliases instead of shell functions because they set the `ssh`
# status of the current shell
alias rk_push='ssh_start && { egit -p || egitn } && ~/.bin/sgitt_auto'
alias rk_pull='ssh_start && ~/.bin/egit_update'
alias rk_pull_text='ssh_start && ssh_git_pull_all -t'
alias rk_pull_all='ssh_start && ssh_git_pull_all'
alias rk_pull_settings='ssh_start && ~/.bin/egit_update -s'
