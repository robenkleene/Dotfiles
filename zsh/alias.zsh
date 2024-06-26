# special
# Don't use these because they aren't support in other apps (e.g., Vim)
# alias -- -='cd -'
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
alias upush='ssh_start && { egit -p || egitn } && ~/.bin/sgitt_auto'
alias upull='ssh_start && ~/.bin/egit_update'
alias upull_text='ssh_start && ssh_git_pull_all -t'
alias upull_all='ssh_start && ssh_git_pull_all'
alias upull_settings='ssh_start && ~/.bin/egit_update -s'
