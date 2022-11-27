# Abberviations should be used for either built-in commands or custom commands
# that take paramters.
# Otherwise just use aliases.

# These abbreviations only work as the first word of the command.
typeset -Ag abbreviations
abbreviations=(
'v' "$VIM_COMMAND"
'a' 'rg'
'b' 'bat'
'pq' "p | q"
'ts' 'tig status +3'
'mdv' 'mosh aresdev -- tmux attach'
'hpr' 'hub pull-request'
'hprm' 'hub pull-request -m'
'ghpr' 'gh pr create'
'hprr' 'hub pull-request && BROWSER= gh pr view --web'
'g' 'git'
# `ga`: `git add`
'gaac' 'git add -A :/ && git commit'
# `gb`: `git branch`
'gb' 'git branch'
'gco' 'git checkout'
'gcob' 'git checkout -b'
'gd' 'git diff'
'gdw' 'git diff --color-words'
'gs' 'git status'
'gsmuirr' 'git submodule update --init --recursive --remote'
'glg' 'git log -p -G'

# Carthage
'chunub' 'carthage update --no-use-binaries'

# `agvtool`
'agvm' 'agvtool what-marketing-version'
'agvmn' 'agvtool new-marketing-version'

# `emacs`
# `emacs` without `-nw` opens a new instance of Emacs and blocks the current
# terminal process until it exits, which is never what you want. If you want to
# open a file in the GUI version of Emacs, use `open -a "Emacs.app"`.
'emacs' 'emacs -nw'
'e' "$EMACS_COMMAND"

# Mercurial
'hgd' 'hg diff'
'hgcm' 'hg commit -m'
'hgs' 'hg status'
'hgsrb' 'hg status --rev bottom'
)

if [[ -n "${LOCAL_ABBREVIATIONS-}" ]]; then
  for key value in ${(kv)LOCAL_ABBREVIATIONS-}; do
    abbreviations[key]=value
  done
fi

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
