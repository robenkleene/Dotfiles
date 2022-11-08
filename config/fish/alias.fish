# "alias --save" creates an autoloaded function for an alias, but there's no
# easy way to clean thes up later. E.g., "function --erase" still leaves the
# file

# Use wrapper file instead because piping from an alias to vim doesn't allow
# backgrounding
# alias p='safepaste'
alias pv="safepaste | $VIM_COMMAND -"
alias ge='emacs_app'
alias ec='emacsclient_wrapper'
alias e='emacsclient_wrapper'
# alias va="xargs -o $VIM_COMMAND"
alias gemacs='emacs_app'

alias pe="$EMACS_COMMAND -nw -eval \"(robenkleene/new-clipboard)\""
# Override

# fd
# Display hidden files by default
# This doesn't work now because the `fzf` commands also add
# hidden, we should be able to add the `--hidden` flag twice in a
# future version of `fd` and we can uncomment this then.
# alias fd='fd --hidden'

# Fish
alias foi='fish_edit_config'
alias fsa='fish_sync_abbr'
alias fu='fish_update'

# Short
alias t='terminal_cd'
alias o='open_custom'
alias q='vim_grep'
alias dv='vim_diff'
alias rg='rg_custom'
alias ll='ls -lh'
alias la='ls -lhA'
alias l='ls -lhA'

alias u='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && fish_update'
alias ut='ssh_git_pull_all -t'
alias ua='ssh_git_pull_all'
alias pull='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && git_pull_all -t'
alias clip="safepaste | $VIM_COMMAND -"
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
alias esk='emacs_kill_server'
alias esr='emacs_reset_server'
alias eg='emacs_grep'

# TUI change dir
alias d='$CD_COMMAND .'

# `vim`
alias vsr='vim_session_restore_auto'
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
alias grtao='git_remote_add_origin'
alias gac='git_commit_all'
alias gacm='git_commit_all'
alias cdg='git_cd_root'
alias gbpr='git_branch_prune'
alias gpbo='git_push_branch_origin'
alias scwp='source_control_open_site -p'
alias scwr='BROWSER= gh pr view --web'
alias gcu='git_commit_update'
alias gua='git_pull_all'

# Edit
alias erm='eval $MD_EDITOR README.md'

# Tags
alias tags="generate_tags"

# Common
alias journal="$EDITOR ~/Text/journal/journal.md"
alias tweet="markdown_tweet_edit"
alias writing="$EDITOR ~/Text/writing/README.md"

# Mercurial
alias cdhg='hg_cd_root'

# Special
alias cdsc='sc_cd_root'
alias lt='time_log -t'
alias fmj='format_json'
alias ljr='launch_json_run'
