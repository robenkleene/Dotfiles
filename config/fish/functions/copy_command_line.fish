function copy_command_line
    set -l cmdline
    if isatty stdin
        # Copy the current selection, or the entire commandline if that is empty.
        # Don't use `string collect -N` here - `commandline` adds a newline.
        set cmdline (commandline --current-selection | string collect)
        test -n "$cmdline"; or set cmdline (commandline | string collect)
    else
        # Read from stdin
        while read -lz line
            set -a cmdline $line
        end
    end

    printf '%s' $cmdline | ~/.bin/safecopy
end
