" Sensible turns it on, and it's on by default in Neovim
" Incremental search
" The reason to keep this off is if you have a function definition on screen,
" and want to see if a string exists in that function definition, with
" `incsearch` you can't tell because you jump away from the function context
" while typing.
" set noincsearch

" Smartcase
" Without this, a lowercase search will not match words with uppercase
" letters, even if `smartcase` is on
set ignorecase
" Use `\C` to make case-sensitive
" Or just use `\c` to make search case insensitive
set smartcase

" Don't display saved search highlights on startup
nohlsearch
