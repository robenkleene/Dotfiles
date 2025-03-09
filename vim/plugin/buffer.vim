" Indent wrapped lines
set breakindent

set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set list

" Disable swap files, this allows multiple instances to edit the same file
set noswapfile
" Prefer spaces to tabs
set expandtab

" Show column vertical line
" `+0` means match `colorcolumn` to `textwidth`
" Don't set a `textwidth` explicitly, it has too many side effects like giving
" a text width in buffers with no filetype set
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
