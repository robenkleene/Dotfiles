if has("nvim")
  finish
endif

" Fix for italics in tmux
set t_ZH=[3m
set t_ZR=[23m

set background=dark

" Indent
" When opening lines, make it the same indent level as the current line
" Neovim defaults to `autoindent`
set autoindent

" Highlight search results
" This is important even when doing a substitution, because it makes clear
" when you might have false positives
" Neovim defaults to `hlsearch`
set hlsearch

" Fix a problem in Vim where a bunch of escaped junk is shown in the window
augroup focus_redraw
  autocmd!
  autocmd FocusGained * redraw!
augroup END

" Fix option key in Vim
let c='a'
while c <= 'z'
  exec "set <M-".tolower(c).">=\e".c
  exec "nnoremap \e".c." <M-".tolower(c).">"
  let c = nr2char(1+char2nr(c))
endw
