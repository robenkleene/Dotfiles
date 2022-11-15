function fish_sync_abbr
    # This doesn't work
    # set --erase fish_user_abbreviations
    for a in (abbr --list)
        abbr --erase $a
    end
    abbr -a -- - 'cd -'
    abbr -a oR 'open -R'
    abbr -a ts 'tig status +3'
    abbr -a hpr 'hub pull-request'
    abbr -a hprm 'hub pull-request -m'
    abbr -a ghpr 'gh pr create'
    abbr -a hprr 'hub pull-request && BROWSER= gh pr view --web'
    abbr -a brm 'bat README.md'
    abbr -a g git
    abbr -a ga 'git add'
    abbr -a gaa 'git add -A :/'
    abbr -a gaac 'git add -A :/ && git commit'
    abbr -a gaacm 'git add -A :/ && git commit -m'
    abbr -a gb 'git branch'
    abbr -a gc 'git commit'
    abbr -a gcm 'git commit -m'
    abbr -a gcl 'git clone'
    abbr -a gco 'git checkout'
    abbr -a gcob 'git checkout -b'
    abbr -a gd 'git diff'
    abbr -a gdw 'git diff --color-words'
    abbr -a gl 'git log'
    abbr -a gm 'git merge'
    abbr -a gs 'git status'
    abbr -a gsm 'git submodule'
    abbr -a gsmi 'git submodule init'
    abbr -a gsmu 'git submodule update'
    abbr -a gsmuir 'git submodule update --init --recursive'
    abbr -a gsmuirr 'git submodule update --init --recursive --remote'
    abbr -a gst 'git stash'
    abbr -a gt 'git tag'
    abbr -a git_log_grep 'git log -p -G'
    abbr -a gsh 'git show'
    abbr -a gbl 'git blame'
    abbr -a gitcleanup 'git checkout -- . && git clean -dff'
    abbr -a git_diff_relative 'git diff --relative'
    abbr -a git_commit_amend 'git commit --amend'
    abbr -a git_remote_print 'git ls-remote --get-url'
    abbr -a git_revision_print 'git rev-parse HEAD'
    abbr -a chu 'carthage update'
    abbr -a chunub 'carthage update --no-use-binaries'
    abbr -a chunubm 'carthage update --no-use-binaries --platform macos'
    abbr -a chb 'carthage bootstrap'
    abbr -a agv_marketing_version 'agvtool what-marketing-version'
    abbr -a agv_new_marketing_version 'agvtool new-marketing-version'
    # Use `gemacs` for graphical Emacs
    abbr -a emacs 'emacs -nw'
    # abbr -a e "$EMACS_COMMAND"
    # abbr -a ec "$EMACS_COMMAND"
    # abbr -a mba 'mbsync -all --verbose'
    abbr -a wd web_deploy
    abbr -a bundle_install_local 'bundle install --path vendor/bundle'
    # Fish
    abbr -a fhm 'history merge'
    abbr -a fke 'echo $fish_killring[1]'
    # Mercurial
    abbr -a hg_diff_relative 'hg diff --root .'
    abbr -a hg_diff_bottom 'hg diff -r "bottom^"'
    abbr -a hg_diff_stat 'hg diff --stat'
    # This wasn't showing added files
    # abbr -a hgdbf 'hg status --rev bottom -n'
    abbr -a hg_status_bottom_no_status 'hg status --change bottom --no-status'
    abbr -a hg_diff_last 'hg diff -pr .^1'
    abbr -a hg_diff_last_stat 'hg diff -pr .^1 --stat'
    abbr -a hgd 'hg diff'
    abbr -a hgcm 'hg commit -m'
    abbr -a hgs 'hg status'
    abbr -a hgsv 'hg shelve'
    abbr -a hgsvu 'hg unshelve'
    abbr -a hg_import_no_commit 'hg import --prefix . --no-commit -'
    abbr -a hgu 'hg update'
    abbr -a hgsh 'hg show'
    abbr -a hg_show_stat 'hg show --stat'
    abbr -a hgrm 'hg resolve --mark'
    abbr -a hgcleanup 'hg purge && hg checkout --clean . && hg status'
    # New
    abbr -a tr_line_ending "tr -d '\n'"
    # Fish
    abbr -a fsi "source ~/.config/fish/config.fish"
    # Rust
    abbr -a cgrb "cargo run --bin"

    # Local
    if test -f ~/.local_abbr.fish
        source ~/.local_abbr.fish
    end
end
