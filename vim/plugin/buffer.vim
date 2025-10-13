" Autoreload files edited by other programs
set autoread

" This causes a delay when opening the command-line window with `<C-f>`?
" Maybe `set autoread` is enough? `set autoread` doesn't seem to do anything,
" apparently it only works in `gvim`
augroup reload_buffers
  autocmd!
  " Oddly, `silent! checktime` doesn't seem to update after a `git checkout
  " <file>` while just `checktime` does. (`silent! checktime` when editing the
  " same file in another `vim` instance though.)
  "
  " Running `checktime` on buffers from process substitution (e.g., `vim
  " <(ls)`) on macOS breaks those buffers (they become empty)
  " So only run `checktime` on buffers that do not start with `/dev/fd`
  " (process substitution starts with this on macOS)

  " In Zsh, `nvim =(ls)` can be used as a workaround for process substitution
  " not working
  autocmd BufEnter,FocusGained,CursorHold,CursorHoldI * if mode() != 'c'
        \ && expand('%') !=# '[Command Line]'
        \ && getcmdwintype() == ''
        \ && bufname('%') !~# '^/dev/fd'
        \ | execute 'checktime '.bufnr('%')
        \ | endif
augroup END
" Set `CursorHold` interval in ms, default is `4000` so buffers refresh more
" often
set updatetime=1000

" Do not extend comments automatically, e.g., with `O`
augroup disable_autocomments
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" Indent wrapped lines
set breakindent

set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set list
augroup auto_insert
  autocmd!
  " Toggle off `list` so white space isn't visible in insert mode
  " Toggle off `ignorecase` because case sensitivity is shared between search
  " and completion, we want search to be case insensitive, and completion to
  " be case sensitive
  " Disabling ignorecase because it's off by default now and this overwrites
  " that
  autocmd InsertEnter * setlocal nolist | setlocal noignorecase
  autocmd InsertLeave * setlocal list | setlocal ignorecase
  " autocmd InsertEnter * setlocal nolist
  " autocmd InsertLeave * setlocal list
augroup END

" Disable swap files, this allows multiple instances to edit the same file
" Don't do this to be able to recover unnamed buffers if vim crashes
" set noswapfile
" Prefer spaces to tabs
set expandtab

" Show column vertical line
" Don't set a `textwidth` explicitly, it has too many side effects like giving
" a text width in buffers with no filetype set
set textwidth=80
" `+0` means match `colorcolumn` to `textwidth`
set colorcolumn=+0
" Line breaks only happen on words
set linebreak
" Launch without wrapped lines
set nowrap
" Don't timeout leader key
"set notimeout
" Don't turn off timeout instead set it a bit longer, this way if part of a
" command is accidently typed, e.g., `"*` to specify a register, and then you
" want to start over, you can just wait to start over. Without this, there
" doesn't seem to be a way to start over without side effects (e.g., `esc`
" will disable a visual mode selection).
"set timeoutlen 3000
" Don't prompt when trying to navigate to another buffer when current buffer
" is modified
" This causes the `%` register to not be set when opening a directory, e.g.,
" `vim .` the `%` register won't be set and `cd %` will fail
" Without this, navigating away from a buffer will "abandon" it, i.e., remove
" it from the buffer list and discard its contents. This means `gF` to go to a
" grep line followed by `<C-o>` to go back will fail
set hidden

" This is necessary because Vim does not have a command to write all modified
" files that are backed by buffers and force quit modified buffers that aren't
" backed by files (e.g., what you'd think `:wqa` with a bang would do, but it
" doesn't support a bang).
" Disabling this beause it means swapfiles aren't created
" augroup nofilename_nofile
"   autocmd!
"   " Don't prompt for saving buffers with no file
"   autocmd BufEnter * if eval('@%') == '' && &buftype == '' | setlocal buftype=nofile | end
" augroup END
