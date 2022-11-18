function s
    if test -f "$HOME/.personal"
        ssh_start && begin; egit -p || egitn; end && echo "Auto" && sgitt -cp
    else
        # Don't automatically commit on non-personal machines
        ssh_start && begin; egit -p || egitn; end && echo "Auto"; sgitt -p
    end
end
