# Private

_robenkleene_ack_lines() {
  rg --no-heading --smart-case --line-number --with-filename $@
}
_robenkleene_ack_lines_color() {
  _robenkleene_ack_lines --color=always $@
}
_robenkleene_ack_lines_no_color() {
  _robenkleene_ack_lines --color=never $@
}

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
  local gitnext=$(sgit -n)
  if [[ -n "$gitnext" ]]; then
    cd "$gitnext"
    git status
    return
  fi
  return 1
}

sgitnp() {
  cd ~/Developer/Projects
  sgitn
  if [[ $? -ne 0 ]]; then
    cd - >/dev/null
    return 1
  fi
}

sgitnd() {
  cd ~/Documentation
  sgitn
  if [[ $? -ne 0 ]]; then
    cd - >/dev/null
    return 1
  fi
}

# vim
vim_cd() {
  local tempfile='/tmp/vim.robenkleene/chdir/chdir'
  $VIM_COMMAND .
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
    fi
}
vim_session_restore_local() {
  $VIM_COMMAND -c "SessionRestoreLocal"
}
vim_session_restore_auto() {
  $VIM_COMMAND -c "SessionRestoreAuto"
}
vim_git_conflicts() {
  cd "$(git rev-parse --show-toplevel)" \
    && $VIM_COMMAND $(git diff --name-only --diff-filter=UM \
    | uniq) -c "vimgrep /======/ ##"
}
vim_diff_grep() {
  cd "$(git rev-parse --show-toplevel)"
  diff_to_grep | vim_grep
}
vim_git_modified() {
  cd "$(git rev-parse --show-toplevel)" \
    && $VIM_COMMAND $(git diff --name-only --diff-filter=UM | uniq)
}
vim_git_diff() {
  git diff --relative $argv | vim_diff_grep
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

# zsh
zsh_refresh_commands() {
  rehash
}
zsh_edit_config() {
  cd ~/Developer/Dotfiles/zsh/
  eval $EDITOR ../zshrc
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
vim_server_edit() {
  if [ -z "$TMUX" ]; then
    nvr $@
  else
    nvim_session_id=$(tmux display-message -p '#{session_id}')
    nvr --servername /tmp/nvimsocket$nvim_session_id $argv
  fi
}

# git
# Autocomplete
_robenkleene_git_branch_names() {
  compadd "${(@)${(f)$(git branch -a)}#??}"
}
# Darwin
if [[ "$(uname)" = "Darwin" ]]; then
  git_reveal_diff() {
    git diff --name-only -z | xargs -0 open -R
  }
fi
# To make yank versions of these add `tee /dev/tty | safecopy`
# Branch
git_branch_print() {
  git rev-parse --abbrev-ref HEAD | tr -d '\n'
}
# Hash
git_revision_print() {
  git rev-parse HEAD | tr -d '\n'
}
# Remote
git_remote_print() {
  git ls-remote --get-url | tr -d '\n'
}
git_cd_root() {
  cd "$(git rev-parse --show-toplevel)"
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

# Git Stash
_robenkleene_git_stash_command() {
  local stash_command="git stash $1"
  if [ $# -gt 1 ]; then
    stash_command="$stash_command stash@\{$2\}"
  fi
  eval $stash_command
}
git_stash_pop() {
  _robenkleene_git_stash_command "pop" $1
}
git_stash_apply() {
  _robenkleene_git_stash_command "apply" $1
}
git_stash_show() {
  _robenkleene_git_stash_command "show" $1
}
git_stash_diff() {
  _robenkleene_git_stash_command "show --patch" $1
}
git_stash_drop() {
  _robenkleene_git_stash_command "drop" $1
}
git_stash_list() {
  git stash list
}

# Misc
fasd_add_all() {
  for i in */; do
    cd "$i"
    _fasd_preexec
    cd - >/dev/null
  done
}

# Gem
gem_update_no_doc() {
  gem update --no-ri --no-rdoc
}

# Simulator
simulator_data_print() {
  local app_process=$(ps ax | grep -E \
    "/.*Library/Developer/CoreSimulator/Devices/[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}/.*/[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}" | \
    grep -v grep | awk '{ print $1 }')
  local app_path=$(lsof -p ${app_process} | \
    grep -oE "/.*Library/Developer/CoreSimulator/Devices/[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}/data/Containers/Data/Application/[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}" | \
    grep -v grep | awk '{ print $1 }' | head -n 1)
  if [[ -z "$app_path" ]]; then
    app_path=$(lsof -p ${app_process} | \
      grep -oE "/.*Library/Developer/CoreSimulator/Devices/[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}/" | \
      grep -v grep | awk '{ print $1 }' | head -n 1)
  fi

  if [[ -z "$app_path" ]]; then
    echo "No directory found"
    return 1
  fi

  if [[ ! -d "$app_path" ]]; then
    echo "$app_path is not a directory"
    return 1
  fi

  echo "$app_path" | tr -d '\n'
}

simulator_data_cd() {
  local app_path=$(simulator_data_print)
  if [[ $? -ne 0 ]]; then
    return 1
  fi
  cd "$app_path"
}

# For use with z
add_common_directories() {
  fasd -A ~/Text/notes
  fasd -A ~/Developer/Scratch
  fasd -A ~/Developer
  fasd -A ~/Documentation
}

yank_test_variable() {
  test_variable=$(cat)
}

inbox() {
  title="$1"
  if [[ -z "$title" ]]; then
    cd ~/Documents/Text/Inbox || return
  else
    inbox_new_edit "$title"
  fi
}

tweets() {
  cd ~/Documents/Text/Writing/Tweets || return
}
