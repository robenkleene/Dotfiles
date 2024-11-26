# Don't use `^s` `^q` for freeze and resume
unsetopt flowcontrol

# Don't exit the shell with `^d`
setopt ignore_eof

# Shift tab to reverse menu selection
# Load the `menuselect` map first
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Allow globs in history search
bindkey '^R' history-incremental-pattern-search-backward

# Widgets

# Edit in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -e "^X^E" edit-command-line

autoload -Uz select-word-style
# `shell` deletes the last parameter, including strings and shell commands
# default_word_style="shell"
default_word_style="default"
select-word-style $default_word_style

# Cycle through previous parameters
# To use this, first use `M-.` to insert the last parameter of a previous
# command, then use `M-,` to cycle through the previous arguments of that
# command
# Use undo if you go too far
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

_system_copy_line() {
  printf "%s" "$BUFFER" | ~/.bin/safecopy
}
zle -N _system_copy_line

_system_copy_region_as_kill() {
  zle copy-region-as-kill
  # Deactivate region
  # zle set-mark-command -n -1
  printf "%s" "$CUTBUFFER" | ~/.bin/safecopy
}
zle -N _system_copy_region_as_kill

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
bindkey -e "^X^X" _system_copy_line
bindkey -e "^[W" _system_copy_region_as_kill
bindkey -e "^[w" _system_copy_region_as_kill

# Fix option forward / backward word, seems to work my default on macOS but
# not Linux
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

# `zsh` is supposed to have this `_complete_help` binding default, but for some
# reason it's missing
bindkey -e "^Xh" _complete_help
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

# This has an odd side effect where if an edit command is performed, even one
# that has no affect on the `BUFFER`, then commands will restart as a search,
# typically causing the history back and forward keys to appear not to work,
# because they are now performing a search
# Don't bind '^P' and '^N' Vim doesn't bind these either, they just do normal
# history traversal
# bindkey -e '^P' up-line-or-beginning-search
# bindkey -e '^N' down-line-or-beginning-search
if [[ -n "${key[Up]}" ]]; then
  bindkey -e "${key[Up]}" up-line-or-beginning-search
fi
if [[ -n "${key[Down]}" ]]; then
  bindkey -e "${key[Down]}" down-line-or-beginning-search
fi
# This is the only thing that seems to work on macOS
bindkey -e "^[[A" up-line-or-beginning-search
bindkey -e "^[[B" down-line-or-beginning-search
