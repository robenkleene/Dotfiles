" vim:foldmethod=marker

" Startup {{{1

if &shell =~# 'fish$'
    set shell=sh
endif


" Plugins {{{1

" Pathogen
" Disable Plugins
"let g:pathogen_disabled = ["vim-commentary"]
" colorizer causes help files to open slowly
let g:pathogen_disabled = ["nerdcommenter"]
execute pathogen#infect('bundle/{}', 'plugin/{}')
syntax on
filetype plugin indent on

" colorizer
" Disable on startup because it slows down Vim
let g:colorizer_startup = 0

" neocomplete
let g:neocomplete#enable_at_startup = 1
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Use CursorHoldI to delay popup by miliseconds
"let g:neocomplete#enable_cursor_hold_i = 1
"let g:neocomplete#cursor_hold_i_time   = 200
" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" CtrlP
command! Re :CtrlPMRU
command! Bu :CtrlPBuffer
command! Sy :CtrlPBufTag
" Ctrl-N/P for moving up and down
let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")':   ['<c-j>', '<c-n>'],
    \ 'PrtSelectMove("k")':   ['<c-k>', '<c-p>'],
    \ 'PrtHistory(-1)':       [''],
    \ 'PrtHistory(1)':        [''],
    \ }
    " 'PrtHistory(-1)':       ['<down>'],
    " 'PrtHistory(1)':        ['<up>'],
" let g:ctrlp_buffer_func = {
"     \ 'enter': 'EnterCtrlP',
"     \ 'exit':  'ExitCtrlP',
"     \ }
" function EnterCtrlP()
"     match Search /.*\%#.*/
" endfunction
" function ExitCtrlP()
" endfunction

" Restore View
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

" Tagbar
nnoremap <leader>tt :TagbarToggle<CR>

" Temporary Directories {{{1
" Swap File directory
" Double-slash prevents name collusions
let s:temporary_directory = "/tmp/vim.robenkleene/"
let s:swap_file_directory = s:temporary_directory . "swap"
let s:viewdir_directory = s:temporary_directory . "view"
if !isdirectory(s:swap_file_directory)
    call mkdir(s:swap_file_directory, 'p')
endif
if !isdirectory(s:viewdir_directory)
    call mkdir(s:viewdir_directory, 'p')
endif
let &directory=s:swap_file_directory . "//"
let &viewdir=s:viewdir_directory


" Basic {{{1
set nocompatible
" Use system clipboard by default
set clipboard=unnamed 
" let mapleader = ','
" let mapleader=" "
" Allow hidden buffers
set hidden
" set list
" Tabs
" Now set with `.editorconfig`
" set tabstop=4
" set shiftwidth=4
" set softtabstop=4
" set expandtab
" Text
set nowrap
" Show 80 character bar
set colorcolumn=80 
" Highlight cursor line
set cursorline 
augroup quickfixcolors
    autocmd!
    " These interfere with quickfix highlighting
    autocmd BufWinEnter * if &buftype == 'quickfix' | setlocal nocursorline | endif
    autocmd BufWinEnter * if &buftype == 'quickfix' | setlocal colorcolumn="" | endif
augroup END
" Line breaks only happen on words
set linebreak 
" Show line numbers
set number 
" Highlight search results
set hlsearch 
" Don't display search highlight on startup
nohlsearch
" Fold Method
set foldmethod=syntax
" Don't Start Folded
set nofoldenable
" Ignore case in search results
set ignorecase
" Override `ignorecase`
set smartcase
" Don't let smartase affect autocomplete
set infercase
" Indented Line-breaks
set breakindent

" Normalizing Movement Key Commands {{{1

" Kill line
inoremap <C-k> <C-O>d$
" nnoremap <C-k> <C-O>d$
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


" Colors {{{1

if !has('gui_running')
    " Colorscheme
    set background=dark
    colorscheme jellybeans
    " Background
    let s:bgcolor = 'NONE'
    let s:backgroundgroups = ['CursorColumn', 
                \ 'NonText', 'SpecialKey', 'VertSplit',
                \ 'Normal', 'SignColumn', 'FoldColumn']
    " Set Background Colors
    for group in s:backgroundgroups
        exe 'highlight ' . group . ' ctermbg=' . s:bgcolor
    endfor
    " Line Numbers
    let s:guttercolor = 'NONE'
    let s:guttergroups = ['LineNr']
    for group in s:guttergroups
        exe 'highlight ' . group . ' ctermbg=' . s:guttercolor
    endfor
    highlight LineNr ctermfg=darkgray
    " Selection
    let s:selectionbgcolor = 'lightblue'
    let s:selectionfgcolor = 'black'
    let s:selectiongroups = ['Search', 'Wildmenu']
    for group in s:selectiongroups
        exe 'highlight ' . group . ' ctermbg=' . s:selectionbgcolor  . ' ctermfg=' .  
                    \ s:selectionfgcolor
    endfor
    highlight Visual ctermfg=white ctermbg=darkcyan
    highlight IncSearch ctermfg=darkcyan ctermbg=white
    highlight Search cterm=NONE
    " StatusLine
    highlight StatusLine ctermbg=lightgray ctermfg=black
    " NC StatusLine bg is gutter color
    highlight StatusLineNC ctermfg=lightgray ctermbg=darkgray
    " Cursorline
    highlight Cursorline ctermbg=black
    highlight CursorLineNr ctermbg=black
    " ColorColumn
    highlight ColorColumn ctermbg=black
    " Tildes
    highlight NonText ctermfg=darkgray
    " Vimdiff Colors
    highlight DiffAdd ctermfg=green ctermbg=darkgreen
    highlight DiffDelete ctermfg=red ctermbg=darkred
    highlight DiffChange ctermfg=NONE ctermbg=NONE
    highlight DiffText ctermfg=lightblue ctermbg=darkblue
    " Git Gutter Colors
    highlight GitGutterAdd ctermfg=green
    highlight GitGutterChange ctermfg=lightblue
    highlight GitGutterDelete ctermfg=red
    highlight GitGutterAddDefault ctermbg=NONE ctermfg=green
    highlight GitGutterChangeDefault ctermbg=NONE ctermfg=lightblue
    highlight GitGutterDeleteDefault ctermbg=NONE ctermfg=red
    highlight GitGutterAddInvisible ctermbg=NONE ctermfg=green
    highlight GitGutterChangeInvisible ctermbg=NONE ctermfg=lightblue
    highlight GitGutterDeleteInvisible ctermbg=NONE ctermfg=red
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


" Commands {{{1
if exists("*synstack")
    " Syntax Groups
    function! s:SyntaxGroups()
        return join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'))
    endfunc
    " Echo Syntax Group
    command! EchoSyntaxGroups :echo <SID>SyntaxGroups()
    " Yank Syntax Group
    command! YankSyntaxGroups :let @" = <SID>SyntaxGroups()|:let @+ = @"|:echo @"

    " Syntax Colors
    function! s:SyntaxColors()
        let syntaxcolors = 'fg:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg")
        let syntaxcolors .= ' fg#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")
        let syntaxcolors .= ' bg:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg")
        let syntaxcolors .= ' bg#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg#")
        let syntaxcolors .= ' sp:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"sp")
        let syntaxcolors .= ' sp#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"sp#")
        let syntaxcolors .= ' italic:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"italic")
        let syntaxcolors .= ' reverse:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"reverse")
        let syntaxcolors .= ' inverse:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"inverse")
        let syntaxcolors .= ' standout:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"standout")
        let syntaxcolors .= ' underline:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"underline")
        let syntaxcolors .= ' undercurl:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"undercurl")
        return syntaxcolors
    endfunc
    " Echo Syntax Colors
    command! EchoSyntaxColors :echo <SID>SyntaxColors()
endif
command! RunHighlightTest :source $VIMRUNTIME/syntax/hitest.vim
command! RunColorTest :source $VIMRUNTIME/syntax/colortest.vim


" Key Commands {{{1

" vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>:echo "Sourced"<CR>
" Toggle No Wrap
nnoremap <leader>w :set wrap!<CR>
" Spacebar
nnoremap <space> <PageDown>
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
" Copy to system clipboard
" nnoremap <leader>\B :%y+<CR>
" vnoremap <leader>c "+y

" Ergonomic Bindings {{{1
" Block hard keys
" inoremap <C-[> <NOP>
" nnoremap <C-f> <NOP>
" nnoremap <C-b> <NOP>
" Alternative <ESC>
inoremap jk <ESC>
