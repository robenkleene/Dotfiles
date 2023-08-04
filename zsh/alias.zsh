# special
alias -- -='cd -'
alias ..='cd ..'

alias gits='ssh_start && git'

# ls
if [[ "$(uname)" = "Linux" ]]; then
  alias ls='ls --color=auto'
else
  if type "gls" > /dev/null; then
    alias ls='gls --color=auto'
  fi
fi

# zsh
alias zsh_edit_history='$EDITOR ~/.zsh_history'

# egit
alias s='ssh_start && { egit -p || egitn } && ~/.bin/sgitt_auto'
alias u='ssh_start && ~/.bin/egit_update'
alias ut='ssh_start && ssh_git_pull_all -t'
alias ua='ssh_start && ssh_git_pull_all'

# misc
alias rg='rg_custom'
