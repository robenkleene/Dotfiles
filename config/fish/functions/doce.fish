function doce
    set -l cmd "fd --follow \"^[^.]+\\\$|.*\\.md\""
    set -l commandline (commandline)

    cd ~/Documentation/
    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        $EDITOR $result
    else if test -d "$result"
        cd $result
        $EDITOR .
    end
end
