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
# if [[ "$(uname)" = "Darwin" ]]; then
#   export NVM_DIR="$HOME/.nvm"
#   [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
#   [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
# elif [[ "$(uname)" = "Linux" ]]; then
#   export NVM_DIR="$HOME/.nvm"
#   [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"
#   [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"
# fi

# This is faster:
# Automatic node version switching is probably broken by this
if [[ "$(uname)" = "Darwin" ]]; then
  nvm() {
    if [[ -f "/usr/local/opt/nvm/nvm.sh" ]]; then
      source "/usr/local/opt/nvm/nvm.sh"
      nvm "$@"
    fi
  }
elif [[ "$(uname)" = "Linux" ]]; then
  nvm() {
    if [[ -f "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ]]; then
      source "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"
      nvm "$@"
    fi
  }
fi
PATH=$HOME/.nvm/versions/node/v13.12.0/bin:$PATH

# The `-U` option prevens duplicates when `tmux` starts `zsh` instances
export -U PATH
