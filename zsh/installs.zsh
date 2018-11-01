# fasd
eval "$(fasd --init auto)"

# chruby
chruby() {
  source /usr/local/share/chruby/chruby.sh
  chruby $@
}
chruby ruby-2.4.0
# export PATH=$HOME/.rubies/ruby-2.4.0/bin:$PATH
# export PATH=$HOME/.gem/ruby/2.4.0/bin:$PATH

# nvm
# Official installation is really slow:
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# This is faster:
nvm() {
  source ~/.nvm/nvm.sh
  nvm "$@"
}
export PATH=$HOME/.nvm/versions/node/v7.5.0/bin:$PATH
