# "alias --save" creates an autoloaded function for an alias, but there's no
# easy way to clean thes up later. E.g., "function --erase" still leaves the
# file

# Use wrapper file instead because piping from an alias to vim doesn't allow
# backgrounding
# alias p='safepaste'
alias y='safecopy'
alias pv="safepaste | $VIM_COMMAND -"
alias safecopy1='tr -d '\''\n'\'' | tee /dev/tty | safecopy'
alias ge='emacs_app'
alias ec='emacsclient_wrapper'
alias e='emacsclient_wrapper'
# alias va="xargs -o $VIM_COMMAND"
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
alias fsa='fish_sync_abbr'

# Short
alias t='terminal_cd'
alias o='open_custom'
alias q='vim_grep'
alias dv='vim_diff'
alias dq='vim_diff_grep'
alias vt='vim_tag'
alias ve='vim -c Files'
alias vc='vim -c Cd'
alias va='vim -c RG'
alias vs='diff_status | vim -'
alias l='less -RFX'
alias rg='rg_custom'
alias u='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && fish_update'
alias ut='ssh_git_pull_all -t'
alias ua='ssh_git_pull_all'
alias pull='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && git_pull_all -t'
alias clip='safepaste | vim -'
alias ch='clipboard_history'
if test -f "$HOME/.personal"
    alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto" && sgitt -cp'
else
    # Don't automatically commit on non-personal machines
    alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto"; sgitt -p'
end

# Special
switch (uname)
    case Darwin
        alias dirname='dirname_args'
end

# `ssh`
alias shs='ssh_start'

# `tmux`
alias tma='tmux attach'
alias tmnd='tmux_name_directory'
alias tmsr='tmux_session_auto_restore_ssh'
alias tmsq='tmux_session_auto_save_quit'
# alias tmp='tmux_paths'
# alias tmpa='tmux_paths -a'
alias tmc='tmux_paths_run'
alias tmack='tmux_paths_rg'
alias tmgs='tmux_git_status'
alias tmssdw='tmux_session_save_dropbox_work'
alias tmba='tmux_banner_all'
alias tmn='tmux_shell_new'
alias tmr='tmux_restart'
alias tmp='tmux_yank_paste'

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
alias eks='emacs_kill_server'
alias ers='emacs_reset_server'

# `vim_cd`
alias d='vim_cd'
alias v='vim_cd'

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
alias lnk='fzf_link_open'
alias dev='fzf_developer'

# Test Variable
alias ptv='echo $test_variable'
# The `|| true` prevents an exit status of 1 if the output does not end in a
# new line
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
alias journal="$EDITOR ~/Text/journal/journal.md"
alias tweet="markdown_tweet_edit"
alias qa="quick_text_search"
alias writing="$EDITOR ~/Text/writing/README.md"

# Mercurial
alias cdhg='hg_cd_root'
alias hgf='hg status --rev ".^" | grep -v "^R" | cut -d\' \' -f2'
alias hgfb 'hg status --rev bottom^ | grep -v "^R" | cut -d\' \' -f2'

# Special
alias cdsc='sc_cd_root'
alias lt='time_log -t'
alias fmj='format_json'
alias lj='launch_json'
