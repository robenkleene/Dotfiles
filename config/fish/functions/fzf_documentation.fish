function fzf_documentation
    cd ~/Documentation/
    set -l cmd "fd --exclude .git --exclude .DS_Store"
    begin
        eval "$cmd | "(__fzfcmd) | read -l result
        if test -n "$result"
            set -l result_path (realpath "$result")
            if test -d "$result_path"
                commandline "cd $result_path"
                commandline -f execute
            else if test -f "$result"
                commandline "$BAT_COMMAND $result_path"
                commandline -f execute
            end
        end
    end
    cd -
end

