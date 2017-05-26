" Key Commands {{{1

" `C-G` to `<Esc>` like Emacs
" rsi plugin implementation
" cmap <script> <C-G> <C-C>
" vnoremap <C-g> <Esc>:f<CR>

" Backwards delete word
" noremap! <M-BS> <C-W>
" if !has("gui_running") && !has('nvim')
"   silent! exe "set <F34>=\<Esc>\<C-?>"
"   silent! exe "set <F35>=\<Esc>\<C-H>"
"   map! <F34> <M-BS>
"   map! <F35> <M-BS>
"   map <F34> <M-BS>
"   map <F35> <M-BS>
" endif

" Fix Y
nnoremap Y y$

" Alternative exit insert mode
" inoremap jk <esc>

" `C-y` paste like in Emacs
" cnoremap <C-y> <C-r>*
" inoremap <C-y> <C-r>*

" `C-w` insert word at point like Emacs
" cnoremap <C-w> <C-R><C-W>

" Tabs
" nnoremap <leader>tn :tabnew<CR>
" nnoremap <leader>tc :tabclose<CR>
" nnoremap <leader>te :tabedit %<CR>

" vimrc
nnoremap <leader>oi :cd ~/Development/Dotfiles/vim/robenkleene/<CR>:edit robenkleene.vim<CR>:echo ""<CR>
" nnoremap <leader>si :source $MYVIMRC<CR>:echo "Sourced"<CR>

" Documentation
" nnoremap <leader>d :split ~/Documentation/development-references/Vim/<CR>:cd %<CR>:echo ""<CR>

" Toggle No Wrap
" Local to window
nnoremap <localleader>w :set wrap!<CR>

" Toggle Seplling
" Local to window
nnoremap <localleader>s :set spell!<CR>

" Open Working Directory in Terminal
nnoremap <leader>T :silent !open -a Terminal "%:p:h"<CR>\|:redraw!<CR>

" Reveal Current File
nnoremap <leader>R :silent !open -R "%:p"<CR>\|:redraw!<CR>

" TextMate
nnoremap <leader>E :silent !mate --async "%:p"<CR>\|:redraw!<CR>

" Xcode
nnoremap <leader>X :silent !open -a Xcode "%:p"<CR>\|:redraw!<CR>

" `make`
nnoremap <leader>m :make<CR>

" Rg
nnoremap <leader>a :Rg 

" Copy Current line to clipboard cleaned for shell pasting
" I.e., this removes any whitespace form the beginning and end of the line
" and removes the last new line
" nnoremap <silent> <leader>yy :silent .w !sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' 
"             \ <BAR> tr -d "\n" <BAR> pbcopy<CR>

" Move frames
" Handled by `vim-tmux-navigator`
" nnoremap <S-Down> <C-w><C-j>
" nnoremap <S-Up> <C-w><C-k>
" nnoremap <S-Right> <C-w><C-l>
" nnoremap <S-Left> <C-w><C-h>


" Markdown link
function! s:MarkdownLinkLines() range
  let @" = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/Development/Scripts/bin/markdown-link '.shellescape(expand('%:p')))
  let @* = @"
  echo "Yanked Markdown link"
endfunction
function! s:MarkdownLinkFile()
  let @" = system('~/Development/Scripts/bin/markdown-link '.shellescape(expand('%:p')))
  let @* = @"
  echo "Yanked Markdown link"
endfunction
vnoremap <localleader>L :'<,'>call <SID>MarkdownLinkLines()<CR>
nnoremap <localleader>L :call <SID>MarkdownLinkFile()<CR>

" Copy Path
nnoremap <leader>p :let @*=expand("%:p")<CR>

" Visual Star
" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" Panes
" The problem with `tmux` Vim navigator is that if Vim is opened form a
" subprocess in a `tmux` pane (e.g., `tig -> Vim`), then moving between Vim
" panes will break, because `tmux` won't be able to detect that Vim is
" actually running as a child of `tig`.

if !has('nvim')
  let c='a'
  while c <= 'z'
    exec "set <M-".tolower(c).">=\e".c
    exec "nnoremap \e".c." <M-".tolower(c).">"
    let c = nr2char(1+char2nr(c))
  endw
endif

noremap <silent> <A-h> <C-w>h
noremap <silent> <A-j> <C-w>j
noremap <silent> <A-k> <C-w>k
noremap <silent> <A-l> <C-w>l

noremap <silent> <S-Left> <C-w>h
noremap <silent> <S-Down> <C-w>j
noremap <silent> <S-Up> <C-w>k
noremap <silent> <S-Right> <C-w>l


" Neovim Terminal
if has('nvim')
  function! s:OpenTTerminal()
    " Only remap `<Esc>` in this buffer so it doesn't interfere
    " with commands that spawn terminals like `fzf`
    tabnew
    terminal zsh
    tnoremap <buffer> <Esc> <C-\><C-n>
  endfunction
  function! s:OpenTerminal()
    " Only remap `<Esc>` in this buffer so it doesn't interfere
    " with commands that spawn terminals like `fzf`
    split
    terminal zsh
    tnoremap <buffer> <Esc> <C-\><C-n>
  endfunction
  function! s:OpenVTerminal()
    " Only remap `<Esc>` in this buffer so it doesn't interfere
    " with commands that spawn terminals like `fzf`
    vsplit
    terminal zsh
    tnoremap <buffer> <Esc> <C-\><C-n>
  endfunction

  nnoremap <leader>ts :call <SID>OpenTerminal()<CR>
  nnoremap <leader>tv :call <SID>OpenVTerminal()<CR>
  nnoremap <leader>tt :call <SID>OpenTTerminal()<CR>
  command! Term :call <SID>OpenTerminal()
  command! VTerm :call <SID>OpenVTerminal()
  command! TTerm :call <SID>OpenTTerminal()
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif

function! s:GrepVisual()
  let temp = @s
  norm! gv"sy
  execute "Rg --fixed-strings '" . @s . "'"
  let @s = temp
  if len(getqflist())
    copen
  endif
endfunction
" With a visual selection, an exact term is searched for
" With no visual selection, the current word is searched for
" (The `\\|` is not intuitive, this is because `|` separates commands in
" Vimscript)
nnoremap <leader>* :Rg '(^\\|\W)<C-r><C-w>($\\|\W)'<CR>
vnoremap <leader>* :<C-u>call <SID>GrepVisual()<CR>

" Toggle `quickfix`
function! s:GetBufferList() 
  redir =>buflist 
  silent! ls 
  redir END 
  return buflist 
endfunction
function! s:ToggleQuickfixList()
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))') 
    if bufwinnr(bufnum) != -1
      cclose
      return
    endif
  endfor
  let winnr = winnr()
  copen
  if winnr() != winnr
    wincmd p
  endif
endfunction
nnoremap <script> <silent> <leader>q :call <SID>ToggleQuickfixList()<CR>
