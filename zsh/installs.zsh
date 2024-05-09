# `zshrc` is things for interactive shells

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
# Home brew should already be set, but this moves it back to the front of path
PATH=~/.brew/bin:$PATH
# Homebrew
# This was moved from `zshenv` because the brew path (in `/usr/local/bin`) is
# set by `/etc/profile`, and that's sourced *after* loading `zshenv`
if command -v brew &> /dev/null; then
  export HOMEBREW_DIR
  HOMEBREW_DIR=$(brew --prefix)
  export MANPATH="$HOMEBREW_DIR/share/man:$MANPATH"
  export INFOPATH="$HOMEBREW_DIR/share/info:$INFOPATH"
  FPATH="$HOMEBREW_DIR/share/zsh/site-functions:${FPATH}"
fi

# chruby
# This is ridiculously slow
# if [[ -f $HOMEBREW_DIR/share/chruby/chruby.sh ]]; then
#   source "$HOMEBREW_DIR/share/chruby/chruby.sh"
#   source "$HOMEBREW_DIR/share/chruby/auto.sh"
#   chruby ruby-3.0.2
# fi

if [[ -d ~/.gem/ruby/3.0.2/bin ]]; then
    PATH=~/.gem/ruby/3.0.2/bin:$PATH
fi
if [[ -d ~/.rubies/ruby-3.0.2/bin ]]; then
    PATH=~/.rubies/ruby-3.0.2/bin:$PATH
fi

# Python
if [[ "$(uname)" = "Darwin" ]]; then
  PATH=$HOME/Library/Python/3.11/bin:$PATH
elif [[ "$(uname)" = "Linux" ]]; then
  PATH=$HOME/.local/bin:$PATH
fi

# llvm
if [[ "$(uname)" = "Darwin" ]]; then
  # This gets rid of errors when importing C headers
  export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
  # Make tools like `clangd` available
  PATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:$PATH"
fi

# Rust
if [[ -d $HOME/.cargo/bin ]]; then
  PATH=$HOME/.cargo/bin:$PATH
fi

# nvm
# Official installation is really slow:
# Do not use homebrew `nvm` because it overrides `NVM_DIR` which causes issues.
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# This is faster:
# Automatic node version switching is probably broken by this
nvm() {
  if [[ -f ~/.nvm/nvm.sh ]]; then
    source ~/.nvm/nvm.sh
    nvm "$@"
   fi
}
if [[ -d "$HOME/.config/nvm/21.6.1/bin" ]]; then
  PATH=$HOME/.config/nvm/21.6.1/bin:$PATH
elif [[ -d "$HOME/.nvm/versions/node/v21.6.1/bin" ]]; then
  PATH=$HOME/.nvm/versions/node/v21.6.1/bin:$PATH
fi

# fzf
if [[ -f "$HOMEBREW_DIR/opt/fzf/shell/completion.zsh" ]]; then
  source "$HOMEBREW_DIR/opt/fzf/shell/completion.zsh"
fi
if [[ -f "$HOMEBREW_DIR/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "$HOMEBREW_DIR/opt/fzf/shell/key-bindings.zsh"
fi

# nnn
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias

    # Override LESS because some nnn commands use LESS and options like
    # --quit-if-one-screen interfere because they don't pause at the end
    # -e: Use $VISUAL by default to edit text files (otherwise it'll use OS
    # default)
    # -Q: Don't confirm on quit with multiple contexts active
    # -A: Don't auto-enter directories
    export LESS=""
    export NNN_PLUG='z:z;p:preview'
    command nnn -AQ "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
