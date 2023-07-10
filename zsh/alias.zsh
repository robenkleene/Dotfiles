# special
alias -- -='cd -'
alias ..='cd ..'

alias gu='ssh_start && git pull'
alias gp='ssh_start && git push'
alias gur='ssh_start && git pull -r'

# ls
if [[ "$(uname)" = "Linux" ]]; then
  alias ls='ls --color=auto'
else
  if type "gls" > /dev/null; then
    alias ls='gls --color=auto'
  fi
fi

# zsh
alias zoi='zsh_edit_config'

# egit
alias s='ssh_start && { egit -p || egitn } && ~/.bin/sgitt_auto'
alias u='ssh_start && ~/.bin/egit_update'
alias ut='ssh_start && ssh_git_pull_all -t'
alias ua='ssh_start && ssh_git_pull_all'

# cd
# The trailing `.` are intentional so that the alias can be called without
# arguments to open the current directory
alias d="$CD_COMMAND ."
alias ecd="emacs_cd ."

# misc
alias rg='rg_custom'
