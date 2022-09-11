function doce
    set -l cmd "fd --follow \"^[^.]+\\\$|.*\\.md\""
    set -l commandline (commandline)
    set -q MD_EDITOR || set MD_EDITOR $EDITOR

    cd ~/Documentation/
    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        eval $MD_EDITOR $result
        cd -
    else if test -d "$result"
        cd $result
    else
        cd -
    end
end
