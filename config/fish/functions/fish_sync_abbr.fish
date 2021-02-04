function fish_sync_abbr
    # This doesn't work
    # set --erase fish_user_abbreviations
    for a in (abbr --list)
        abbr --erase $a
    end

    abbr -a -- - 'cd -'
    abbr -a v "$VIM_COMMAND"
    abbr -a z "zsh"
    abbr -a vd "$VIM_COMMAND -d"
    abbr -a or 'open -R'
    abbr -a orm 'open README.md'
    abbr -a a "$ACK_COMMAND"
    abbr -a af "$ACK_COMMAND -F"
    abbr -a rgf "$ACK_COMMAND -F"
    abbr -a rgi "$ACK_COMMAND --no-ignore"
    abbr -a rgg "$ACK_COMMAND -g"
    abbr -a fdi "fd -I"
    abbr -a fdg "fd -g"
    abbr -a 0fd 'fd -0'
    abbr -a tst 'tig stash'
    abbr -a ts 'tig status +3'
    abbr -a tl 'tig'
    abbr -a tmsw 'tmux swap-window -t'
    abbr -a tmwr 'tmux move-window -r'
    abbr -a tm 'tmux'
    abbr -a tmb 'tmux_banner'
    abbr -a tmls 'tmux ls'
    abbr -a tmsn 'tmux new'
    abbr -a tmd 'tmux detach'
    abbr -a m 'make'
    abbr -a hpr 'hub pull-request'
    abbr -a ghpr 'gh pr create'
    abbr -a hprm 'hub pull-request && BROWSER= gh pr view --web'
    abbr -a c 'cat'
    abbr -a r 'clear'
    abbr -a b 'bat'
    abbr -a brm 'bat README.md'
    abbr -a prm 'open -a "Repla" README.md'
    abbr -a g 'git'
    abbr -a ga 'git add'
    abbr -a gaa 'git add -A :/'
    abbr -a gaac 'git add -A :/ && git commit'
    abbr -a gb 'git branch'
    abbr -a gbum 'git branch --set-upstream-to=origin/master master'
    abbr -a gbr 'git branch -r'
    abbr -a gc 'git commit'
    abbr -a gca 'git commit --amend'
    abbr -a gcam 'git commit --amend -m'
    abbr -a gcm 'git commit -m'
    abbr -a gcl 'git clone'
    abbr -a gcs 'git clone --depth 1'
    abbr -a gcn 'git clean'
    abbr -a gcp 'git cherry-pick'
    abbr -a gcpc 'git cherry-pick --continue'
    abbr -a gco 'git checkout'
    abbr -a gcob 'git checkout -b'
    abbr -a gd 'git diff'
    abbr -a gdr 'git diff --relative'
    abbr -a gdt 'git difftool'
    abbr -a gdv 'git diff --relative | diff-to-grep | vg'
    abbr -a gdw 'git diff --color-words'
    abbr -a gdfu 'git diff --name-only --diff-filter=U'
    abbr -a gf 'git fetch'
    abbr -a gl 'git log'
    abbr -a gm 'git merge'
    abbr -a gms 'git merge --squash'
    abbr -a gmt 'git mergetool'
    abbr -a gp 'git push'
    abbr -a gls 'git ls-files'
    abbr -a glsm 'git ls-files -m'
    abbr -a gpt 'git push --tags'
    abbr -a gr 'git rebase'
    abbr -a grc 'git rebase --continue'
    abbr -a grs 'git rebase --skip'
    abbr -a grph 'git rev-parse HEAD'
    abbr -a grphc "git rev-parse HEAD | tr -d '\n' | c"
    abbr -a gs 'git status'
    abbr -a gsm 'git submodule'
    abbr -a gsmi 'git submodule init'
    abbr -a gsmu 'git submodule update'
    abbr -a gsmuir 'git submodule update --init --recursive'
    abbr -a gsmuirr 'git submodule update --init --recursive --remote'
    abbr -a gst 'git stash'
    abbr -a gstl 'git stash list'
    abbr -a gstp 'git stash pop'
    abbr -a gt 'git tag'
    abbr -a gu 'git pull'
    abbr -a gur 'git pull -r'
    abbr -a glg 'git log -p -G'
    abbr -a gdns 'git diff --name-status'
    abbr -a gsh 'git show'
    abbr -a gg 'git grep'
    abbr -a chu 'carthage update'
    abbr -a chunub 'carthage update --no-use-binaries'
    abbr -a chb 'carthage bootstrap'
    abbr -a agvm 'agvtool what-marketing-version'
    abbr -a agvmn 'agvtool new-marketing-version'
    # Use `gemacs` for graphical Emacs
    abbr -a emacs 'emacs -nw'
    abbr -a e "$EMACS_COMMAND"
    abbr -a ec "$EMACS_COMMAND"
    abbr -a mba 'mbsync -all --verbose'
    abbr -a rps 'repla server'
    abbr -a rpj 'repla server "bundle exec jekyll serve --watch --drafts --port 4001" -r "...done"'
    abbr -a wd 'web_deploy'
    abbr -a wdd 'web_deploy -s aresdev'
    abbr -a bil 'bundle install --path vendor/bundle'
    abbr -a hm 'history merge'
    abbr -a re 'grep'
    abbr -a rei 'grep -i'
end
