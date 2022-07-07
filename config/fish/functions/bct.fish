function bct
    set -l cmd "fd --type f . ~/Documents/Text/Notes/Bucket"
    set -l commandline (commandline)

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -d "$result"
        set -l result_path (string escape "$result")
        cd $result_path
    end
end

