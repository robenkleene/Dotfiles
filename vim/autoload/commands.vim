" Make the current buffer a grep buffer
function! commands#GrepBuffer() abort
  execute "setlocal buftype=nofile bufhidden=hide noswapfile"
  " `cbuffer`: Convert to `quickfix`
  " `bprevious`: Go back to grep input
  " `bdelete`: Delete the grep buffer
  if line('$') == 1
    " Don't show the quickfix list if there's exactly one match
    execute "cbuffer | bprevious | bdelete"
  else
    execute "cbuffer | bprevious | bdelete | cw | wincmd k"
  endif
endfunction

" Disable backgrounding
function! commands#DisableBackgrounding() abort
  nnoremap <C-z> :echom "Backgrounding is disabled"<CR>
  vnoremap <C-z> :echom "Backgrounding is disabled"<CR>
endfunction

" Save & Restore Sessions
function! commands#QuitSaveSession() abort
  SessionSave
  qa
endfunction

" Go to `git` root
function! commands#Gcd() abort
  let l:git_root = system('git rev-parse --show-toplevel | tr -d "\n"')
  if v:shell_error == 0
    execute 'lcd '.fnameescape(l:git_root)
  else
    echo "Not in a git respository."
  endif
endfunction

" `rg`
function! commands#Rg(terms) abort
  let l:original_grepprg = &grepprg
  set grepprg=rg\ --smart-case\ --vimgrep\ --no-heading
  execute "silent grep " . a:terms
  " Without `silent`, the terminal output is seen and enter is required to go
  " to the first match
  " execute "grep " . a:terms
  if !has('nvim')
    " The screen gets messed up in `vim` without this
    redraw!
  endif
  let &grepprg = l:original_grepprg
  if len(getqflist())
    copen
    wincmd p
  endif
endfunction

" `rg` & `tmux`
function! commands#Atm(terms) abort
  let l:original_grepprg = &grepprg
  set grepprg=tmux-paths-rg
  execute "grep " . a:terms
  let &grepprg = l:original_grepprg
endfunction

" Splits
function! commands#New(type) abort
  " Note it seems like it's impossible to make a function take an optional
  " range, because at the `command`-level whether there is a visual selection
  " or not gets lost
  " A nice feature if that were possible would be to have the split start with
  " the visual selection, here's some code for that:
  " let s:selection = join(getline("'<", "'>"), "\n")
  let current_filetype = &filetype
  execute a:type
  let &filetype = current_filetype
  " let reg_save = @@
  " let @@ = s:selection
  " normal ""p
  " let @@ = reg_save
endfunction

" Lint
function! commands#Lint() abort
  if !exists('b:LintMakePrg')
    echo "No b:LintMakePrg defined"
    return
  endif
  let l:original_makeprg = &makeprg
  let l:original_errorformat = &errorformat
  let &makeprg = b:LintMakePrg
  let &errorformat = b:LintErrorFormat
  make
  let &makeprg = l:original_makeprg
  let &errorformat = l:original_errorformat
endfunction

function! commands#DeleteEOFWhitespace() abort
  let l:cursor_pos = getpos(".")
  execute '0;/^\%(\_s*\S\)\@!/,$d'
  call cursor(l:cursor_pos[1], l:cursor_pos[2])
endfunction

" Format
function! commands#Format() abort
  if !exists('b:FormatPrg')
    echo "No b:FormatPrg defined"
    return
  endif
  let l:cursor_pos = getpos(".")
  execute "%!" . b:FormatPrg
  call cursor(l:cursor_pos[1], l:cursor_pos[2])
endfunction

" Execute
function! commands#Execute() abort
  if !exists('b:ExecutePrg')
    echo "No b:ExecutePrg defined"
    return
  endif
  execute "%w !" . b:ExecutePrg
endfunction

function! commands#ExecuteVisual() abort
  if !exists('b:ExecutePrg')
    echo "No b:ExecutePrg defined"
    return
  endif
  execute "'<,'>w !" . b:ExecutePrg
endfunction

" Run
function! commands#Run() abort
  if !exists('b:RunMakePrg')
    echo "No b:RunMakePrg defined"
    return
  endif
  let l:original_makeprg = &makeprg
  let l:original_errorformat = &errorformat
  let &makeprg = b:RunMakePrg
  let &errorformat = b:RunErrorFormat
  make
  let &makeprg = l:original_makeprg
  let &errorformat = l:original_errorformat
endfunction

function commands#SlugProject(name) abort
    execute '!slug_project' a:name
endfunction
