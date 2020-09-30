function fzf_snippet_copy
    cd ~/Developer/Snippets/
    set -l cmd "fd --type f --exclude .git --exclude .DS_Store"
    begin
        eval "$cmd | "(__fzfcmd) | read -l result
        if test -n "$result"
            if test -f "$result"
                cat "$result" | safecopy
                eval "$BAT_COMMAND $result"
            end
        end
    end
    cd -
end
