function fzf_documentation_edit
    cd ~/Documentation/
    set -l cmd "fd --exclude .git --exclude .DS_Store"
    begin
        eval "$cmd | "(__fzfcmd) | read -l result
        if test -n "$result"
            if test -e "$result"
                eval "$EDITOR $result"
            end
        end
    end
    cd -
end
