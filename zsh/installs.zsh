# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
# Home brew should already be set, but this moves it back to the front of path
# Don't do this because it breaks overriding Homebrew executables with scripts
# by putting `~/.brew/bin` in fron of `~/bin`
# PATH=~/.brew/bin:$PATH
# Homebrew
# This was moved from `zshenv` because the brew path (in `/usr/local/bin`) is
# set by `/etc/profile`, and that's sourced *after* loading `zshenv`
if command -v brew &> /dev/null; then
  export HOMEBREW_DIR
  HOMEBREW_DIR=$(brew --prefix)

  # Setting `MANPATH` causes man for builtins to break unless a : as appended at
  # the end
  manpath=($HOMEBREW_DIR/share/man ${(s/:/)MANPATH} :)
  typeset -U manpath
  export MANPATH="${(j/:/)manpath}"

  infopath=($HOMEBREW_DIR/share/info ${(s/:/)INFOPATH})
  typeset -U infopath
  export INFOPATH="${(j/:/)infopath}"

  typeset -U fpath
  fpath=($HOMEBREW_DIR/share/zsh/site-functions $fpath)
fi

if [[ -n ${ALACRITTY+x} ]]; then
  # Disable bouncing the dock icon for "urgency" in Alacritty. The icon
  # occassionally bounces without this, probably for shaky `ssh` connections.
  printf "\e[?1042l"
fi

# chruby
# This is ridiculously slow
# if [[ -f $HOMEBREW_DIR/share/chruby/chruby.sh ]]; then
#   source "$HOMEBREW_DIR/share/chruby/chruby.sh"
#   source "$HOMEBREW_DIR/share/chruby/auto.sh"
#   chruby ruby-3.0.2
# fi

if [[ -d ~/.gem/ruby/3.0.2/bin ]]; then
  path=(~/.gem/ruby/3.0.2/bin $path)
fi
if [[ -d ~/.rubies/ruby-3.0.2/bin ]]; then
  path=(~/.rubies/ruby-3.0.2/bin $path)
fi

# Python
if [[ "$(uname)" = "Darwin" ]]; then
  path=(~/Library/Python/3.11/bin $path)
elif [[ "$(uname)" = "Linux" ]]; then
  path=(~/.local/bin $path)
fi

# llvm
if [[ "$(uname)" = "Darwin" ]]; then
  # This gets rid of errors when importing C headers
  export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
  # Make tools like `clangd` available
  path=(/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin $path)
elif [[ "$(uname)" = "Linux" && -d ~/swift/swift-6.0.2-RELEASE-ubuntu20.04/usr/bin ]]; then
  path=(~/swift/swift-6.0.2-RELEASE-ubuntu20.04/usr/bin $path)
fi

# Rust
if [[ -d $HOME/.cargo/bin ]]; then
  path=(~/.cargo/bin $path)
fi

# This is faster:
# Automatic node version switching is probably broken by this
nvm() {
  if [[ -f ~/.nvm/nvm.sh ]]; then
    source ~/.nvm/nvm.sh
    nvm "$@"
   fi
}
if [[ -d "$HOME/.config/nvm/21.6.1/bin" ]]; then
  path=(~/.config/nvm/21.6.1/bin $path)
elif [[ -d "$HOME/.nvm/versions/node/v21.6.1/bin" ]]; then
  path=(~/.nvm/versions/node/v21.6.1/bin $path)
fi
