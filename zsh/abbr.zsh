# These abbreviations only work as the first word of the command.
typeset -Ag abbreviations
abbreviations=(
'v' "$VIM_COMMAND"
'g' 'git'
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
