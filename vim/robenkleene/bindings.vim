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
nnoremap <leader>os :source $MYVIMRC<CR>:echo "Sourced"<CR>
" Macros
" Open Macro
nnoremap <leader>ow :new<CR>:set buftype=nofile<CR>V"wp
" Source Macro
nnoremap <leader>om V"wd:bd<CR>

" Documentation
" nnoremap <leader>d :split ~/Documentation/development-references/Vim/<CR>:cd %<CR>:echo ""<CR>

" Toggle No Wrap
" Local to window
nnoremap <localleader>w :set wrap!<CR>
nnoremap <leader>w :set wrap!<CR>

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

" Source
nnoremap <leader>s :source vim_settings<CR>

" Make split resizing five lines instead of one
nnoremap <C-w>+ 5<C-w>+
nnoremap <C-w>- 5<C-w>-
nnoremap <C-w>< 5<C-w><
nnoremap <C-w>> 5<C-w>>

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
function! s:MarkdownLinkLines() range abort
  let @" = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/Development/Scripts/bin/markdown-link '.shellescape(expand('%:p')))
  let @* = @"
  echo "Yanked Markdown link"
endfunction
function! s:MarkdownLinkFile() abort
  let @" = system('~/Development/Scripts/bin/markdown-link '.shellescape(expand('%:p')))
  let @* = @"
  echo "Yanked Markdown link"
endfunction
vnoremap <localleader>L :'<,'>call <SID>MarkdownLinkLines()<CR>
nnoremap <localleader>L :call <SID>MarkdownLinkFile()<CR>

" Copy Path
nnoremap <leader>yp :let @*=expand("%:p")<CR>
nnoremap <leader>yf :let @*=expand("%:t")<CR>
nnoremap <leader>yd :let @*=expand('%:p:h:t')<CR>

" Backup Text
function! s:ArchiveLines(bang) range abort
  let file_path = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/Development/Scripts/bin/backup-text')
  if (a:bang == 1)
    let temp = @s
    silent normal! gv"sd
    let @s = temp
  endif
  let lineCount = system('wc -l < '.shellescape(file_path, 1).' | tr -d " " | tr -d "\n"')
  echom "Backed up ".lineCount." lines"
endfunction
command! -bang -range BackupText <line1>,<line2>call <SID>ArchiveLines(<bang>0)
vnoremap <localleader>B :'<,'>BackupText<CR>
vnoremap <localleader>D :'<,'>BackupText!<CR>

" Visual Star
" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype) abort
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

noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l

noremap <S-Left> <C-w>h
noremap <S-Down> <C-w>j
noremap <S-Up> <C-w>k
noremap <S-Right> <C-w>l

" Tab
" nnoremap <leader>c :tabnew<CR>
" nnoremap <C-w>t :tabnew<CR>
nnoremap <C-w>t <C-w>s<C-w>T
" nnoremap <leader>n gt
" nnoremap <leader>p gT
nnoremap <A-n> gt
nnoremap <A-p> gT
nnoremap <C-w>n gt
nnoremap <C-w>p gT

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
    " Make escape exit insert mode
    tnoremap <buffer> <Esc> <C-\><C-n>
  endfunction
  command! TigStatus call <SID>TigStatus()
  function! s:TigStatus() abort
    tabnew
    execute 'terminal EDITOR=nvim-edit tig status +3'
    " Make escape exit insert mode
    " tnoremap <buffer> <Esc> <C-\><C-n>
  endfunction

  nnoremap <leader>tt :call <SID>OpenTerminal()<CR>
  nnoremap <leader>ts :call <SID>TigStatus()<CR>
  " nnoremap <leader>tv :call <SID>OpenVTerminal()<CR>
  " nnoremap <leader>tt :call <SID>OpenTTerminal()<CR>
  command! Term :call <SID>OpenTerminal()
  command! VTerm :call <SID>OpenVTerminal()
  command! TTerm :call <SID>OpenTTerminal()
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif

function! s:GrepVisual() abort
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
function! s:GetBufferList() abort
  redir =>buflist 
  silent! ls 
  redir END 
  return buflist 
endfunction
function! s:ToggleQuickfixList() abort
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

" Todo
function! s:OpenTodo() abort
  if !empty($TODO_FILE)
    split
    edit $TODO_FILE
    return
  endif

  if !empty($TODO_DIRECTORY)
    split
    Explore $TODO_DIRECTORY 
    return
  endif

  echom "No TODO_FILE or TODO_DIRECTORY defined."
  " split
  " terminal zsh
  " tnoremap <buffer> <Esc> <C-\><C-n>
endfunction
nnoremap <leader>d :call <SID>OpenTodo()<CR>
