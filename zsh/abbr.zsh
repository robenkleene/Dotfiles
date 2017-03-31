typeset -Ag abbreviations

# Abberviations should be used for native commands and functions that take
# parameters.

abbreviations=(
# vim
'v' "$VIM_COMMAND"
# rg
'a' "$ACK_COMMAND"
# emacs
'e' "$EMACS_COMMAND"
'ec' 'emacsclient -t'
# tig
'tst' 'tig stash'
'ts' 'tig status +3'
# tmux
'tmsw' 'tmux swap-window -t'
't' 'tmux' 
'tmls' 'tmux ls'
# vim
# git
'ga' 'git add'
'gb' 'git branch'
'gbd' 'git branch --delete'
'gc' 'git commit'
'gcam' 'git commit --amend -m'
'gcl' 'git clone'
'gcm' 'git commit -m'
'gco' 'git checkout'
'gcob' 'git checkout -b'
'gd' 'git diff'
'gdt' 'git difftool'
'gl' 'git log'
'gm' 'git merge'
'gr' 'git rebase'
'gmt' 'git mergetool'
'gsm' 'git submodule'
'gur' 'git pull --rebase'
'gu' 'git pull'
'gsmi' 'git submodule init'
'gsmu' 'git submodule update'
'gsmuir' 'git submodule update --init --recursive'
'gs' 'git status'
'grc' 'git rebase --continue'
'gpt' 'git push --tags'
'gp' 'git push'
'gf' 'git fetch'
'gaa' 'git add --all :/'
'gca' 'git commit --amend'
'gbr' 'git branch --remotes'
'gsta' 'git-stash-apply'
'gstd' 'git-stash-diff'
'gstl' 'git stash list'
'gstp' 'git-stash-pop'
'gsts' 'git stash save'
'gstsh' 'git-stash-show'
'gt' 'git tag'
'gdw' 'git diff --color-words'
'gbpr' 'git remote prune origin'
)

if [ "$(uname)" = "Darwin" ]; then
abbreviations+=(
"hb" "hub browse"
"hbc" "hub browse -- commits"
)
fi


# Make alias for each abbreviations, for syntax highlighting, and executing
# command without parameters
for abbr in ${(@k)abbreviations}; do
  alias $abbr="${abbreviations[$abbr]}"
done

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#^}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

magic-abbrev-expand-and-insert () {
    magic-abbrev-expand
    zle self-insert
}

magic-abbrev-expand-and-accept () {
    magic-abbrev-expand
    zle accept-line
}

zle -N magic-abbrev-expand-and-insert
zle -N magic-abbrev-expand-and-accept
bindkey " "   magic-abbrev-expand-and-insert
bindkey "\r"  magic-abbrev-expand-and-accept
# Use original bindings in isearch
bindkey -M isearch " " self-insert
bindkey -M isearch "\r" accept-line
