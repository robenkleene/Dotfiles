export FZF_DEFAULT_COMMAND='rg --files -g "" --hidden'

# fzf
# Make `fzf` bindings available, since this is being manually imported here
# `fzf` should be installed at `~/.fzf/`, using the command 
# `~/.fzf/install --bin`, which avoids installing the completions automatically
FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
source ~/.fzf/shell/completion.zsh
source ~/.fzf/shell/key-bindings.zsh
# Put back default history search
bindkey '^R' history-incremental-search-backward
# bindkey '^[r' fzf-history-widget

# Custom Bindings

fzf-editor-widget() {
  if [[ -n "$LBUFFER" ]]; then
    return
  fi
  local files="$(__fsel)"
  if [[ -z "$files" ]]; then
    zle redisplay
    return 0
  fi
  exec </dev/tty
  setopt localoptions pipefail 2> /dev/null
  eval $EDITOR $files
  local ret=$?
  zle reset-prompt
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N fzf-editor-widget
bindkey '\ee' fzf-editor-widget

fzf-open-widget() {
  if [[ -n "$LBUFFER" ]]; then
    return
  fi
  local files="$(__fsel)"
  if [[ -z "$files" ]]; then
    zle redisplay
    return 0
  fi
  exec </dev/tty
  setopt localoptions pipefail 2> /dev/null
  eval open $files
  local ret=$?
  zle reset-prompt
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N fzf-open-widget
bindkey '\eo' fzf-open-widget

_fzf_z() {
  local cmd="fasd -Rdl"
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

fzf-z-widget() {
  if [[ -n "$LBUFFER" ]]; then
    LBUFFER="${LBUFFER}$(_fzf_z)"
    local ret=$?
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
  fi
  # Can't use `_fzf_z` here because it inserts a space at the end
  local cmd="fasd -Rdl"
  setopt localoptions pipefail 2> /dev/null
  local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  cd "$dir"
  local ret=$?
  zle reset-prompt
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N fzf-z-widget
bindkey '\ez' fzf-z-widget

fzf-zvim-widget() {
  if [[ -n "$LBUFFER" ]]; then
    LBUFFER="${LBUFFER}$(_fzf_z)"
    local ret=$?
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
  fi
  # Can't use `_fzf_z` here because it inserts a space at the end
  local cmd="fasd -Rfl"
  setopt localoptions pipefail 2> /dev/null
  local files="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" $(__fzfcmd) -m)"
  if [[ -z "$files" ]]; then
    zle redisplay
    return 0
  fi
  exec </dev/tty
  setopt localoptions pipefail 2> /dev/null
  eval $EDITOR $files
  local ret=$?
  zle reset-prompt
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N fzf-zvim-widget
bindkey '\er' fzf-zvim-widget

fzf-tags-widget() {
  if [[ -n "$LBUFFER" ]]; then
    return
  fi
  local cmd="~/Development/Dotfiles/vim/plugged/fzf.vim/bin/tags.pl tags"
  setopt localoptions pipefail 2> /dev/null
  local result="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --nth 1..2 --tiebreak=begin $FZF_DEFAULT_OPTS" $(__fzfcmd) -m)"
  if [[ -z "$result" ]]; then
    zle redisplay
    return 0
  fi
  echo $result | $VIM_COMMAND -c "TagBuffer" -
  local ret=$?
  zle reset-prompt
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N fzf-tags-widget
bindkey '\ei' fzf-tags-widget

__fcmd() {
  local query=""
  if [[ -n "$1" ]]; then
    query="--query=\"$1\" "
  fi
  local cmds=( ${(k)functions[@]} ${(k)commands[@]} )
  # There's a shell command called `g[` that `eval` has trouble parsing
  cmds=("${(@)cmds:#g\[}")
  local cmd="print -l \\"$cmds\\" | grep -E -v \"^(_|VCS)\""
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="$query--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" $(__fzfcmd) | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

fzf-command-widget() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_\-a-zA-Z0-9]#}
  LBUFFER+="$(__fcmd $MATCH)"
  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   fzf-command-widget
bindkey '^@' fzf-command-widget

# Private

_robenkleene_fzf_inline() {
  local result_cmd=$1
  local list_cmd=${2-$FZF_DEFAULT_COMMAND} 
  setopt localoptions pipefail 2> /dev/null
  local result="$(eval "$list_cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$result" ]]; then
    return 0
  fi
  local parameter=$(printf '%q' "$result")
  local final_cmd="$result_cmd $parameter"
  eval $final_cmd
  local ret=$?
  if [ $? -eq 0 ]; then
    # Add to history
    print -sr $final_cmd
  fi
  return $ret
}

_robenkleene_fzf_inline_result() {
  local list_cmd=${1-$FZF_DEFAULT_COMMAND} 
  setopt localoptions pipefail 2> /dev/null
  local result="$(eval "$list_cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" $(__fzfcmd) +m)"
  local ret=$?
  echo $result
  return $ret
}

# Safari
fzf-safari-history-open() {
  local result=$(safari-history-dump | FZF_DEFAULT_OPTS="-m --reverse --prompt \"Safari History> \" --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" $(__fzfcmd) +m | cut -f2 )
  if [[ -n $result ]]; then
    open "$result"
  fi
}

# Documentation
fzf-documentation-editor() {
  cd ~/Documentation/
  local result=$(_robenkleene_fzf_inline_result)
  if [[ -n "$result" ]]; then
    local parameter=$(printf '%q' "$PWD/$result")
    local final_cmd="$EDITOR $parameter"
    eval $final_cmd
    if [ $? -eq 0 ]; then
      # Add to history
      print -sr $final_cmd
    fi
  else
    cd -
  fi
}

# Snippets
fzf-snippet-copy() {
  cd ~/Development/Snippets/
  local result=$(_robenkleene_fzf_inline_result)
  if [[ -n $result ]]; then
    echo $result | tr '\n' '\0' | xargs -0 cat | tee /dev/tty | safecopy
  fi
  cd -
}
fzf-snippet-editor() {
  cd ~/Development/Snippets/
  local result=$(_robenkleene_fzf_inline_result)
  if [[ -n $result ]]; then
    local parameter=$(printf '%q' "$PWD/$result")
    local final_cmd="$EDITOR $parameter"
    eval $final_cmd
    if [ $? -eq 0 ]; then
      # Add to history
      print -sr $final_cmd
    fi
  else
    cd -
  fi
}

# Xcode
if [ "$(uname)" = "Darwin" ]; then
  fzf-project-xcode() {
    setopt localoptions pipefail 2> /dev/null
    find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' \
      | grep -vE "\/Carthage\/" \
      | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --select-1 $FZF_DEFAULT_OPTS" $(__fzfcmd) +m \
      | tr '\n' '\0' \
      | xargs -0 open
  }
fi
if [ "$(uname)" = "Darwin" ]; then
  fzf-file-xcode() {
    local ack_search_xcode="$FZF_DEFAULT_COMMAND --glob \"*.swift\" --glob \"*.h\" --glob \"*.m\""
    eval $ack_search_xcode \
      | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" $(__fzfcmd) +m \
      | tr '\n' '\0' \
      | xargs -0 open -a "Xcode"
  }
fi

# ack
fzf-vim-grep() {
  FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --ansi $FZF_DEFAULT_OPTS" $(__fzfcmd) +m | local result=`cat`
  echo $result | $VIM_COMMAND -c "GrepBuffer" -
}
fzf-vim-file() {
  FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --ansi $FZF_DEFAULT_OPTS" $(__fzfcmd) +m | local result=`cat`
  $VIM_COMMAND $result
}

fzf-tmux-vim-file() {
  tmux-paths -0 \
    | xargs -0 rg --files -g "" \
    | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --select-1 $FZF_DEFAULT_OPTS" $(__fzfcmd) +m \
    | tr '\n' '\0' \
    | xargs -0 $VIM_COMMAND
}
