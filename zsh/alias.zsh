# Basic
alias -- -='cd -'
alias ..='cd ..'

if [[ "$(uname)" = "Linux" ]]; then
  alias ls='ls --color=auto'
else
  if type "gls" > /dev/null; then
    alias ls='gls --color=auto'
  fi
fi

alias p='safepaste'
alias y='safecopy'
alias pv="safepaste | $VIM_COMMAND -"
alias gemacs='emacs_app'

alias zoi='zsh_edit_config'

alias rg='rg_custom'
alias a='rg_custom'
alias v='nvim'

# `git`
alias s='ssh_start && { egit -p || egitn } && echo "Auto" && sgitt -cp'
alias u='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh'
alias ut='ssh_git_pull_all -t'
alias ua='ssh_git_pull_all'

# Emacs
alias esk='emacs_kill_server'
alias esr='emacs_reset_server'

# `vim_cd`
alias d='vim_cd'

# Xcode
if [[ "$(uname)" = "Darwin" ]]; then
  alias ox='fzf_project_xcode'
fi

# `git`
alias gu='ssh_start && git pull'
alias gp='ssh_start && git push'
alias gur='ssh_start && git pull -r'
alias gpt='ssh_start && git push --tags'

alias cdg='git_cd_root'
alias gbpr='git_branch_prune'
alias gpbo='git_push_branch_origin'
alias scwp='source_control_open_site -p'
alias scwr='BROWSER= gh pr view --web'
alias sgpt='sgitt -cp'
alias sgut='sgitt -u'
alias sgua='git_pull_all'
alias gcu='git_commit_update'
alias gua='git_pull_all'

# Tags
alias tags="generate_tags"

# Mercurial
alias cdhg='cd (hg root)'
