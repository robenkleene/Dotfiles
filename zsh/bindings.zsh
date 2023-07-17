# Don't use `^s` `^q` for freeze and resume
unsetopt flowcontrol

# Don't exit the shell with `^d`
setopt ignore_eof
# Use `emacs` bindings
bindkey -e

# Edit in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

_reveal() {
  open .
}
zle -N _reveal
bindkey '\er' _reveal

# `_complete_help` is supposed have this default binding, but for some reason
# it's missing
bindkey "^Xh" _complete_help

# By default, `^u` kills the whole line, rather than backwards
bindkey "^U" backward-kill-line

# Menu Select
# Load the `menuselect` map first
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

autoload -Uz select-word-style
# Word style "bash" stops at most word separators
default_word_style="bash"
select-word-style $default_word_style

_bash_backward_kill_word() {
  # Use bash-style "backwards-kill-word", this provides expected separation
  # between "^W" and "^DEL"
  select-word-style bash
  WORDCHARS='*?[]~\!#$%^(){}<>|`@#$%^*()+:?' zle backward-kill-word
  select-word-style $default_word_style
}
zle -N _bash_backward_kill_word

_system_copy_region_as_kill() {
  zle copy-region-as-kill
  zle set-mark-command -n -1
  echo -n "$CUTBUFFER" | safecopy
}
zle -N _system_copy_region_as_kill

_system_kill_region_or_backward_kill_word() {
  if [[ "$REGION_ACTIVE" -eq 0 ]]; then
    zle _backward_kill_word
  else
    zle _system_kill_region
  fi
}
zle -N _system_kill_region_or_backward_kill_word

_kill_region_or_backward_delete_char() {
  if [[ "$REGION_ACTIVE" -eq 0 ]]; then
    zle backward-delete-char
  else
    zle kill-region
  fi
}
zle -N _kill_region_or_backward_delete_char

_system_kill_region() {
  zle kill-region
  echo -n "$CUTBUFFER" | safecopy
}
zle -N _system_kill_region

_backward_kill_word() {
  # Selecting "shell" makes `backward-kill-word` delete the entire last
  # parameter
  select-word-style shell
  zle backward-kill-word
  select-word-style $default_word_style
}
zle -N _backward_kill_word

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

_system_kill_line() {
  zle kill-line
  echo -n "$CUTBUFFER" | safecopy
}
zle -N _system_kill_line

bindkey -e '\ew' _system_copy_region_as_kill
bindkey -e "^[^?" _bash_backward_kill_word
bindkey -e "^[^H" _bash_backward_kill_word
bindkey -e '^H' _kill_region_or_backward_delete_char
bindkey -e '^?' _kill_region_or_backward_delete_char
bindkey -e '^W' _system_kill_region_or_backward_kill_word

# Emacs Style
bindkey -e '^Y' _system_yank
bindkey -e '^X^X' _system_kill_line

# Arrow Keys
bindkey -e '^[[1;5A' beginning-of-buffer-or-history
bindkey -e '^[[1;5B' end-of-buffer-or-history
bindkey -e '^[[1;5D' beginning-of-line
bindkey -e '^[[1;5C' end-of-line
bindkey -e '^[[1;3D' backward-word
bindkey -e '^[[1;3C' forward-word

# Restore regular bindings for `isearch`
bindkey -M isearch "^H" backward-delete-char
bindkey -M isearch "^?" backward-delete-char
bindkey -M isearch "^[^?" _bash_backward-kill-word
bindkey -M isearch "^[^H" _bash_backward-kill-word
bindkey -M isearch '^W' backward-kill-word
bindkey -M isearch '^U' backward-kill-line
bindkey -M isearch '^I' accept-search
