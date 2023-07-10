function fish_sync_alias
    # After adding an alias, run `fish_sync_alias` to generate the functions
    # Any aliases removed need to be deleted manually!

    # git
    alias --save gu='ssh_start && git pull'
    alias --save gp='ssh_start && git push'
    alias --save gur='ssh_start && git pull -r'
    # egit
    alias --save u='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && fish_update'
    alias --save ut='ssh_start && ssh_git_pull_all -t'
    alias --save ua='ssh_start && ssh_git_pull_all'
    # fish
    alias --save foi='fish_edit_config'

    # Misc
    # These need the trailing `.` so they can be run without arguments to open
    # the current directory
    alias --save d='$CD_COMMAND .'
    alias --save ecd='emacs_cd .'
    alias --save rg='rg_custom'
    # Makes output compatible with Emacs `dired-virtual`
    # This breaks simple usages like `fd . <path>`
    # alias --save fd='fd --strip-cwd-prefix'
end
