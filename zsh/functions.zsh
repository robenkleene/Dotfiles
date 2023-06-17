# Commands
egitn() {
  # The reason `egitn` has to be run seprately after `egit` is because the
  # second time running `egit` can't print except the path.
  print_status="true"
  while getopts ":n" option; do
    case "$option" in
      n)
        print_status="false"
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    esac
  done

  local gitnext
  gitnext=$(egit -n)
  if [[ -n "$gitnext" ]]; then
    cd "$gitnext" || return
    if [[ "$print_status" == "true" ]]; then
      pwd
      git status
    fi
    return 1
  fi
}

sgitn() {
  local gitnext
  gitnext=$(sgit -n)
  if [[ -n "$gitnext" ]]; then
    cd "$gitnext" || return
    git status
    return
  fi
  return 1
}

sgitnp() {
  cd ~/Developer/Projects || return
  sgitn
  if [[ $? -ne 0 ]]; then
    cd - >/dev/null
    return 1
  fi
}

sgitnd() {
  cd ~/Documentation || return
  sgitn
  if [[ $? -ne 0 ]]; then
    cd - >/dev/null
    return 1
  fi
}

vim_cd() {
  local tempfile='/tmp/vim.robenkleene/chdir/chdir'
  $VIM_COMMAND .
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n "$(pwd)")" ]; then
      cd -- "$(cat "$tempfile")" || return
    fi
}

emacs_cd() {
  local tempfile='/tmp/vim.robenkleene/chdir/chdir'
  eval $EMACS_COMMAND .
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n "$(pwd)")" ]; then
      cd -- "$(cat "$tempfile")" || return
    fi
}

yank_test_variable() {
  test_variable=$(cat)
}

zsh_refresh_commands() {
  rehash
}

zsh_edit_config() {
  cd ~/Developer/Dotfiles/zsh/ || return
  eval $EDITOR ../zshrc
}

ssh_start() {
  if [[ "$(uname)" = "Linux" && -z "$SSH_AGENT_PID" ]]; then
    eval "$(ssh-agent -s)"
    ssh-add
  fi
}

ssh_git_pull_all() {
  ssh_start
  git_pull_all "$@"
}

ssh_stop() {
  ssh-agent -k
}

ssh_tmux_start() {
  ssh_start
  tmux
}

ssh_tmux_restore_start() {
  ssh_start
  tmux_session_auto_restore
}

git_cd() {
  cd "$(git rev-parse --show-toplevel)" || return
  if [[ -n "$1" ]]; then
    cd "$1"
  fi
}

hg_cd() {
  cd "$(hg root)" || return
  if [[ -n "$1" ]]; then
    cd "$1"
  fi
}

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
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn -AQe "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
