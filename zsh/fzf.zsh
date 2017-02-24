local resolvedir="${TMPDIR:-/tmp}"
local tmpdir=$resolvedir[1]

function ack-lines() {
  rg --no-heading $@
}
function ack-lines-color() {
  ack-lines --color=always $@
}
function ack-lines-no-color() {
  ack-lines --color=never $@
}

export FZF_DEFAULT_COMMAND='rg --files -g ""'
