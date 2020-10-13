function egitn
    # The reason `egitn` has to be run seprately after `egit` is because the
    # second time running `egit` can't print except the path.
    set -l gitnext (~/.bin/egit -n)
    if test -n $gitnext
        cd "$gitnext"
        pwd
        git status
    end
end
