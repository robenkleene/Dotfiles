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

for kcap   seq        mode     widget (
    kLFT   $'\e[1;2D' select   backward-char
    kRIT   $'\e[1;2C' select   forward-char
    kri    $'\e[1;2A' select   up-line-or-history
    kind   $'\e[1;2B' select   down-line-or-history

    kEND   $'\E[1;2F' select   end-of-line
    x      $'\E[4;2~' select   end-of-line

    kHOM   $'\E[1;2H' select   beginning-of-line
    x      $'\E[1;2~' select   beginning-of-line

    kcub1  $'\EOD'    deselect backward-char
    kcuf1  $'\EOC'    deselect forward-char

    kend   $'\EOF'    deselect end-of-line
    x      $'\E4~'    deselect end-of-line

    khome  $'\EOH'    deselect beginning-of-line
    x      $'\E1~'    deselect beginning-of-line

    x      $'\E[1;6D' select   backward-word
    x      $'\E[1;6C' select   forward-word
    x      $'\E[1;6F' select   end-of-line
    x      $'\E[1;6H' select   beginning-of-line

    x      $'\E[1;5D' deselect backward-word
    x      $'\E[1;5C' deselect forward-word

    kdch1   $'\E[3~'  delete delete-char
    x       $'^?'     delete backward-delete-char

  ) {

  local function_name=__override_${mode}_${widget}
  eval "${function_name}() {
    __selection_${mode} $widget \$@
  }"
  zle -N $function_name
  bindkey -M emacs ${terminfo[$kcap]-$seq} $function_name
}
