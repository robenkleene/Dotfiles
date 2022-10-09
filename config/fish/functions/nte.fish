function nte
    set -l cmd "fd --follow \"^[^.]+\\\$|.*\\.md\" ~/Text ~/Documentation"
    set -l commandline (commandline)
    set -q MD_EDITOR || set MD_EDITOR $EDITOR

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        eval $MD_EDITOR $result
    else if test -d "$result"
        cd $result
    end
end
