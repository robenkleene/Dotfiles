typeset -Ag abbreviations

# Abberviations should be used for native commands and functions that take
# parameters.

abbreviations=(
# vim
'v' "$VIM_COMMAND"
'vd' "$VIM_COMMAND -d"

# rg
'a' "$ACK_COMMAND"
'af' "$ACK_COMMAND -F"

# `tig`
'tst' 'tig stash'
'ts' 'tig status +3'

# `tmux`
# `tm`
'tmsw' 'tmux swap-window -t'
'tmwr' 'tmux move-window -r'
'tm' 'tmux' 
'tmb' 'tmux-banner'
'tmba' 'tmux-banner-all'
'tmls' 'tmux ls'
'tmsn' 'tmux new'
'tmd' 'tmux detach'

# `zsh`
'wf' 'whence -f'

# `safari`
'sfhs' 'fzf-safari-history-open'

# `swiftlint`
'mkl' 'make lint'


# `git`
# `g`: `git`
'g' 'git'
# `ga`: `git add`
'ga' 'git add'
'gaa' 'git add -A :/'
# `gb`: `git branch`
'gb' 'git branch'
# This is too dangerous, especially because it is easly confused with `git
# branch diff`
# 'gbd' 'git branch -d'
'gbpr' 'git remote prune origin'
'gbr' 'git branch -r'
# `gc`: `git commit`
'gc' 'git commit'
'gca' 'git commit --amend'
'gcam' 'git commit --amend -m'
'gcm' 'git commit -m'
# `gcl`: `git clone`
'gcl' 'git clone'
# `gcn`: `git clean`
'gcn' 'git clean'
# `gcp`: `git cherry-pick`
'gcp' 'git cherry-pick'
'gcpc' 'git cherry-pick --continue'
# `gco`: `git checkout`
'gco' 'git checkout'
'gcob' 'git checkout -b'
# `gd`: `git diff`
'gd' 'git diff'
'gdr' 'git diff --relative'
'gdt' 'git difftool'
'gdv' 'git diff --relative | diff-to-grep | vg'
'gdw' 'git diff --color-words'
'gdfu' 'git diff --name-only --diff-filter=U'
# `gf`: `git fetch`
'gf' 'git fetch'
# `gl`: `git log`
'gl' 'git log'
# `gm`: `git merge`
'gm' 'git merge'
'gmt' 'git mergetool'
# `gp`: `git push`
'gp' 'git push'
'gpt' 'git push --tags'
'gpbo' 'git-push-branch-origin'
# `gr`: `git rebase`
'gr' 'git rebase'
'grc' 'git rebase --continue'
'grs' 'git rebase --skip'
# `grp`: `git rev-parse`
'grph' 'git rev-parse HEAD'
'grphc' "git rev-parse HEAD | tr -d '\n' | c"
# `gs`: `git status`
'gs' 'git status'
# `gsm`: `git submodule`
'gsm' 'git submodule'
'gsmi' 'git submodule init'
'gsmu' 'git submodule update'
'gsmuir' 'git submodule update --init --recursive'
# `gst`: `git stash`
'gst' 'git stash'
'gstl' 'git stash list'
# `gt`: `git tag`
'gt' 'git tag'
# `gu`: `git pull`
'gu' 'git pull'
'gur' 'git pull -r'
# `gw`: `git web`
'gw' 'git-web-open'
)

# if [ "$(uname)" = "Darwin" ]; then
# abbreviations+=(
# )
# fi

# Make alias for each abbreviations, for syntax highlighting, and executing
# command without parameters
for abbr in ${(@k)abbreviations}; do
  alias $abbr="${abbreviations[$abbr]}"
done

_magic-abbrev-expand() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#^}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

_magic-abbrev-expand-and-insert() {
  _magic-abbrev-expand
  zle self-insert
}

_magic-abbrev-expand-and-accept() {
  _magic-abbrev-expand
  zle accept-line
}

zle -N _magic-abbrev-expand-and-insert
zle -N _magic-abbrev-expand-and-accept
bindkey " "   _magic-abbrev-expand-and-insert
bindkey "\r"  _magic-abbrev-expand-and-accept
# Use original bindings in isearch
bindkey -M isearch " " self-insert
bindkey -M isearch "\r" accept-line
