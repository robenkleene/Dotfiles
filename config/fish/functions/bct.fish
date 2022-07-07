function bct --argument-names 'term'
    if test -z "$term"
        set term "."
    end
    set -l cmd "fd --type f $term ~/Documents/Text/Notes/Bucket"
    set -l commandline (commandline)

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -e "$result"
        set -l result_path (string escape "$result")
        cat "$result_path" | ~/.bin/urls -b | ~/.bin/url_open
    end
end

