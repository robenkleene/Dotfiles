# Settings

# Allow substitution in prompts
setopt PROMPT_SUBST
# Track Changed and Staged Files
# (Enables `%c` and `%u` below)
zstyle ':vcs_info:*' check-for-changes true

# Colors
comment=238
# Built-in Color
# %F{green}%}
# Reset Color
# %{%f%}
# Color From Variable
# %F{$comment}%}

# vcs
# Enable vcs integration
autoload -Uz vcs_info
# Disable unused vcs
zstyle ':vcs_info:*' disable \
  bzr cdv cvs darcs fossil hg mtn p4 svk svn tla
# Style
# Rebase & Merge Conflicts
# Standard
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' formats \
  '%{%F{green}%}%b%{%f%}%u%c'
zstyle ':vcs_info:*' actionformats \
  '%{%F{green}%}%b%{%f%}%u%c%F{$comment}%}|%F{red}%}%a%{%f%}'

# Prompt
precmd () {
  vcs_info
}
PS1='%F{5}[%F{2}%n%F{5}] %F{3}%3~ %f%# '
RPROMPT='${vcs_info_msg_0_}'
