function fzf_documentation
    cd ~/Documentation/

    set -l cmd "fd --hidden --exclude .git --exclude .DS_Store"
    begin
        eval "$cmd | "(__fzfcmd) | read -l result
        if test -n "$result"
            if test -d "$result"
                cd $result
            else if test -f "$result"
                eval "$BAT_COMMAND $result"
            end
        end
    end
end

