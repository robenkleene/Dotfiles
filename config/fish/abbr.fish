# Try to only use abbreviations to fix shell history. E.g., `git log` is better
# than `g log`
# Common
abbr -a -- - 'cd -'
# abbr -a printfv 'printf "%s\n"'

# Local
if test -f ~/.local_abbr.fish
    source ~/.local_abbr.fish
end
