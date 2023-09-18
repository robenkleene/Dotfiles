declare -a modules

modules=(
'pipdeptree'
'pip-autoremove'
'rope'
'visidata'
)
if [[ "$(uname)" = "Linux" ]]; then
  modules+=('qmk')
fi
