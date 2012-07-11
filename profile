# Colors
export CLICOLOR=1

# Editors
# export SVN_EDITOR=pico
export GIT_EDITOR="mate -wl1"

# Amazon Web Services
export AWS_ACCESS_KEY_ID="0ECYTZJYJETJTWS1F8R2"
export AWS_SECRET_ACCESS_KEY="PmMCMYlzwWCx2Vs8gk9p1AVSp/5sS9sPx5cXzrMi"

# Paths
export MANPATH="/usr/local/man:$MANPATH"
export PATH="/usr/local/bin:$PATH:~/Scripts/bin"


# Set the prompt

# export PS1="\u@\h \w:$ " # No color
# export PS1='\[\e[33;1m\]\u@\h \w:$\[\e[0m\] ' # with username
# export PS1='\[\e[33;1m\]\w $\[\e[0m\] '
#			  ^Yellow     ^Path
#							 ^Prompt
#							   ^Close Color
export PS1='\[\e[33;1m\]\w $\[\e[0m\] '

# See .inputrc as well
