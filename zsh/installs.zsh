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

  manpath=($HOMEBREW_DIR/share/man ${(s/:/)MANPATH})
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

# fzf
if [[ -f "$HOMEBREW_DIR/opt/fzf/shell/completion.zsh" ]]; then
  source "$HOMEBREW_DIR/opt/fzf/shell/completion.zsh"
fi
# Avoid the completiong because `^t` conflicts with transpose characters
# `vim $(fzf)` is a good replacement for `^t`
# `cd $(fzf)` is a good replacement for `^c`
# if [[ -f "$HOMEBREW_DIR/opt/fzf/shell/key-bindings.zsh" ]]; then
#   source "$HOMEBREW_DIR/opt/fzf/shell/key-bindings.zsh"
# fi
# Use `fd --type f` for `CTRL-T` in zsh for files
export FZF_CTRL_T_COMMAND='fd --type f'
# Use `fd --type f` for `OPT-C` in zsh for directories
export FZF_ALT_C_COMMAND='fd --type d'
# Use `fd` for `:Files` in `fzf.vim`
# This means both files and directories can be selected
# `fzf.vim` has no built-in support for directories
export FZF_DEFAULT_COMMAND='fd'
# Always wrap preview window because it's usually useless without it
export FZF_DEFAULT_OPTS='--preview-window=wrap'

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
    # -g: Use regular expressions instead of string matches
    # Note these must be set via `ENV` (e.g., instead of with `export`)
    # because with export it would affect the current session
    env LESS="" NNN_PLUG='z:z;p:preview' nnn -AQg "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
