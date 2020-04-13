#!/usr/bin/env zsh

echo_path="false"
while getopts ":pq:h" option; do
  case "$option" in
    p)
      echo_path="true"
      ;;
    p)
      query="$OPTARG"
      ;;
    h)
      echo "Usage: command [-ph] [-q <querty>]"
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

source ~/.bin/nobin/_fzf_inline_result.sh

cd ~/Documentation/
if [[ -n "$query" ]]; then
  local list_cmd=$FZF_DEFAULT_COMMAND
  local result="$(eval "$list_cmd" "$query" | head -n 1)"
else
  local result=$(_fzf_inline_result)
fi

if [[ -n $result ]]; then
  parameter=$(printf '%q' "$PWD/$result")
  if [[ "$echo_path" == "true" ]]; then
    echo -n "$parameter"
  else
    # final_cmd="cat $parameter | less -FX"
    final_cmd="$BAT_COMMAND $parameter"
    eval $final_cmd
  fi
  if [ $? -eq 0 ]; then
    # Add to history
    print -sr $final_cmd
  fi
fi
