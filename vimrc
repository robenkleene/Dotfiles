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
" let mapleader=" "
" Allow hidden buffers
set hidden
" set list
" Tabs
" Set with `.editorconfig`
" set tabstop=4
" set shiftwidth=4
" set softtabstop=4
" set expandtab
" Text
set nowrap
set cursorline " Highlight cursor line
set colorcolumn=80 " Show 80 character bar
set linebreak " Line breaks only happen on words
set number " Show line numbers
set hlsearch " Highlight search results
set foldmethod=syntax
set nofoldenable
" set ignorecase " Ignore case in search results
" set smartcase " Override `ignorecase`


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


" Autocmd

" Make Shebang Files Executable
function! MakeShebangFilesExecutable()
    if match(getline(1), '^\#!') == 0
        if match(getfperm(expand('%:p')), 'x') == -1
            !chmod +x %
        endif
    endif
endfunction
augroup executablefiles
    autocmd!
    autocmd BufWritePost *.sh :call MakeShebangFilesExecutable()
augroup END


" Look & Feel

if !has('gui_running')
    " Colorscheme
    set background=dark
    colorscheme jellybeans
    " Background
    let bgcolor='NONE'
    let backgroundgroups = ['CursorColumn', 'CursorLine', 
                \ 'NonText', 'SpecialKey', 'VertSplit',
                \ 'Normal'] 
    for group in backgroundgroups
        exe 'highlight ' . group . ' ctermbg=' . bgcolor
    endfor
    " Line Numbers
    let guttercolor='darkgray'
    let guttergroups = ['LineNr', 'SignColumn', 'FoldColumn', 'CursorLineNr']
    for group in guttergroups
        exe 'highlight ' . group . ' ctermbg=' . guttercolor
    endfor
    highlight LineNr ctermfg=lightgray
    " StatusLine
    highlight StatusLine ctermbg=lightgray ctermfg=black
    highlight StatusLineNC ctermbg=darkgray ctermfg=lightgray
    " Tildes
    highlight  NonText ctermfg=darkgray
    " ColorColumn
    highlight ColorColumn ctermbg=darkgray
    " Diff Colors
    highlight DiffAdd ctermfg=green ctermbg=darkgreen
    highlight DiffDelete ctermfg=red ctermbg=darkred
    highlight DiffChange ctermbg=darkcyan
    highlight DiffText ctermfg=lightblue ctermbg=darkblue
endif


" Status Line

" Space Buffer
set statusline=\ 
" Working Directory
set statusline+=%{fnamemodify(getcwd(),':t')}\ 
" Truncate Marker
set statusline+=%<
" Filename
set statusline+=%-.30f
" Modified
set statusline+=%m 
" Filetype
set statusline+=\ %y
" Switch to right
set statusline+=%=
" Line
set statusline+=L%l
" Column
set statusline+=\ C%c
" Location
set statusline+=\ %P
" Git status
set statusline+=\ %{fugitive#statusline()}
" Space Buffer
set statusline+=\ 


" Key Commands

" vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Toggle No Wrap
nnoremap <leader>w :set wrap!<CR>
" Copy to System Clipboard
nnoremap <leader>c :%y+<CR>
vnoremap <leader>c "+y
" Paste from System Clipboard
nnoremap <leader>v "+p
vnoremap <leader>v "+p

" Reveal Current File
" nnoremap <leader>re :!open -R "%:p"<CR>\|:redraw!<CR>
" Open folder of current file
" nnoremap <leader>o :!open .<CR>\|:redraw!<CR>
" Copy contents of whole file
" nmap <leader>c :%y+<CR>
" Alternative Solution to increment number while in tmux
" nmap <leader>a <C-a>
" Open next URL in file
" map <leader>u :.,$w !openurl<CR>    
" Detect File type
" map <leader>d :filetype detect<CR>
" Make Markdown Filetype
" nmap <leader>m :set filetype=markdown<CR>
