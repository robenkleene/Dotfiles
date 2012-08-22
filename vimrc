" Config
call pathogen#infect()
syntax on
filetype plugin indent on
set nocompatible
" set nowrap
let mapleader = ','

" Makes the OS X clipboard work
set clipboard=unnamed

" Line breaks only happen on words
set linebreak

" Show line numbers
set number

" Alternative Solution to increment number while in tmux
nmap <leader>a <C-a>

" Solarized
syntax enable
set background=dark
colorscheme solarized

" Macros
nmap <leader>m :set filetype=markdown<CR>
nmap <leader>w :set nowrap!<CR>
nmap <leader>f :!open .<CR>\|:redraw!<CR>
