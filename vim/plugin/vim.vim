if has("nvim")
  finish
endif

" Fix for italics in tmux
set t_ZH=[3m
set t_ZR=[23m

if $TERM_PROGRAM != "Apple_Terminal"
  set background=dark
endif

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

" Option-delete deletes the previous word in the terminal (MacVim already
" handles `<M-BS>`). Terminals send it either as `\e\x7f` or, with extended
" key reporting (`modifyOtherKeys`), as a sequence Vim decodes to `<M-BS>`,
" which otherwise inserts `ÿ`. An unused function key holds the `\e\x7f` key
" code, because Vim can't set `<M-BS>` directly and an `<Esc>` mapping would
" delay leaving insert mode.
if !has('gui_running')
  exec "set <F37>=\e\x7f"
  noremap! <F37> <C-w>
  noremap! <M-BS> <C-w>
endif
