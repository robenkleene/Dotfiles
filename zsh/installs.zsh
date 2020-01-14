# fasd
if [[ $(whence -p "fasd") ]]; then
  eval "$(fasd --init auto)"
fi

# chruby
if [[ "$(uname)" = "Darwin" ]]; then
  if [[ -f /usr/local/share/chruby/chruby.sh ]]; then
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/share/chruby/auto.sh
    chruby ruby-2.5.3
  fi
elif [[ "$(uname)" = "Linux" ]]; then
  if [[ -f /home/linuxbrew/.linuxbrew/opt/chruby/share/chruby/chruby.sh ]]; then
    source /home/linuxbrew/.linuxbrew/opt/chruby/share/chruby/chruby.sh
    source /home/linuxbrew/.linuxbrew/opt/chruby/share/chruby/auto.sh
    chruby ruby-2.5.3
  fi
fi

# python
if [[ "$(uname)" = "Darwin" ]]; then
  PATH=$HOME/Library/Python/3.7/bin:$PATH
fi

# nvm
# Official installation is really slow:
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# This is faster:
nvm() {
  if [[ -f ~/.nvm/nvm.sh ]]; then
    source ~/.nvm/nvm.sh
    nvm "$@"
  fi
}

PATH=$HOME/.nvm/versions/node/v11.4.0/bin:$PATH

# The `-U` option prevens duplicates when `tmux` starts `zsh` instances
export -U PATH
