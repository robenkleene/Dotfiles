# Settings

# Allow substitution in prompts
setopt PROMPT_SUBST
# Remove space to the right of `RPROMPT`
# This causes a blank line at the bottom of the terminal when the propmpt is
# active
# ZLE_RPROMPT_INDENT=-1
# Track Changed and Staged Files
# (Enables `%c` and `%u` below)
zstyle ':vcs_info:*' check-for-changes true

# Colors
comment=241
# `%F{green}`: Built-in Color
# `%f`: Reset Color:w
# `%F{$comment}`: Color From Variable

# Disable inverted syntax highlighting for pasted text
zle_highlight+=(paste:none)
# Color region
zle_highlight+=(region:bg=cyan,fg=white)

# vcs
# Enable vcs integration
autoload -Uz vcs_info
# Disable unused vcs
# zstyle ':vcs_info:*' disable bzr cdv cvs darcs fossil hg mtn p4 svk svn tla
# Style
# Rebase & Merge Conflicts
# Standard
# `%b`: Branch
# `%u`: Staged changes
# `%c`: Unstaged changes
# zstyle ':vcs_info:*' stagedstr '+'
# zstyle ':vcs_info:*' unstagedstr '*'
# zstyle ':vcs_info:*' formats '%F{cyan}%r %F{green}%b%f%u%c'
# zstyle ':vcs_info:*' actionformats '%F{cyan}%r %F{green}%b%f%u%c %F{red}(%a)%f'

# Prompt
update_prompt() {
  # vcs_info
  # if [[ -a .git ]]; then
  #   prompt_path='.'
  # else
  #   prompt_path=%1~
  # fi
  prompt_path=%1~
}
precmd() {
  update_prompt
}
chpwd() {
  update_prompt
}

# Note the last character is a non-breaking space in order to make prompts
# easier to find in search. This is `<C-k><space><space>` in Vim.
# Add ${SSH_CONNECTION:+%#} after the last #% to put back double SSH prompt
PS1='%F{$comment}%D{%I:%M %p} %F{yellow}${SSH_CONNECTION:+%m }%F{cyan}${prompt_path} %F{yellow}%(1j.%j& .)%F{red}%(?..%?? )%f%# '
# RPROMPT='${vcs_info_msg_0_}'
