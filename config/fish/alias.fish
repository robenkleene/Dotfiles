# "alias --save" creates an autoloaded function for an alias, but there's no
# easy way to clean thes up later. E.g., "function --erase" still leaves the
# file

alias p='safepaste'
alias y='safecopy'
alias pv="safepaste | $VIM_COMMAND -"
alias safecopy1='tr -d '\''\n'\'' | tee /dev/tty | safecopy'
alias ge='emacs_app'
alias gemacs='emacs_app'
alias excel='open -a "Microsoft Excel"'

# Override

# fd
# Display hidden files by default
# This doesn't work now because the `fzf` commands also add
# hidden, we should be able to add the `--hidden` flag twice in a
# future version of `fd` and we can uncomment this then.
# alias fd='fd --hidden'

# `zsh`
alias foi='fish_edit_config'

# scripts
alias t='terminal_cd'
alias o='open_custom'
alias q='vim_grep'
alias l='less'
alias rg='rg_custom'
alias u='git_pull_all'

# `tmux`
alias tma='tmux attach'
alias tmnd='tmux_name_directory'
alias tmsr='tmux_session_auto_restore'
alias tmsq='tmux_session_auto_save_quit'
alias tmp='tmux_paths'
alias tmpa='tmux_paths -a'
alias tmc='tmux_paths_run'
alias tmack='tmux_paths_rg'
alias tmgs='tmux_git_status'
alias tmssdw='tmux_session_save_dropbox_work'
alias tmba='tmux_banner_all'
alias tmn='tmux_shell_new'

# `make`
alias mt='make test'
alias ml='make lint'
alias mac='make autocorrect'
alias macc='make autocorrect && git add -A :/ && git commit -m "Run autocorrect"'

# `node`
alias nrt='npm run test'
alias nrl='npm run lint'
alias nrf='npm run format'
alias nrac='npm run autocorrect'

# `emacs`
alias mgs='emacs_magit_status'
alias mgl='emacs_magit_log'

# `vim_cd`
alias d='vim_cd'

# `vim`
alias vsr='vim_session_restore_auto'
alias vsra='vim_session_restore_auto'
alias vsrs='vim_session_restore_saved'

# `emacs`
switch (uname)
    case Darwin
        alias gemacs="open -a emacs"
end

# Xcode
switch (uname)
    case Darwin
        alias xcb='xcodebuild_debug'
        alias ox='fzf_project_xcode'
end

# `doc` / `snp` / `dev`
alias snp='fzf_snippet_copy'
alias snpe='fzf_snippet_edit'
alias doce='fzf_documentation_edit'
alias doc='fzf_documentation'
alias dev='fzf_developer'

# Test Variable
alias ptv='echo $test_variable'
# The `|| true` prevents an exit status of 1 if the output does not end in a
# new line
alias ctv='safepaste | read test_variable || true'

# `git`
alias gbp='git_branch_print'
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
alias gprpr='git_process_pull_request'
alias gpbo='git_push_branch_origin'
alias scw='source_control_open_site'
alias scwp='source_control_open_site -p'
alias scwm='BROWSER= gh pr view --web'
alias sgpt='sgitt -cp'
alias sgut='sgitt -u'
alias sgua='git_pull_all'
alias gcu='git_commit_update'
alias gua='git_pull_all'
alias s='begin; egit -p || egitn; end && sgitt -cp'

# `slug`
alias slpr='slug_project'
alias slpre='slug_project_edit'

# Edit
alias erm='eval $EDITOR README.md'
alias ecrm='eval $EMACS_COMMAND README.md'

# Tags
alias tags="generate_tags"

# Common
alias journal="$EDITOR ~/Text/journal/README.md"
alias tweet="markdown_tweet_edit"
alias qa="quick_text_search"
alias writing="$EDITOR ~/Text/writing/README.md"
alias backup="backup_file"
alias vs="vscode"
