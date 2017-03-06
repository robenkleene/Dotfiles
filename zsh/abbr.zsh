typeset -Ag abbreviations

abbreviations=(
# vim
"v" "$VIM_COMMAND"
# rg
"a" "$ACK_COMMAND"
"av" "ack-vim"
"af" "fzf-ack-vim"
# emacs
"e" "$EMACS_COMMAND"
"ec" "emacsclient -t"
# tig
"tst" "tig stash"
# tmux
"ta" "tmux-attach"
"tmsw" "tmux swap-window -t"
"t" "tmux" 
# vim
"vss" "vim-server-start"
"vse" "vim-server-edit"
# git
"ga" "git add"
"gb" "git branch"
"gbd" "git branch --delete"
"gc" "git commit"
"gcam" "git commit --amend -m"
"gcl" "git clone"
"gcm" "git commit -m"
"gco" "git checkout"
"gcob" "git checkout -b"
"gd" "git diff"
"gdt" "git difftool"
"gl" "git log"
"gm" "git merge"
"gr" "git rebase"
"gsm" "git submodule"
"gsta" "git-stash-apply"
"gstd" "git-stash-diff"
"gstl" "git stash list"
"gstp" "git-stash-pop"
"gsts" "git stash save"
"gstsh" "git-stash-show"
"gt" "git tag"
"gdw" "git diff --color-words"
# Carthage
"csmb" "carthage-submodule-bootstrap"
"csmu" "carthage-submodule-update"
)

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
