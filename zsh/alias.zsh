# Abbr
alias a='rg_custom'
alias v='nvim'

# Bash Script
alias pv="safepaste | $VIM_COMMAND -"
alias esk='emacs_kill_server'
alias esr='emacs_reset_server'
if [[ "$(uname)" = "Darwin" ]]; then
  alias ox='fzf_project_xcode'
fi
alias gpbo='git_push_branch_origin'
alias scwp='source_control_open_site -p'
alias scwr='BROWSER= gh pr view --web'
alias gua='git_pull_all'
alias tags="generate_tags"

# Alias
alias -- -='cd -'
alias ..='cd ..'
if [[ "$(uname)" = "Linux" ]]; then
  alias ls='ls --color=auto'
else
  if type "gls" > /dev/null; then
    alias ls='gls --color=auto'
  fi
fi
alias zoi='zsh_edit_config'
alias gemacs='emacs_app'
alias rg='rg_custom'
alias s='ssh_start && { egit -p || egitn } && echo "Auto" && sgitt -cp'
alias u='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh'
alias ut='ssh_git_pull_all -t'
alias ua='ssh_git_pull_all'
alias d='vim_cd'
alias gu='ssh_start && git pull'
alias gp='ssh_start && git push'
alias gur='ssh_start && git pull -r'
alias gpt='ssh_start && git push --tags'
alias cdg='git_cd_root'
alias cdhg='cd (hg root)'
alias gcu='git_commit_update'
