" Config
call pathogen#infect()
syntax on
filetype plugin indent on
set nocompatible
set nowrap
let mapleader = ','

" Makes the OS X clipboard work
set clipboard=unnamed

" Solarized
syntax enable
set background=dark
colorscheme solarized

" Macros
nmap <leader>m :set filetype=markdown<CR>
nmap <leader>w :set nowrap!<CR>
