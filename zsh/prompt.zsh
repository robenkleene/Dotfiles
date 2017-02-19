# Settings

# Allow substitution in prompts
setopt PROMPT_SUBST

# vcs
# Enable vcs integration
autoload -Uz vcs_info
# Disable unused vcs
zstyle ':vcs_info:*' disable bzr cdv cvs darcs fossil hg mtn p4 svk svn tla
# Style
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

# Prompt
precmd () {
	vcs_info
}
PS1='%F{5}[%F{2}%n%F{5}] %F{3}%3~ %f%# '
RPROMPT='${vcs_info_msg_0_}'
