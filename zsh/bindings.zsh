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

# Cycle through previous parameters
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

# This should already be defined
# typeset -A key
# key=(
#     BackSpace  "${terminfo[kbs]}"
#     Home       "${terminfo[khome]}"
#     End        "${terminfo[kend]}"
#     Insert     "${terminfo[kich1]}"
#     Delete     "${terminfo[kdch1]}"
#     Up         "${terminfo[kcuu1]}"
#     Down       "${terminfo[kcud1]}"
#     Left       "${terminfo[kcub1]}"
#     Right      "${terminfo[kcuf1]}"
#     PageUp     "${terminfo[kpp]}"
#     PageDown   "${terminfo[knp]}"
# )

# `⌥⌫` to delete previous word
# This works on Linux
bindkey -e "^[${key[BackSpace]}" _bash_backward_kill_word
# This is the only thing that seems to work on macOS
bindkey -e "^[^?" _bash_backward_kill_word

# Fix option forward / backward word, seems to work my default on macOS but
# not Linux
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

# `zsh` is supposed to have this `_complete_help` binding default, but for some
# reason it's missing
bindkey -e "^Xh" _complete_help
bindkey -e '^V' _system_yank
bindkey -e '^X^X' _system_kill_line
# By default, `^U` kills the whole line, rather than backwards
bindkey -e '^U' backward-kill-line

# Search history based on first word
# This works for Linux
# bindkey -e "${key[Up]}" up-line-or-search
# bindkey -e "${key[Down]}" down-line-or-search 
# # This is the only thing that seems to work on macOS
# bindkey -e "^[[A" up-line-or-search
# bindkey -e "^[[B" down-line-or-search

# Search history for entire search term before cursor
# This is more consistent with `vim`
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -e '^P' up-line-or-beginning-search
bindkey -e '^N' down-line-or-beginning-search
bindkey -e "${key[Up]}" up-line-or-beginning-search
bindkey -e "${key[Down]}" down-line-or-beginning-search 
# This is the only thing that seems to work on macOS
bindkey -e "^[[A" up-line-or-beginning-search
bindkey -e "^[[B" down-line-or-beginning-search
