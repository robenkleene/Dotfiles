#!/usr/bin/env zsh

source ~/.bin/nobin/_fzf_inline_result.sh

cd ~/Documentation/
local query=$1
if [[ -n "$query" ]]; then
  local list_cmd=$FZF_DEFAULT_COMMAND
  local result="$(eval "$list_cmd" "$query" | head -n 1)"
else
  local result=$(_fzf_inline_result)
fi

if [[ -n $result ]]; then
  parameter=$(printf '%q' "$PWD/$result")
  # final_cmd="cat $parameter | less -FX"
  final_cmd="$BAT_COMMAND $parameter"
  eval $final_cmd
  if [ $? -eq 0 ]; then
    # Add to history
    print -sr $final_cmd
  fi
fi
