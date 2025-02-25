# alias -- -='cd -'
# alias ..='cd ..'

# Trick to get `xargs` to use aliases, e.g., `fd foo | xargs eza` will not use
# aliases without this
alias xargs='xargs '
alias grep="`which grep` --color=auto"

if [[ "$(uname)" = "Linux" ]]; then
  # `ls` does colors by default on macOS
  alias ls="`which ls` --color=auto"
fi

if [[ "$TERM" = 'xterm-ghostty' || "$TERM_PROGRAM" = 'vscode' ]]; then
  # Check for `${aliases[<alias>]}` to allow `zshrc_local` to override
  if [[ ! ${aliases[rg]} ]]; then
    # `--with-filename` when searching a single file, e.g., `rg <term> <file>`,
    # the filename is omitted which means hyperlinks don't work. Forcing the
    # filename makes hyperlinks work.
    # alias rg="`which rg` --with-filename --hyperlink-format vscode://file/{path}:{line}:{column}"
    alias rg=rg_delta
  fi
  if [[ ! ${aliases[hg]} ]]; then
    alias hg="`which hg` --config pager.pager='delta --hyperlinks --hyperlinks-file-link-format vscode://file/{path}:{line}'"
  fi
  export GIT_PAGER='delta --relative-paths --hyperlinks --hyperlinks-file-link-format vscode://file/{path}:{line}'
  if [[ ! ${aliases[delta]} ]]; then
    alias delta="`which delta` --relative-paths --hyperlinks --hyperlinks-file-link-format vscode://file/{path}:{line}"
  fi
  alias fd="`which fd` --hyperlink"
else
  export GIT_PAGER='delta'
  # if [[ ! ${aliases[rg]} ]]; then
  #   alias rg="`which rg` --no-heading --with-filename --line-number --column"
  # fi
fi

# egit
# These are aliases instead of shell functions because they set the `ssh`
# status of the current shell
alias rk_push='ssh_start && { egit -p || egitn } && ~/.bin/sgitt_auto'
alias rk_pull='ssh_start && ~/.bin/egit_update'
alias rk_pull_text='ssh_start && ssh_git_pull_all -t'
alias rk_pull_all='ssh_start && ssh_git_pull_all'
alias rk_pull_settings='ssh_start && ~/.bin/egit_update -s'
