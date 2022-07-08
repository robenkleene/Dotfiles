function bct --argument-names 'term'

    cd ~/Documents/Text/Notes/Bucket

    # set -l cmd
    # if test -z "$term"
    #     set cmd "fd --type f ."
    # else
    #     set cmd "rg \"$term\""
    # end
    set -l cmd "rg \"^\#\w+\""
    set -l commandline (commandline)
    eval "$cmd | "(__fzfcmd) | read -l result
    if test -e "$result"
        cat $result | ~/.bin/url_open
    end
end

