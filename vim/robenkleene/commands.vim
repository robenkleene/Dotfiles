" vim:foldmethod=marker

" Commands {{{1
if exists("*synstack")
  " Syntax Groups
  function! s:SyntaxGroups()
    return join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'))
  endfunc
  " Echo Syntax Group
  command! EchoSyntaxGroups :echo <SID>SyntaxGroups()
  " Yank Syntax Group
  command! YankSyntaxGroups :let @" = <SID>SyntaxGroups()|:let @+ = @"|:echo @"

  " Syntax Colors
  function! s:SyntaxColors()
    let syntaxcolors = 'fg:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg")
    let syntaxcolors .= ' fg#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")
    let syntaxcolors .= ' bg:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg")
    let syntaxcolors .= ' bg#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg#")
    let syntaxcolors .= ' sp:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"sp")
    let syntaxcolors .= ' sp#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"sp#")
    let syntaxcolors .= ' italic:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"italic")
    let syntaxcolors .= ' reverse:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"reverse")
    let syntaxcolors .= ' inverse:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"inverse")
    let syntaxcolors .= ' standout:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"standout")
    let syntaxcolors .= ' underline:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"underline")
    let syntaxcolors .= ' undercurl:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"undercurl")
    return syntaxcolors
  endfunc
  " Echo Syntax Colors
  command! EchoSyntaxColors :echo <SID>SyntaxColors()
endif
command! RunHighlightTest :source $VIMRUNTIME/syntax/hitest.vim
command! RunColorTest :source $VIMRUNTIME/syntax/colortest.vim

command! -bang Q
      \ execute "%w !pbcopy" |
      \ if <bang>1 |
      \   execute "q" |
      \ else |
      \   execute "q<bang>" |
      \ endif

