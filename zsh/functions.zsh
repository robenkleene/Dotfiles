# Private

# Commands
egitn() {
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
    if [ "$(cat -- "$tempfile")" != "$(echo -n $(pwd))" ]; then
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




# Emacs

emacs_magit_status() {
  eval "$EMACS_COMMAND -nw -eval \"(robenkleene/magit-status-startup)\""
}

emacs_magit_log() {
  eval "$EMACS_COMMAND -nw -eval \"(robenkleene/magit-log)\""
}
emacs_kill_server() {
  emacsclient -e '(kill-emacs)'
}

emacs_app() {
  if [[ $# -eq 0 ]]; then
    open -a "Emacs.app" .
  else
    open -a "Emacs.app" "$@"
  fi
}

# ssh
ssh_start() {
  eval `ssh-agent -s`
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

# DNS
dns_refresh() {
  sudo killall -HUP mDNSResponder 
}




# neovim
vim_server_start() {
  if [ -z "$TMUX" ]; then
    NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim $@
  else
    nvim_session_id=$(tmux display-message -p '#{session_id}')
    NVIM_LISTEN_ADDRESS=/tmp/nvimsocket$nvim_session_id nvim $@
  fi
}
# git
# Autocomplete
_robenkleene_git_branch_names() {
  compadd "${(@)${(f)$(git branch -a)}#??}"
}

git_cd_root() {
  cd "$(git rev-parse --show-toplevel)" || exit
}

git_push_branch_origin() {
  git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}
compdef _robenkleene_git_branch_names git_branch_delete
git_branch_delete() {
  git push origin --delete $1 && \
    git branch -D $1
}
git_tag_delete() {
  git push --delete origin $1 && \
    git fetch --prune --tags
}
compdef _robenkleene_git_branch_names git_push_origin_delete
git_push_origin_delete() {
  git push origin --delete $1
}
git_branch_set_upstream_origin_master() {
  git branch --set-upstream-to=origin/master master
}
git_remote_add_origin() {
  git remote rm origin
  git remote add origin $1
}
git_branch_prune() {
  git remote prune origin
  if [[ "$1" = "-D" ]]; then
    git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
  fi
}
git_branch_list_pruned() {
  if [[ "$1" = "-D" ]]; then
    git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
  else
    git branch -vv | grep ': gone]' | awk '{print $1}'
  fi
}
git_list_modified() {
  git diff --name-only --diff-filter=UM | uniq
}
git_push_force() {
  git push --force-with-lease
}
git_diff_grep() {
  git diff --relative $argv | diff_to_grep
}

