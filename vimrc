" Config
call pathogen#infect()
syntax on
filetype plugin indent on
set nocompatible

" Temp files
set directory=/tmp

" Explicitly 
set shell=bash

" colorscheme
colorscheme desert

" Get rid of the default yellow search highlighting
hi Search ctermbg=DarkGray

" set nowrap
let mapleader = ','

" Makes the OS X clipboard work
set clipboard=unnamed

" Line breaks only happen on words
set linebreak

" Show line numbers
set number

" Search Behavior
set ignorecase
set smartcase
set incsearch

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

