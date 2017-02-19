# chruby
source /usr/local/share/chruby/chruby.fish
# Maybe one day the below will work:
# bass source /usr/local/share/chruby/chruby.sh
chruby ruby-2.4.0

# nvm
# Relies on `bass` as a dependency
function nvm
  bass source ~/.nvm/nvm.sh ';' nvm $argv
end
function nvm-use-default
  nvm use default
end
set PATH $HOME/.nvm/versions/node/v7.5.0/bin $PATH
