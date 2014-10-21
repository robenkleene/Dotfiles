" vim:foldmethod=marker

" Startup {{{1

if &shell =~# 'fish$'
    set shell=sh
endif


" Plugins {{{1

" Pathogen
" Disable Plugins
" let g:pathogen_disabled = ["vim-rsi"]
execute pathogen#infect()
syntax on
filetype plugin indent on


" Basic {{{1

set nocompatible
set directory=/tmp " Temp files
" Use system clipboard by default
set clipboard=unnamed 
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
" Ignore case in search results
set ignorecase
" Override `ignorecase`
set smartcase

" Normalizing Movement Key Commands {{{1

" Kill line
noremap <C-k> <C-O>d$
cnoremap <C-K> <C-\>e<SID>KillLine()<CR>
function! s:KillLine()
    let l:cmd = getcmdline()
    let l:rem = strpart(l:cmd, getcmdpos() - 1)
    if ('' != l:rem)
        let @c = l:rem
    endif
    let l:ret = strpart(l:cmd, 0, getcmdpos() - 1)
    return l:ret
endfunction


" Autocmd {{{1

" Make Shebang Files Executable
function! s:MakeShebangFilesExecutable()
    if match(getline(1), '^\#!') == 0
        if match(getfperm(expand('%:p')), 'x') == -1
            !chmod +x %
        endif
    endif
endfunction
augroup executablefiles
    autocmd!
    autocmd BufWritePost *.sh :call <SID>MakeShebangFilesExecutable()
augroup END


" Look & Feel {{{1

if !has('gui_running')
    " Colorscheme
    set background=dark
    colorscheme jellybeans
    " Background
    let s:bgcolor='NONE'
    " Built-in
    let s:backgroundgroups = ['CursorColumn', 'CursorLine', 
                \ 'NonText', 'SpecialKey', 'VertSplit',
                \ 'Normal', 'SignColumn', 'FoldColumn']
    " Set Background Colors
    for group in s:backgroundgroups
        exe 'highlight ' . group . ' ctermbg=' . s:bgcolor
    endfor
    " Line Numbers
    let s:guttercolor='darkgray'
    let s:guttergroups = ['LineNr', 'CursorLineNr', 'StatusLineNC']
    " Set Gutter Colors
    for group in s:guttergroups
        exe 'highlight ' . group . ' ctermbg=' . s:guttercolor
    endfor
    highlight LineNr ctermfg=lightgray
    " StatusLine
    highlight StatusLine ctermbg=lightgray ctermfg=black
    " NC StatusLine bg is gutter color
    highlight StatusLineNC ctermfg=lightgray
    " Tildes
    highlight  NonText ctermfg=darkgray
    " ColorColumn
    highlight ColorColumn ctermbg=darkgray
    " Vimdiff Colors
    highlight DiffAdd ctermfg=green ctermbg=darkgreen
    highlight DiffDelete ctermfg=red ctermbg=darkred
    highlight DiffChange ctermfg=NONE ctermbg=NONE
    highlight DiffText ctermfg=lightblue ctermbg=darkblue
    " Git Gutter Colors
    highlight GitGutterAdd ctermfg=green
    highlight GitGutterChange ctermfg=lightblue
    highlight GitGutterDelete ctermfg=red
endif


" Status Line {{{1

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


" Key Commands {{{1

" vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Toggle No Wrap
nnoremap <leader>w :set wrap!<CR>
" Copy to system clipboard
" nnoremap <leader>c :%y+<CR>
" vnoremap <leader>c "+y
" Paste from system clipboard
" nnoremap <leader>v "+p
" vnoremap <leader>v "+p
" Copy line to system clipboard
" nnoremap <leader>yy "+yy
" Open Working Directory in Terminal
nnoremap <leader>t :silent !open -a Terminal "%:p:h"<CR>
" Copy Contents of File and Close Without Saving
" nnoremap <leader>Q :%w !pbcopy<CR>:q!<CR>
function! s:CopyToSystemClipboardAndClean()
    " Delete blank lines at end of file
    execute 'silent! v/\_s*\S/d'
    nohlsearch
    if line('$') == 1
        execute '%w !tr -d "\n" | pbcopy' 
    else
        execute '%w !pbcopy'
    endif
endfunction
nnoremap <leader>Q :call <SID>CopyToSystemClipboardAndClean()<CR>:q!<CR>
nnoremap <leader>C :silent call <SID>CopyToSystemClipboardAndClean()<CR>
nnoremap <silent> <leader>cc :silent .w !sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' 
            \ <BAR> tr -d "\n" <BAR> pbcopy<CR>
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
