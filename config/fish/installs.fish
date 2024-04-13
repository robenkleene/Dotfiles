if test -n "$INSIDE_EMACS"
    set -gx PAGER cat
    set -gx GIT_PAGER cat
end

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
