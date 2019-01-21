# Don't use `^s` `^q` for freeze and resume
unsetopt flowcontrol

# Don't exit the shell with `^d`
setopt ignore_eof
# Use `emacs` bindings
bindkey -e

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

# Clipboard
_system_kill_word() {
  zle kill-word
  echo "$CUTBUFFER" | safecopy
}
zle -N _system_kill_word
autoload -Uz select-word-style
_system_bash_backwards_kill_word() {
  # Use bash-style `backwards-kill-word`
  select-word-style bash
  WORDCHARS='*?[]~\!#$%^(){}<>|`@#$%^*()+:?' zle backward-kill-word
  select-word-style normal
  echo "$CUTBUFFER" | safecopy
}
zle -N _system_bash_backwards_kill_word
_system_copy_region_as_kill() {
  zle copy-region-as-kill
  zle set-mark-command -n -1
  echo "$CUTBUFFER" | safecopy
}
zle -N _system_copy_region_as_kill
_system_kill_region_or_backward_kill_word() {
  if [[ "$REGION_ACTIVE" -eq 0 ]]; then
    zle _system_backward_kill_word
  else
    zle _system_kill_region
  fi
}
zle -N _system_kill_region_or_backward_kill_word
_system_kill_region_or_backward_delete_char() {
  if [[ "$REGION_ACTIVE" -eq 0 ]]; then
    zle backward-delete-char
  else
    zle _system_kill_region
  fi
}
zle -N _system_kill_region_or_backward_delete_char
_system_kill_region() {
  zle kill-region
  echo "$CUTBUFFER" | safecopy
}
zle -N _system_kill_region
_system_backward_kill_word() {
  zle backward-kill-word
  echo "$CUTBUFFER" | safecopy
}
zle -N _system_backward_kill_word
_system_yank() {
  if [[ "$REGION_ACTIVE" -eq 1 ]]; then
    zle kill-region
  fi
  CUTBUFFER=$(safepaste)
  zle yank
}
zle -N _system_yank
bindkey -e '\ed' _system_kill_word
bindkey -e '\eD' _system_kill_word
bindkey -e '\ew' _system_copy_region_as_kill
# bindkey -e '^W' _system_backward_kill_word
# bindkey -e '^W' _system_kill_region
bindkey -e '^H' _system_kill_region_or_backward_delete_char
bindkey -e '^?' _system_kill_region_or_backward_delete_char
bindkey -e '^W' _system_kill_region_or_backward_kill_word
bindkey -e '^Y' _system_yank
bindkey -e "^[^?" _system_bash_backwards_kill_word
bindkey -e "^[^H" _system_bash_backwards_kill_word
