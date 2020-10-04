function fzf_snippet_copy
    cd ~/Developer/Snippets/
    set -l cmd "fd --type f --exclude .git --exclude .DS_Store"

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -n "$result"
        set -l result_path (string escape (realpath "$result"))
        if test -f "$result_path"
            cat "$result" | safecopy
            commandline "$BAT_COMMAND $result_path"
            commandline -f execute
        end
    end

    cd -
end
