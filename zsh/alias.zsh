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
alias zsh_history_edit='${EDITOR:-vim} ~/.zsh_history'
alias zsh_init_edit='${EDITOR:-vim} ~/.zshrc'

# egit
# These are aliases instead of shell functions because they set the `ssh`
# status of the current shell
alias s='ssh_start && { egit -p || egitn } && ~/.bin/sgitt_auto'
alias u='ssh_start && ~/.bin/egit_update'
alias ut='ssh_start && ssh_git_pull_all -t'
alias ua='ssh_start && ssh_git_pull_all'
alias us='ssh_start && ~/.bin/egit_update -s'
