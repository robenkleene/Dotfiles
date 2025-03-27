set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
set notermguicolors
let g:clipboard = {
      \ 'name': 'safe',
      \ 'copy': {
      \    '+': 'safecopy',
      \    '*': 'safecopy',
      \  },
      \ 'paste': {
      \    '+': 'safepaste',
      \    '*': 'safepaste',
      \ },
      \ 'cache_enabled': 0,
      \ }
endif
