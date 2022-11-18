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
