function fish_sync_alias
    # After adding an alias, run `fish_sync_alias` to generate the functions
    # Any aliases removed need to be deleted manually!
    alias --save gu='ssh_start && git pull'
    alias --save gp='ssh_start && git push'
    alias --save gur='ssh_start && git pull -r'
    # These need the trailing `.` so they can be run without arguments to open
    # the current directory
    alias --save d='$CD_COMMAND .'
    alias --save ecd='emacs_cd .'
    alias --save rg='rg_custom'
    alias --save foi='fish_edit_config'
    alias --save u='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && fish_update'
    alias --save ut='ssh_git_pull_all -t'
    alias --save ua='ssh_git_pull_all'
end
