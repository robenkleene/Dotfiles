# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx)
# osx plugin enables new terminal tabs opening in the correct directory

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Adding just the "osx" plugin didn't make opening new terminal tabs in the correct directory all the time, adding these lines did
precmd () {print -Pn "\e]2; %~/ \a"}
preexec () {print -Pn "\e]2; %~/ \a"}

# Editor
# export EDITOR="vim"
export EDITOR="/usr/local/bin/mate -w"

# Emacs
# Alias
alias ec='emacsclient -c -n'
# Magit
alias gc='emacsclient -c -n --eval "(rk-magit-status-startup)"'

# Fixing colors in terminal Emacs
# export TERM=xterm-256color

# Create an alias to less.sh in Vim, which makes Vim to act as a pager
VLESS=$(find /usr/share/vim -name 'less.sh')
if [ ! -z $VLESS ]; then
	alias vless=$VLESS
fi

# Setup egit
export EGITREPOS=~/Development/Environment/LaunchAgents:~/Dotfiles/:~/Library/Services/:~/Library/Application\ Support/Avian/Bundles/Roben.tmbundle/:~/Library/Scripts/:~/Development/Scripts/:~/Development/Snippets/:~/Development/Environment/Bookmarklets/:~/Development/Environment/Settings/
egitn() { 
	EGITNEXT=$(egit -n)
	if [ ! -z "$EGITNEXT" ]; then
		cd $EGITNEXT
		git status
	fi
	unset EGITNEXT
}

# Prompt
PROMPT='%{$fg[cyan]%}%~ %{$fg[green]%}$ %{$reset_color%}'
RPROMPT='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

eval "$(rbenv init -)"