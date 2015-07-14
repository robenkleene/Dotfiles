" vim:foldmethod=marker

" Key Commands {{{1

" vimrc
" nnoremap <leader>oi :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>:echo "Sourced"<CR>
" Toggle No Wrap
nnoremap <leader>w :set wrap!<CR>
" Spacebar
" nnoremap <space> <PageDown>
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
nnoremap <leader>f :silent !open -R "%:p"<CR>\|:redraw!<CR>
" Open File in TextMate
nnoremap <leader>e :silent !mate --async "%:p"<CR>\|:redraw!<CR>
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
" Use normal mode C-L in insert mode
" inoremap <silent> <C-L> <C-O>:nohlsearch<CR><C-O><C-L>
" Sanity
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap <Up> gk
noremap <Down> gj
" Ergonomic Bindings {{{1
" Block hard keys
" inoremap <C-[> <NOP>
" nnoremap <C-f> <NOP>
" nnoremap <C-b> <NOP>
" Alternative <ESC>
" inoremap jk <ESC>
