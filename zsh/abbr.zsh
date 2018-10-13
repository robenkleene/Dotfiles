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
'rgf' "$ACK_COMMAND -F"

# `tig`
'tst' 'tig stash'
'ts' 'tig status +3'
'tl' 'tig'

# `tmux`
# `tm`
'tmsw' 'tmux swap-window -t'
'tmwr' 'tmux move-window -r'
'tm' 'tmux' 
'tmb' 'tmux_banner'
'tmba' 'tmux_banner_all'
'tmls' 'tmux ls'
'tmsn' 'tmux new'
'tmd' 'tmux detach'

# `zsh`
'wf' 'whence -f'

# `safari`
'sfhs' 'fzf_safari_history_open'

# `swiftlint`
'm' 'make'

# `hub`
'hpr' 'hub pull-request'

# `cat`
'c' 'cat'
'b' 'bat'

# `xargs`
'0fd' 'fd -0'
'0v' "xargs -0 $VIM_COMMAND"

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
'gms' 'git merge --squash'
'gmt' 'git mergetool'
# `gp`: `git push`
'gp' 'git push'
'gpt' 'git push --tags'
'gpbo' 'git_push_branch_origin'
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
'gw' 'git_web_open'
'glg' 'git log -p -G'
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

_magic_abbrev_expand() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#^}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

_magic_abbrev_expand_and_insert() {
  _magic_abbrev_expand
  zle self-insert
}

_magic_abbrev_expand_and_accept() {
  _magic_abbrev_expand
  zle accept-line
}

zle -N _magic_abbrev_expand_and_insert
zle -N _magic_abbrev_expand_and_accept
bindkey " "   _magic_abbrev_expand_and_insert
bindkey "\r"  _magic_abbrev_expand_and_accept
# Use original bindings in isearch
bindkey -M isearch " " self-insert
bindkey -M isearch "\r" accept-line
