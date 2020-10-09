# Autocomplete
_robenkleene_git_branch_names() {
  compadd "${(@)${(f)$(git branch -a)}#??}"
}
compdef _robenkleene_git_branch_names git_branch_delete
compdef _robenkleene_git_branch_names git_push_origin_delete

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
    return
  fi
  return 1
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

git_cd_root() {
  cd "$(git rev-parse --show-toplevel)" || exit
}

ssh_start() {
  eval "$(ssh-agent -s)"
  ssh-add
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
