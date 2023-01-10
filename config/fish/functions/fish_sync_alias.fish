# Any aliases removed should be deleted manually
function fish_sync_alias
    alias --save cdsc='sc_cd_root'
    alias --save gu='ssh_start && git pull'
    alias --save gp='ssh_start && git push'
    alias --save gur='ssh_start && git pull -r'
    alias --save d='$CD_COMMAND'
    alias --save de='emacs_cd'
    alias --save rg='rg_custom'
    alias --save foi='fish_edit_config'
    alias --save fsa='fish_sync_abbr'
    alias --save fu='fish_update'
    alias --save u='ssh_start && egit -u && ~/Developer/Dotfiles/update.sh && fish_update'
    alias --save ut='ssh_git_pull_all -t'
    alias --save ua='ssh_git_pull_all'
end
