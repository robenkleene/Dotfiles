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
  # Try `EDITOR` if `VISUAL` isn't working
  VISUAL="$VIM_COMMAND -c 'DisableBackgrounding'" zle edit-command-line
}
zle -N _custom_edit_command_line
# bindkey "^X^E" _custom_edit_command_line
# Fish style edit line
bindkey '\ev' _custom_edit_command_line
# bindkey "^X^E" edit-command-line

# `_complete_help` is supposed have this default binding, but for some reason
# it's missing
bindkey "^Xh" _complete_help
# bindkey '\ee' edit-command-line

# By default, `^u` kills the whole line, rather than backwards
# bindkey "^U" backward-kill-line
bindkey "^U" _system_backward_kill_line
bindkey "^K" _system_kill_line

# Menu Select
# Load the `menuselect` map first
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Clipboard
use_kill_ring="false"

_system_kill_line() {
  zle kill-line
  if [[ "$use_kill_ring" == "true" ]]; then
    echo -n "$CUTBUFFER" | safecopy
  fi
}
zle -N _system_kill_line
_system_backward_kill_line() {
  zle backward-kill-line
  if [[ "$use_kill_ring" == "true" ]]; then
    echo -n "$CUTBUFFER" | safecopy
  fi
}
zle -N _system_backward_kill_line
_system_kill_word() {
  zle kill-word
  if [[ "$use_kill_ring" == "true" ]]; then
    echo -n "$CUTBUFFER" | safecopy
  fi
}
zle -N _system_kill_word
autoload -Uz select-word-style
# Word style "bash" stops at most word separators 
DEFAULT_WORD_STYLE="bash"
select-word-style $DEFAULT_WORD_STYLE
_system_bash_backwards_kill_word() {
  # Use bash-style "backwards-kill-word", this provides expected separation
  # between "^W" and "^DEL"
  select-word-style bash
  WORDCHARS='*?[]~\!#$%^(){}<>|`@#$%^*()+:?' zle backward-kill-word
  select-word-style $DEFAULT_WORD_STYLE
  if [[ "$use_kill_ring" == "true" ]]; then
    echo -n "$CUTBUFFER" | safecopy
  fi
}
zle -N _system_bash_backwards_kill_word
_system_copy_region_as_kill() {
  zle copy-region-as-kill
  zle set-mark-command -n -1
  echo -n "$CUTBUFFER" | safecopy
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
    zle kill-region
    if [[ "$use_kill_ring" == "true" ]]; then
      echo -n "$CUTBUFFER" | safecopy
    fi
  fi
}
zle -N _system_kill_region_or_backward_delete_char
_system_kill_region() {
  zle kill-region
  echo -n "$CUTBUFFER" | safecopy
}
zle -N _system_kill_region
_system_backward_kill_word() {
  # Selecting "shell" makes `backward-kill-word` delete the entire last
  # parameter
  select-word-style shell
  zle backward-kill-word
  select-word-style $DEFAULT_WORD_STYLE
  if [[ "$use_kill_ring" == "true" ]]; then
    echo -n "$CUTBUFFER" | safecopy
  fi
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

_system_copy() {
  if [[ "$REGION_ACTIVE" -eq 1 ]]; then
    zle kill-region
  fi
  CUTBUFFER=$(safepaste)
  zle yank
}
zle -N _system_yank

_system_copy() {
  echo -n "$LBUFFER" | safecopy
}
zle -N _system_copy

bindkey -e '\ed' _system_kill_word
bindkey -e '\eD' _system_kill_word
bindkey -e '\ew' _system_copy_region_as_kill
bindkey -e "^[^?" _system_bash_backwards_kill_word
bindkey -e "^[^H" _system_bash_backwards_kill_word
# bindkey -e '^W' _system_backward_kill_word
# bindkey -e '^W' _system_kill_region
bindkey -e '^H' _system_kill_region_or_backward_delete_char
bindkey -e '^?' _system_kill_region_or_backward_delete_char
bindkey -e '^W' _system_kill_region_or_backward_kill_word

# Emacs Style
bindkey -e '^Y' _system_yank
# Fish Style
# Don't use this, `^v` is used to show how the terminal is interpreting
# characters
# bindkey -e '^V' _system_yank
bindkey -e '^X' _system_copy


# Arrow Keys
bindkey -e '^[[1;5A' beginning-of-buffer-or-history
bindkey -e '^[[1;5B' end-of-buffer-or-history
bindkey -e '^[[1;5D' beginning-of-line
bindkey -e '^[[1;5C' end-of-line

# Restore regular bindings for `isearch`
bindkey -M isearch "^H" backward-delete-char
bindkey -M isearch "^?" backward-delete-char
bindkey -M isearch "^[^?" backward-kill-word
bindkey -M isearch "^[^H" backward-kill-word
bindkey -M isearch '^W' backward-kill-word
bindkey -M isearch '^U' backward-kill-line
bindkey -M isearch '^I' accept-search
