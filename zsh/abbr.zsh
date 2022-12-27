# These abbreviations only work as the first word of the command.
typeset -Ag abbreviations
abbreviations=(
'v' "$VIM_COMMAND"
'a' 'rg'
'b' 'bat'
'pq' "p | q"
'ts' 'tig status +3'
'tl' 'tig'
'mdv' 'mosh aresdev -- tmux attach'
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

# `emacs`
# `emacs` without `-nw` opens a new instance of Emacs and blocks the current
# terminal process until it exits, which is never what you want. If you want to
# open a file in the GUI version of Emacs, use `open -a "Emacs.app"`.
'emacs' 'emacs -nw'

# Mercurial
'hgd' 'hg diff'
'hgcm' 'hg commit -m'
'hgs' 'hg status'
)

# Support local abbr created in `~/.zshrc_local`
if [[ -n "${LOCAL_ABBREVIATIONS-}" ]]; then
  for key value in ${(kv)LOCAL_ABBREVIATIONS-}; do
    abbreviations[key]=value
  done
fi

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

_magic_abbrev_expand_and_insert() {
  _magic_abbrev_expand
  zle self-insert
}
zle -N _magic_abbrev_expand_and_insert

_magic_abbrev_expand_and_accept() {
  _magic_abbrev_expand
  zle accept-line
}
zle -N _magic_abbrev_expand_and_accept

bindkey " "  _magic_abbrev_expand_and_insert
bindkey "\r" _magic_abbrev_expand_and_accept
# Use original bindings in isearch
bindkey -M isearch " " self-insert
bindkey -M isearch "\r" accept-line
