# Enable tmux copy and paste on Linux
switch (uname)
    case Linux
        if test -n "$TMUX"
            function pbpaste
                safepaste
            end
            function pbcopy
                safecopy
            end
        end
end

# Temporary work around for slow autocomplete on macOS
function __fish_describe_command
end

# This delay allows `<ESC>` to be used as a replacement for the meta key
set fish_escape_delay_ms 200
