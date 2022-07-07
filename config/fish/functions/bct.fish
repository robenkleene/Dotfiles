function bct --argument-names 'term'
    if test -z "$term"
        set term "."
    end

    cd ~/Documents/Text/Notes/Bucket

    set -l cmd "fd --type f $term"
    set -l commandline (commandline)
    eval "$cmd | "(__fzfcmd) | read -l result
    if test -e "$result"
        cat $result | ~/.bin/url_open
    end
end

