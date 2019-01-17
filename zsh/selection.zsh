__selection_delete() {
  if [[ "$REGION_ACTIVE" -eq 1 ]]; then
     zle _system_kill_region
  else
    local widget_name=$1
    shift
    zle $widget_name -- $@
  fi
}

__selection_deselect() {
  REGION_ACTIVE=0
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

__selection_select() {
  if [[ "$REGION_ACTIVE" -eq 0 ]]; then
    zle set-mark-command
  fi
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

for seq mode widget (

# All are ordered left, right, up, down
# Arrow
$'\E[D' 'deselect' 'backward-char'
$'\E[C' 'deselect' 'forward-char'
$'\E[A' 'deselect' 'up-line-or-history'
$'\E[B' 'deselect' 'down-line-or-history'

# Arrow & Meta
# Meta left/right are mapped to `C-b`/`C-f`

# Arrow & Shift
$'\E[1;2D' 'select' 'backward-char'
$'\E[1;2C' 'select' 'forward-char'
$'\E[1;2A' 'select' 'up-line-or-history'
$'\E[1;2B' 'select' 'down-line-or-history'

# Arrow, Meta & Shift
$'\E[1;6D' 'select' 'backward-word'
$'\E[1;6C' 'select' 'forward-word'

# Movement

# Character
$'^B' 'deselect' 'backward-char'
$'^F' 'deselect' 'forward-char'

# Character Select
$'\EB' 'select' 'backward-char'
$'\EF' 'select' 'forward-char'

# Word
$'\Eb' 'deselect' 'backward-word'
$'\Ef' 'deselect' 'forward-word'

# Word Select
$'\EB' 'select' 'backward-word'
$'\EB' 'select' 'forward-word'

# Line
$'^E' 'deselect' 'end-of-line'
$'^A' 'deselect' 'beginning-of-line'

# Line Select
# These aren't setup in my terminal

# Delete

# Character
$'^D' 'delete' 'delete-char-or-list'
$'^H' 'delete' 'backward-delete-char'

# Word
$'\Ed' 'delete' 'kill-word'
$'^W' 'delete' '_system_kill_region_or_backward_kill_word'
$'\E^?' 'delete' '_bash_backward_kill_word'

# Line
$'^U' 'delete' 'backward-kill-line'
$'^K' 'delete' 'kill-line'
) {

  local function_name=__override_${mode}_${widget}
  eval "${function_name}() {
    __selection_${mode} $widget \$@
  }"

  zle -N $function_name
  bindkey -M emacs ${terminfo[$kcap]-$seq} $function_name
}
