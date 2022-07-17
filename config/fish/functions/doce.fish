function doce
    set -l cmd "fd --follow \"^[^.]+\\\$|.*\\.md\""
    set -l commandline (commandline)

    cd ~/Documentation/
    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        $EDITOR $result
        cd -
    else if test -d "$result"
        cd $result
        $EDITOR .
    else
        cd -
    end
end
