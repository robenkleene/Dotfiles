function frq
    set -l cmd "fd --follow -g \"*.md\" ~/Text ~/Documentation"
    set -l commandline (commandline)

    eval "$cmd | "(__fzfcmd) | read -l result
    if test -f "$result"
        $EDITOR $result
    else if test -d "$result"
        cd $result
    end
end

