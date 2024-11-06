# Settings

# Allow substitution in prompts
setopt PROMPT_SUBST
# Remove space to the right of `RPROMPT`
# This causes a blank line at the bottom of the terminal when the propmpt is
# active
# ZLE_RPROMPT_INDENT=-1
# Track Changed and Staged Files
# (Enables `%c` and `%u` below)
# zstyle ':vcs_info:*' check-for-changes true

# Colors
comment=244
# `%F{green}`: Built-in Color
# `%f`: Reset Color
# `%F{$comment}`: Color From Variable

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

# Note the last character is a non-breaking space in order to make prompts
# easier to find in search. This is `<C-k><space><space>` in Vim.
# Add ${SSH_CONNECTION:+%#} after the last #% to put back double SSH prompt
# `man zshmisc` for explanation
# Time
PS1='%F{$comment}%D{%I:%M %p} '
# Machine Name
PS1+='%F{yellow}${SSH_CONNECTION:+%m }'
# PS1+='%f%m '
# Path
PS1+='%F{cyan}%20<...<%~%<< '
# Jobs
PS1+='%F{yellow}%(1j.&%j .)'
# Exit status
# Ignore exit statuses `146` and `148` because it's they're sent every time a
# job is backgrounded.
# `146` on macOS
# `148` on Linux
# PS1+='%F{red}%(146?..%(148?..%(?..%?? )))'
PS1+='%F{red}%(?..%?? )'
PS1+='%f%# '

# Right prompt
# RPROMPT='${vcs_info_msg_0_}'
