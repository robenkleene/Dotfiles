typeset -Ag abbreviations

abbreviations=(
# vim
"v" "$VIM_COMMAND"
# rg
"a" "$ACK_COMMAND"
"av" "ack-vim"
"af" "fzf-ack-vim"
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
    zle self-insert
}

zle -N magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey -M isearch " " self-insert
