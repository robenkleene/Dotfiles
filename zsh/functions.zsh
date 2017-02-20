# ranger
function ranger-cd() {
  local tempfile='/tmp/chosendir'
  ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# egitn
function egitn() {
  local egitnext=$(egit -n)
  if [ -n "$egitnext" ]; then
    cd "$egitnext"
    git status
  fi
}

function vim-edit() {
  if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    nvimedit $@
  else
    nvim $@
  fi
}

# ssh
function ssh-start() {
  eval `ssh-agent -c`
  ssh-add
}
