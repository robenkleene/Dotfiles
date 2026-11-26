# Put this in `zshenv` so that `.zshrc_local` can add to the path and have it
# be picked up in non-interactive sessions (e.g., running scripts from Emacs
# via `M-!`)
# This is early so that any path settings can be overridden later, e.g, for
# `nvm` and `chruby`
if [[ -f ~/.zshrc_local.zsh ]]; then
  source ~/.zshrc_local.zsh
fi

# Every `path` setting, here so non-interactive shells have them too
source ~/.zsh/path.zsh

if [[ "$(uname)" = "Linux" ]]; then
  export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
  export XDG_CONIFG_HOME=${XDG_CONIFG_HOME:="$HOME/.config"}
  # Machines with little memory build one file at a time, since one
  # compiler process for a large file (e.g., a JUCE module) can use a
  # gigabyte and swapping makes the machine unresponsive. This is in `ZSHENV`
  # instead of `var.zsh` so non-interactive shells (e.g., scripts and agents
  # running builds) pick it up too.
  if (( $(awk '/MemTotal/ {print $2}' /proc/meminfo) < 8 * 1024 * 1024 )); then
    export CMAKE_BUILD_PARALLEL_LEVEL=1
  fi
fi
