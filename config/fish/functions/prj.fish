function prj
    set -l cmd "fd --type d --max-depth 1 --follow . ~/Text/Projects"
    set -l commandline (commandline)

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -d "$result"
        set -l result_path (string escape "$result")
        cd $result_path
    end
end

