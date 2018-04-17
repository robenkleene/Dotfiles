_fzf-inline-result() {
  local list_cmd=${1-$FZF_DEFAULT_COMMAND} 
  setopt localoptions pipefail 2> /dev/null
  if [ -z "$NVIM_LISTEN_ADDRESS" ]; then
    export FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS"
  fi
  local result="$(eval "$list_cmd" |  fzf +m)"
  local ret=$?
  echo $result
  return $ret
}
