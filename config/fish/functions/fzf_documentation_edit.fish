function fzf_documentation_edit
    cd ~/Documentation/
    set -l cmd "fd --exclude .git --exclude .DS_Store"
    begin
        eval "$cmd | "(__fzfcmd) | read -l result
        if test -n "$result"
            set -l result_path (string escape (realpath "$result"))
            if test -e "$result_path"
                commandline "$VIM_COMMAND $result_path"
                commandline -f execute
            end
        end
    end
    cd -
end
