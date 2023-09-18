declare -a modules

modules=(
'pylint'
'autopep8'
'proselint'
'pipdeptree'
'vim-vint'
'pip-autoremove'
'rope'
'visidata'
)
if [[ "$(uname)" = "Linux" ]]; then
  modules+=('qmk')
fi
