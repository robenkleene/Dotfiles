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
      \ 'cache_enabled': 1,
      \ }
" Don't load the default `:Man` command, use the `vim-man` command instead
" because it supports `<tab>` complection with `MANPATH`
let g:loaded_man = 1
