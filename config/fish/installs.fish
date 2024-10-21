if set -q HOMEBREW_DIR
    if not contains $HOMEBREW_DIR/share/man $MANPATH
        set -q MANPATH || set -gx MANPATH ''
        set -gx MANPATH $MANPATH $HOMEBREW_DIR/share/man
    end
    if not contains $HOMEBREW_DIR/share/info $INFOPATH
        set -q INFOPATH || set -gx INFOPATH ''
        set -gx INFOPATH $INFOPATH $HOMEBREW_DIR/share/info
    end
end

if not contains $HOME/.man $MANPATH
    set -q MANPATH || set -gx MANPATH ''
    set -gx MANPATH $MANPATH $HOME/.man
end

# fzf
if test -e $HOMEBREW_DIR/opt/fzf/shell/key-bindings.fish
    source $HOMEBREW_DIR/opt/fzf/shell/key-bindings.fish
    status is-interactive; and fzf_key_bindings
end
