# Use `emacs` bindings
bindkey -e

# Use bash-style `backwards-kill-word`
autoload -U select-word-style
bash-backward-kill-word() {
  select-word-style bash
  zle backward-kill-word
  select-word-style normal
}
zle -N bash-backward-kill-word
bindkey "^[^?" bash-backward-kill-word

# Edit in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
