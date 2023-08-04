function fish_sync_alias
    # After adding an alias, run `fish_sync_alias` to generate the functions
    # Any aliases removed need to be deleted manually!

    # git
    alias --save gits='ssh_start && git'
    # egit
    alias --save u='ssh_start && ~/.bin/egit_update'
    alias --save ut='ssh_start && ssh_git_pull_all -t'
    alias --save ua='ssh_start && ssh_git_pull_all'

    # Misc
    alias --save rg='rg_custom'
    # Makes output compatible with Emacs `dired-virtual`
    # This breaks simple usages like `fd . <path>`
    # alias --save fd='fd --strip-cwd-prefix'
end
