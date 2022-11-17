# "alias --save" creates an autoloaded function for an alias, but there's no
# easy way to clean thes up later. E.g., "function --erase" still leaves the
# file

# Use wrapper file instead because piping from an alias to vim doesn't allow
# backgrounding
# alias p='safepaste'
alias pv="safepaste | $VIM_COMMAND -"
alias pq="safepaste | vim_grep"
alias e='emacsclient_wrapper'

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

alias u='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && fish_update'
alias ut='ssh_git_pull_all -t'
alias ua='ssh_git_pull_all'
alias pull='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && git_pull_all -t'
if test -f "$HOME/.personal"
    alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto" && sgitt -cp'
else
    # Don't automatically commit on non-personal machines
    alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto"; sgitt -p'
end

# `make`
alias mt='make test'
alias ml='make lint'
alias mac='make autocorrect'

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

# Xcode
switch (uname)
    case Darwin
        alias gemacs="open -a emacs"
        alias dirname='dirname_args'
        alias ox='fzf_project_xcode'
end

# `git`
alias gu='ssh_start && git pull'
alias gp='ssh_start && git push'
alias gur='ssh_start && git pull -r'
alias gpbo='git_push_branch_origin'
alias scwp='source_control_open_site -p'
alias scwr='BROWSER= gh pr view --web'

# Tags
alias tags="generate_tags"

# Special
alias cdsc='sc_cd_root'
