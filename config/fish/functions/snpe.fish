function snpe
    set -l cmd "fd --follow"
    set -l commandline (commandline)

    cd ~/Developer/Snippets || return 1
    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        eval $EDITOR $result
        cd -
    else if test -d "$result"
        cd $result
    else
        cd -
    end
end
