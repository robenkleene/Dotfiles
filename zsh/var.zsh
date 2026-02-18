# This helps with some issues with mosh, e.g., utf-8 support and specifying
# locale
# Check available locales with `locale -a`
if [[ "$(uname)" = "Darwin" ]]; then
  export LANGUAGE=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  export LC_CTYPE=en_US.UTF-8
else
  export LANGUAGE=en_US.utf8
  export LC_ALL=en_US.utf8
  export LANG=en_US.utf8
  export LC_CTYPE=en_US.utf8
  # This also helps with UTF parsing issues (e.g., garbled characters) when the pager is used
  export LESSCHARSET=utf-8
fi

# `path` nees to be set in both `ZSHENV` and here.
# In `ZSHENV` to make scripts and installs available in non-interactive shells,
# and here to move custom paths to the front (if the path is only set in
# `ZSHENV` then `/usr/bin` will be moved ahead of paths set there.
# `typeset -U` prevents duplicates in `path`, this needs to be here even if `-U`
# was set earlier
typeset -U path
path=(~/.bin ~/.brew/bin $path)
# Allow local bin to override
if [[ -d "$HOME/.bin-local" ]]; then
  path=(~/.bin-local $path)
fi

# Setting `MANPATH` causes man for builtins to break unless a : as appended at
# the end
manpath=(~/.man ${(s/:/)MANPATH} :)
typeset -U manpath
export MANPATH="${(j/:/)manpath}"

# Smartcase and incremental search in `less`
# `--RAW-CONTROL-CHARS` fixes escape code issue with colors on Linux
# `--quit-if-one-screen` is the default but gets disabled with `LESS` set
# `--no-init` is also the default and gets disabled with `LESS` set (this makes
# it so hitting `q` with `less` results on screen doesn't get cleared)
# `--ignore-case` ignore case in search (this is actually smart case, e.g.,
# `FOO` will not match `foo`)
# `--incsearch` use incremental search
export LESS="--incsearch --ignore-case --no-init --quit-if-one-screen --RAW-CONTROL-CHARS"

# Color in `ls`
export CLICOLOR=1

# Truecolor over ssh
# export COLORTERM=truecolor

# Prevent `npm` scripts from opening browser windows
# This breaks `gh browse`
# export BROWSER="none"

# Without this `less` doesn't get picked up as `man` pager resulting in warning
# about `incsearch` not being supported
export PAGER=less

# Emacs
# Start the server in the background if it isn't running
export ALTERNATE_EDITOR=""

# Use `nvim` for clipboard provider
# export EDITOR="nvim"

# Installs

# rg
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
