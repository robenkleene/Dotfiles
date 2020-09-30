function fzf_snippet_edit
    cd ~/Developer/Snippets/
    set -l cmd "fd --type f --exclude .git --exclude .DS_Store"
    begin
        eval "$cmd | "(__fzfcmd) | read -l result
        if test -n "$result"
            if test -f "$result"
                eval "$EDITOR $result"
            end
        end
    end
    cd -
end
