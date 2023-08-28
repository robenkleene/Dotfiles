# Don't use `^s` `^q` for freeze and resume
unsetopt flowcontrol

# Don't exit the shell with `^d`
setopt ignore_eof

# Shift tab to reverse menu selection
# Load the `menuselect` map first
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Widgets

# Edit in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -e "^X^E" edit-command-line

# `shell` deletes the last parameter
autoload -Uz select-word-style
default_word_style="shell"
select-word-style $default_word_style

autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey -e "^[m" copy-earlier-word

_bash_backward_kill_word() {
  # `bash` consideres only alphanumeric characters as part of words 
  select-word-style bash
  zle backward-kill-word
  select-word-style $default_word_style
}
zle -N _bash_backward_kill_word

_system_kill_line() {
  zle kill-whole-line
  echo -n "$CUTBUFFER" | ~/.bin/safecopy
}
zle -N _system_kill_line

_system_yank() {
  CUTBUFFER=$(~/.bin/safepaste)
  zle yank
}
zle -N _system_yank

# `⌥⌫` to delete previous word
bindkey -e "^[^?" _bash_backward_kill_word
bindkey -e "^[^H" _bash_backward_kill_word

# `_complete_help` is supposed have this default binding, but for some reason
# it's missing
bindkey -e "^Xh" _complete_help
bindkey -e '^V' _system_yank
bindkey -e '^X^X' _system_kill_line

# Arrow Keys
bindkey -e '^[[1;5A' beginning-of-buffer-or-history
bindkey -e '^[[1;5B' end-of-buffer-or-history
bindkey -e '^[[1;5D' beginning-of-line
bindkey -e '^[[1;5C' end-of-line
bindkey -e '^[[1;3D' backward-word
bindkey -e '^[[1;3C' forward-word
