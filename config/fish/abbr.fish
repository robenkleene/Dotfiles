# Try to only use abbreviations to fix shell history. E.g., `git log` is better
# than `g log`
# Common
abbr -a -- - 'cd -'
abbr -a v "$VIM_COMMAND"
abbr -a mdv 'mosh aresdev'
abbr -a emacs 'emacs -nw'
# Git
abbr -a g git
# Fish
abbr -a fhm 'history merge'
abbr -a printfv 'printf "%s\n"'

# Local
if test -f ~/.local_abbr.fish
    source ~/.local_abbr.fish
end
