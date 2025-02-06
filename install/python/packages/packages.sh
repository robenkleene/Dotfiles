declare -a modules

modules=(
'pipdeptree'
'pip-autoremove'
)
if [[ "$(uname)" = "Linux" ]]; then
  modules+=('qmk')
fi
