" vim:fdm=marker
" Disable Plugins
" let g:pathogen_disabled = ["vim-rsi"]

if &shell =~# 'fish$'
    set shell=sh
endif

" Pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

" Basic
set nocompatible
set directory=/tmp " Temp files
" set clipboard=unnamed " Make the OS X clipboard work
" let mapleader = ','

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" Text
set nowrap

" Leader
let mapleader=" "

" vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Normalizing Key Commands
" Kill line
noremap <C-k> <C-O>d$
cnoremap <C-K> <C-\>e<SID>KillLine()<CR>
function! <SID>KillLine()
    let l:cmd = getcmdline()
    let l:rem = strpart(l:cmd, getcmdpos() - 1)
    if ('' != l:rem)
        let @c = l:rem
    endif
    let l:ret = strpart(l:cmd, 0, getcmdpos() - 1)
    return l:ret
endfunction

" Look & Feel
" colorscheme ir_black
colorscheme jellybeans
if !has('gui_running')
	highlight Normal ctermbg=NONE
	highlight LineNr ctermbg=NONE
	highlight SpecialKey ctermbg=NONE
	highlight NonText ctermbg=NONE
	highlight VertSplit ctermbg=NONE
	highlight FoldColumn ctermbg=NONE
	highlight SignColumn ctermbg=NONE
endif
highlight CursorColumn ctermbg=NONE
highlight CursorLine ctermbg=NONE
highlight ColorColumn ctermbg=NONE
set cursorline
" hi Search ctermbg=DarkGray " Search highlight color
set linebreak " Line breaks only happen on words
set number " Show line numbers
set hlsearch " Highlight search results
" set ignorecase " Ignore case in search results
" set smartcase " Override `ignorecase`
augroup run_once
    autocmd!
    " highlight line number in insert mode
"    autocmd InsertEnter * set cul
"    autocmd InsertLeave * set nocul
augroup END
" Leader Commands
" Make Markdown Filetype
" nmap <leader>m :set filetype=markdown<CR>
" Toggle No Wrap
nnoremap <leader>w :set wrap!<CR>
" Reveal Current File
nnoremap <leader>re :!open -R "%:p"<CR>\|:redraw!<CR>
" Open folder of current file
nnoremap <leader>o :!open .<CR>\|:redraw!<CR>
" Copy contents of whole file
" nmap <leader>c :%y+<CR>
" Alternative Solution to increment number while in tmux
" nmap <leader>a <C-a>
" Open next URL in file
" map <leader>u :.,$w !openurl<CR>    
" Detect File type
" map <leader>d :filetype detect<CR>
