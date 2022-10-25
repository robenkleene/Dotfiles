function doc
    set -l cmd "fd --follow \"^[^.]+\\\$|.*\\.md\""
    set -l commandline (commandline)

    cd ~/Documentation/
    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        eval $MD_CAT_COMMAND $result
        cd -
    else if test -d "$result"
        cd $result
    else
        cd -
    end
end
