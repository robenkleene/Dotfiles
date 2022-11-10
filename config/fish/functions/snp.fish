function snp
    set -l cmd "fd --follow --type f"
    set -l commandline (commandline)

    cd ~/Developer/Snippets || return 1
    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        eval $CAT_COMMAND $result
    end
    cd -
end
