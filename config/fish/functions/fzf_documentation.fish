function fzf_documentation
    cd ~/Documentation/
    set -l cmd "fd --exclude .git --exclude .DS_Store"
    begin
        eval "$cmd | "(__fzfcmd) | read -l result
        if test -n "$result"
            # Convert to absolute path so we can go to previous directory
            # before cd so ~/Documentation doesn't end up on the directory
            # stack
            set -l result_path (realpath "$result")
            if test -d "$result_path"
                cd -
                cd $result_path
                return
            else if test -f "$result"
                eval "$BAT_COMMAND $result"
            end
        end
    end
    cd -
end

