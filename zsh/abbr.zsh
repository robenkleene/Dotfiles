# Abberviations should be used for either built-in commands or custom commands
# that take paramters.
# Otherwise just use aliases.

# These abbreviations only work as the first word of the command.
typeset -Ag abbreviations
abbreviations=(
# vim
'v' "$VIM_COMMAND"
'vd' "$VIM_COMMAND -d"

# open
'or' 'open -R'
'orm' 'open README.md'

# rg
'a' "$ACK_COMMAND"
'af' "$ACK_COMMAND -F"
'rgf' "$ACK_COMMAND -F"
'rgi' "$ACK_COMMAND --no-ignore"

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
'tmls' 'tmux ls'
'tmsn' 'tmux new'
'tmd' 'tmux detach'

# `zsh`
'wf' 'whence -f'

# `swiftlint`
'm' 'make'

# `hub`
'hpr' 'hub pull-request'
# `gh`
'ghpr' 'gh pr create'
# Both
'hprm' 'hub pull-request && BROWSER= gh pr view --web'

# `cat`
'c' 'cat'
'b' 'bat'
'brm' 'bat README.md'
'prm' 'open -a "Repla" README.md'

# Clear
'r' 'clear'

# `xargs`
'0fd' 'fd -0'

# `git`
# `g`: `git`
'g' 'git'
# `ga`: `git add`
'ga' 'git add'
'gaa' 'git add -A :/'
'gaac' 'git add -A :/ && git commit'
# `gb`: `git branch`
'gb' 'git branch'
'gbum' 'git branch --set-upstream-to=origin/master master'
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
'gcs' 'git clone --depth 1'
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
'gsmuirr' 'git submodule update --init --recursive --remote'
# `gst`: `git stash`
'gst' 'git stash'
'gstl' 'git stash list'
'gstp' 'git stash pop'
# `gt`: `git tag`
'gt' 'git tag'
# `gu`: `git pull`
'gu' 'git pull'
'gur' 'git pull -r'
'glg' 'git log -p -G'

# Carthage
'chu' 'carthage update'
'chunub' 'carthage update --no-use-binaries'
'chb' 'carthage bootstrap'

# `agvtool`
'agvm' 'agvtool what-marketing-version'
'agvmn' 'agvtool new-marketing-version'

# `emacs`
# `emacs` without `-nw` opens a new instance of Emacs and blocks the current
# terminal process until it exits, which is never what you want. If you want to
# open a file in the GUI version of Emacs, use `open -a "Emacs.app"`.
'emacs' 'emacs -nw'
'e' "$EMACS_COMMAND"
'ec' "$EMACS_COMMAND"

# Mail
'mba' 'mbsync -all --verbose'

# Repla
'rps' 'repla server'
'rpj' 'repla server "bundle exec jekyll serve --watch --drafts --port 4001" -r "...done"'

# Web Deploy
'wd' 'web_deploy'
'wdd' 'web_deploy -s aresdev'

# Ruby
'bil' 'bundle install --path vendor/bundle'
'be' 'bundle exec'
)

# These abbreviations work everywhere
typeset -Ag everywhere_abbreviations
everywhere_abbreviations=(
'>n' '>/dev/null'
'>null' '>/dev/null'
'>o' '2>&1'
'>0' '2>&1 >/dev/null'
# Glob
# '-gcocoa' '-g "*.{h,m,swift}"'
# '-gruby' '-g "*.rb"'
# Carthage
'-nub' '--no-use-binaries'
# Jekyll
'-jl' '--config _config_local.yml'
'-jp' '--port 4000'
)

# Make alias for each abbreviations, for syntax highlighting, and executing
# command without parameters
for abbr in ${(@k)abbreviations}; do
  alias $abbr="${abbreviations[$abbr]}"
done

_magic_abbrev_expand() {
  local MATCH
  # Abbreviations
  LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#^}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

_magic_everywhere_abbrev_expand() {
  local MATCH
  # Everywhere Abbreviations
  LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9>-]#}
  if [[ -n "${everywhere_abbreviations[$MATCH]}" ]]; then
    LBUFFER+=${everywhere_abbreviations[$MATCH]:-$MATCH}
  # elif [[ -n "${abbreviations[$MATCH]}" ]]; then
  #   LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
  else
    LBUFFER+=$MATCH
    return 1
  fi
  LBUFFER+=" "
}

_magic_abbrev_expand_and_insert() {
  _magic_abbrev_expand
  zle self-insert
}

_magic_abbrev_expand_and_accept() {
  _magic_abbrev_expand
  zle accept-line
}

_magic_everywhere_abbrev_expand-or-complete() {
  if ! _magic_everywhere_abbrev_expand; then
    zle expand-or-complete
  fi
}

zle -N _magic_abbrev_expand_and_insert
zle -N _magic_abbrev_expand_and_accept
zle -N _magic_everywhere_abbrev_expand-or-complete
bindkey " "  _magic_abbrev_expand_and_insert
bindkey "\r" _magic_abbrev_expand_and_accept
bindkey "^I" _magic_everywhere_abbrev_expand-or-complete
# Use original bindings in isearch
bindkey -M isearch " " self-insert
bindkey -M isearch "\r" accept-line
