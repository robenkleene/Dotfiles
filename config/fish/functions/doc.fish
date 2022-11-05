function doc
    set -l cmd "fd --follow --type f \"^[^.]+\\\$|.*\\.md\""
    set -l commandline (commandline)

    cd ~/Documentation/ || return 1
    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        eval $MD_CAT_COMMAND $result
    end
    cd -
end
