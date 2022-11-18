# Bash Script
alias e='emacsclient_wrapper'
alias esk='emacs_kill_server'
alias esr='emacs_reset_server'
alias eg='emacs_grep'
alias vsr='vim_session_restore_auto'
alias gpbo='git_push_branch_origin'
alias scwp='source_control_open_site -p'
alias scwr='BROWSER= gh pr view --web'
alias gemacs="open -a emacs"
alias ox='fzf_project_xcode'
alias gua='git_pull_all'

# Tags
alias tags="generate_tags"

# Function
alias cdsc='sc_cd_root'
alias gu='ssh_start && git pull'
alias gp='ssh_start && git push'
alias gur='ssh_start && git pull -r'
alias d='$CD_COMMAND .'
alias rg='rg_custom'
alias foi='fish_edit_config'
alias fsa='fish_sync_abbr'
alias fu='fish_update'
alias u='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && fish_update'
alias ut='ssh_git_pull_all -t'
alias ua='ssh_git_pull_all'
if test -f "$HOME/.personal"
    alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto" && sgitt -cp'
else
    # Don't automatically commit on non-personal machines
    alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto"; sgitt -p'
end
