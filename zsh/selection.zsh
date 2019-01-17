__selection_delete() {
  if ((REGION_ACTIVE)) then
     zle kill-region
  else 
    local widget_name=$1
    shift
    zle $widget_name -- $@
  fi
}

__selection_deselect() {
  # zle set-mark-command -1
  ((REGION_ACTIVE = 0))
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

__selection_select() {
  ((REGION_ACTIVE)) || zle set-mark-command
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

for seq        mode     widget (
    $'\e[1;2D' select   backward-char
    $'\e[1;2C' select   forward-char
    $'\e[1;2A' select   up-line-or-history
    $'\e[1;2B' select   down-line-or-history

    $'\E[1;2F' select   end-of-line
    $'\E[4;2~' select   end-of-line

    $'\E[1;2H' select   beginning-of-line
    $'\E[1;2~' select   beginning-of-line

    $'\EOD'    deselect backward-char
    $'\EOC'    deselect forward-char

    $'\EOF'    deselect end-of-line
    $'\E4~'    deselect end-of-line

    $'\EOH'    deselect beginning-of-line
    $'\E1~'    deselect beginning-of-line

    $'\E[1;6D' select   backward-word
    $'\E[1;6C' select   forward-word
    $'\E[1;6F' select   end-of-line
    $'\E[1;6H' select   beginning-of-line

    $'\E[1;5D' deselect backward-word
    $'\E[1;5C' deselect forward-word

     $'\E[3~'  delete delete-char
     $'^?'     delete backward-delete-char
  ) {

  local function_name=__override_${mode}_${widget}
  eval "${function_name}() {
    __selection_${mode} $widget \$@
  }"
  zle -N $function_name
  bindkey -M emacs ${terminfo[$kcap]-$seq} $function_name
}
