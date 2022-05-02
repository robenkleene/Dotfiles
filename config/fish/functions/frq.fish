function frq
    set -l cmd "fd --type f --follow . ~/Text ~/Documentation"
    set -l commandline (commandline)

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        $EDITOR $result
    end
end

