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
function __fish_describe_command; end
