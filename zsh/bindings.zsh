# Don't use `^s` `^q` for freeze and resume
unsetopt flowcontrol

# Don't exit the shell with `^d`
setopt ignore_eof
# Use `emacs` bindings
bindkey -e

# Use bash-style `backwards-kill-word`
autoload -Uz select-word-style
bash-backward-kill-word() {
  select-word-style bash
  WORDCHARS='*?[]~\!#$%^(){}<>|`@#$%^*()+:?' zle backward-kill-word
  select-word-style normal
}
zle -N bash-backward-kill-word
bindkey "^[^?" bash-backward-kill-word
bindkey "^[^H" bash-backward-kill-word
# Edit in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
# bindkey '\ee' edit-command-line

# By default, `^u` kills the whole line, rather than backwards
bindkey "^U" backward-kill-line

# Menu Select
# Load the `menuselect` map first
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete
