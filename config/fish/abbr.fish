# Try to only use abbreviations to fix shell history. E.g., `git log` is better
# than `g log`
# Common
abbr -a -- - 'cd -'
abbr -a v "$VIM_COMMAND"
abbr -a mdv 'mosh aresdev'
abbr -a ts 'tig status +3'
abbr -a tl 'tig'
abbr -a emacs 'emacs -nw'
# Git
abbr -a g git
# Mercurial
abbr -a hgd 'hg diff'
abbr -a hgs 'hg status'
abbr -a hgu 'hg update'
abbr -a hgsh 'hg show'
# Fish
abbr -a fhm 'history merge'

# Local
if test -f ~/.local_abbr.fish
    source ~/.local_abbr.fish
end
