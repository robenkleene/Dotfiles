" Disable Plugins
" let g:pathogen_disabled = []
" call add(g:pathogen_disabled, 'vim-sensible')

" Start Pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible

" Temp files
set directory=/tmp

" Explicitly 
" Shouldn't need this with vim-sensible
" set shell=bash

" colorscheme
colorscheme ir_black
" Get rid of the default yellow search highlighting
" hi Search ctermbg=DarkGray

" set nowrap
let mapleader = ','

" Makes the OS X clipboard work
" set clipboard=unnamed

" Line breaks only happen on words
set linebreak

" Show line numbers
set number

" Search Behavior
set hlsearch
" set ignorecase
" set smartcase

" Macros

" Make Markdown Filetype
nmap <leader>m :set filetype=markdown<CR>

" Toggle No Wrap
nmap <leader>w :set nowrap!<CR>

" Open folder of current file
nmap <leader>f :!open .<CR>\|:redraw!<CR>

" Copy contents of whole file
nmap <leader>c :%y+<CR>

" Alternative Solution to increment number while in tmux
nmap <leader>a <C-a>

" Open next URL in file
map <leader>u :.,$w !openurl<CR>    

" Detect File type
map <leader>d :filetype detect<CR>
