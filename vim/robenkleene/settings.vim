" vim:foldmethod=marker

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
" Syntax highlighting
syntax on

" Use system clipboard by default
set clipboard=unnamed 

" Leader
let maplocalleader = ","

" Allow hidden buffers
set hidden

" Text
set nowrap

" Automatically change the working directory
set autochdir

" Line breaks only happen on words
set linebreak 

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

" open previews vertically
let g:netrw_preview = 1


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


" Languages {{{1

" Doesn't work in ftplugin
let g:xml_syntax_folding=1
