# Don't use `^s` `^q` for freeze and resume
unsetopt flowcontrol

# Don't exit the shell with `^d`
setopt ignore_eof
# Use `emacs` bindings
bindkey -e

# Use bash-style `backwards-kill-word`
autoload -Uz select-word-style
bash_backward_kill_word() {
  select-word-style bash
  WORDCHARS='*?[]~\!#$%^(){}<>|`@#$%^*()+:?' zle backward-kill-word
  select-word-style normal
}
zle -N bash_backward_kill_word
bindkey "^[^?" bash_backward_kill_word
bindkey "^[^H" bash_backward_kill_word
# Edit in editor
autoload -z edit-command-line
zle -N edit-command-line

_custom_edit_command_line() {
  EDITOR="$VIM_COMMAND -c 'DisableBackgrounding'" zle edit-command-line
}
zle -N _custom_edit_command_line
# bindkey "^X^E" edit-command-line
bindkey "^X^E" _custom_edit_command_line
# bindkey '\ee' edit-command-line

# By default, `^u` kills the whole line, rather than backwards
bindkey "^U" backward-kill-line

# Menu Select
# Load the `menuselect` map first
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete
