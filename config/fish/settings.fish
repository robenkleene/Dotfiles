set fish_escape_delay_ms 200

# Implement `!!`
function bangbang --on-event fish_postexec
    alias !!="$argv[1]"
end

