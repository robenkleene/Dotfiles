function up_or_prefix_search --description 'Search back or move cursor up 1 line'
    # If we are already in search mode, continue
    if commandline --search-mode
        commandline -f history-prefix-search-backward
        return
    end

    # If we are navigating the pager, then up always navigates
    if commandline --paging-mode
        commandline -f up-line
        return
    end

    # We are not already in search mode.
    # If we are on the top line, start search mode,
    # otherwise move up
    set -l lineno (commandline -L)

    switch $lineno
        case 1
            if test "$(commandline -b)" = ""
                commandline -f history-prefix-search-backward
            else
                # Run this twice to simulate the default `up-or-search` skipping
                # the current completion match
                #commandline -f history-prefix-search-backward history-prefix-search-backward
                # Don't seach backwards twice, this makes it easier to run the
                # previous command with a prefix with `<prefix><up>` which is
                # how much command lines work
                commandline -f history-prefix-search-backward
            end

        case '*'
            commandline -f up-line
    end
end
