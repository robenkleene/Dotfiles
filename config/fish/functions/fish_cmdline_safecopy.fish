function fish_cmdline_safecopy
    set -l cmdline (commandline --current-selection | string collect)
    test -n "$cmdline"; or set cmdline (commandline | string collect)
    printf '%s' $cmdline | ~/.bin/safecopy
end
