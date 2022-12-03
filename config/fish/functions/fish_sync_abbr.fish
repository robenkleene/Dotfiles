function fish_sync_abbr
    # This doesn't work
    # set --erase fish_user_abbreviations
    for a in (abbr --list)
        abbr --erase $a
    end

    abbr -a -- - 'cd -'
    abbr -a o 'open'
    abbr -a a 'rg'
    abbr -a v "$VIM_COMMAND"
    abbr -a b 'bat'
    abbr -a z 'zsh'
    abbr -a mdv 'mosh aresdev'
    abbr -a ts 'tig status +3'
    abbr -a emacs 'emacs -nw'
    # Git
    abbr -a g git
    abbr -a gaa 'git add -A :/'
    abbr -a gaac 'git add -A :/ && git commit'
    abbr -a gb 'git branch'
    abbr -a gc 'git commit'
    abbr -a gco 'git checkout'
    abbr -a gcob 'git checkout -b'
    abbr -a gd 'git diff'
    abbr -a gdw 'git diff --color-words'
    abbr -a gl 'git log'
    abbr -a gm 'git merge'
    abbr -a gs 'git status'
    abbr -a gsmuirr 'git submodule update --init --recursive --remote'
    abbr -a glg 'git log -p -G'
    abbr -a gsh 'git show'
    abbr -a gbl 'git blame'
    # Fish
    abbr -a fhm 'history merge'
    abbr -a fke 'echo $fish_killring[1]'
    # Mercurial
    abbr -a hgd 'hg diff'
    abbr -a hgcm 'hg commit -m'
    abbr -a hgs 'hg status'
    abbr -a hgsv 'hg shelve'
    abbr -a hgsvu 'hg unshelve'
    abbr -a hgu 'hg update'
    abbr -a hgsh 'hg show'
    abbr -a hgcleanup 'hg purge && hg checkout --clean . && hg status'
    # Fish
    abbr -a fsi "source ~/.config/fish/config.fish"

    # Local
    if test -f ~/.local_abbr.fish
        source ~/.local_abbr.fish
    end
end
