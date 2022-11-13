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
alias safecopy1='tr -d '\''\n'\'' | tee /dev/tty | safecopy'
alias shs='ssh_start'
alias sts='ssh_tmux_start'
alias stsr='ssh_tmux_restore_start'
alias ge='emacs_app'
alias gemacs='emacs_app'
alias excel='open -a "Microsoft Excel"'
alias f='fish'

# Override

# fd
# Display hidden files by default
# This doesn't work now because the `fzf` commands also add
# hidden, we should be able to add the `--hidden` flag twice in a
# future version of `fd` and we can uncomment this then.
# alias fd='fd --hidden'

# `zsh`
alias zoi='zsh_edit_config'
# alias ol="$EDITOR settings.sh"
# alias sl="source settings.sh"
# alias ob="$EDITOR build.log"
# alias ot="$EDITOR test.log"
# alias dh='dirs -v'

# scripts
alias rg='rg_custom'
alias dv='vim_diff'
alias l='less'
alias s='ssh_start && { egit -p || egitn } && echo "Auto" && sgitt -cp'
alias u='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh'
alias ut='ssh_git_pull_all -t'
alias ua='ssh_git_pull_all'
alias pull='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && git_pull_all -t'

# `tmux`
alias tmp='tmux_paths'
alias tmpa='tmux_paths -a'
alias tmc='tmux_paths_run'
alias tmgs='tmux_git_status'
alias tmssdw='tmux_session_save_dropbox_work'
alias tmba='tmux_banner_all'
alias tmn='tmux_shell_new'
alias tmr='tmux_restart'

# `make`
alias mt='make test'
alias ml='make lint'
alias mac='make autocorrect'
alias macc='make autocorrect && git add -A :/ && git commit -m "Run autocorrect"'

# `node`
alias nt='npm test'
alias nrt='npm run test'
alias nrl='npm run lint'
alias nrf='npm run format'
alias nrac='npm run autocorrect'

# `emacs`
alias mgs='emacs_magit_status'
alias mgl='emacs_magit_log'
alias esk='emacs_kill_server'
alias esr='emacs_reset_server'

# `vim_cd`
alias d='vim_cd'

# `vim`
alias vsr='vim_session_restore_auto'
alias vsra='vim_session_restore_auto'
alias vsrs='vim_session_restore_saved'

# `emacs`
if [[ "$(uname)" = "Darwin" ]]; then
  alias gemacs="open -a emacs"
fi

# Xcode
if [[ "$(uname)" = "Darwin" ]]; then
  alias xcb='xcodebuild_debug'
  alias ox='fzf_project_xcode'
fi

# `doc` / `snp` / `dev`
alias dev='fzf_developer'

# Test Variable
alias ptv='echo $test_variable'
# The `|| true` prevents an exit status of 1 if the output does not end in a
# new line
alias ytv='yank_test_variable'
alias ctv='safepaste | read test_variable || true'

# `git`
alias gu='ssh_start && git pull'
alias gp='ssh_start && git push'
alias gur='ssh_start && git pull -r'
alias gpt='ssh_start && git push --tags'
alias gblpr='git_branch_list_pruned'
alias grv='git_revision_print'
alias grvp='git_revision_print'
alias grt='git_remote_print'
alias grtp='git_remote_print'
alias grtao='git_remote_add_origin'
alias gac='git_commit_all'
alias gacm='git_commit_all'
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

# `slug`
alias slpr='slug_project'
alias slpre='slug_project_edit'

# Edit
alias erm='eval $EDITOR README.md'
alias ecrm='eval $EMACS_COMMAND README.md'

# Tags
alias tags="generate_tags"

# Common
alias journal="$VIM_COMMAND ~/Text/journal/journal.md"
alias tweet="markdown_tweet_edit"
alias qa="quick_text_search"
alias writing="$VIM_COMMAND ~/Text/writing/README.md"
alias vs="vscode"

# Mercurial
alias cdhg='cd (hg root)'
alias hgf='hg status --rev ".^" | grep -v "^R" | cut -d'\'' '\'' -f2'
alias hgfb='hg status --rev bottom^ | grep -v "^R" | cut -d'\'' '\'' -f2'
