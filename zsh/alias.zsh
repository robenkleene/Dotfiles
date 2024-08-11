alias -- -='cd -'
alias ..='cd ..'

# ls
if [[ "$(uname)" = "Linux" ]]; then
  alias ls='ls --color=auto'
else
  if type "gls" > /dev/null; then
    alias ls='gls --color=auto'
  fi
fi

# egit
# These are aliases instead of shell functions because they set the `ssh`
# status of the current shell
alias rk_push='ssh_start && { egit -p || egitn } && ~/.bin/sgitt_auto'
alias rk_pull='ssh_start && ~/.bin/egit_update'
alias rk_pull_text='ssh_start && ssh_git_pull_all -t'
alias rk_pull_all='ssh_start && ssh_git_pull_all'
alias rk_pull_settings='ssh_start && ~/.bin/egit_update -s'
