if !exists("*synstack")
  finish
endif

command! VimSyntaxColors :source $VIMRUNTIME/syntax/colortest.vim
command! VimSyntaxHighlight :source $VIMRUNTIME/syntax/hitest.vim

" Syntax Groups
function! s:SyntaxGroups()
  return join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'))
endfunc
" Echo Syntax Group
command! VimSyntaxGroupsEcho :echo <SID>SyntaxGroups()
" Yank Syntax Group
command! VimSyntaxGroupsYank :let @" = <SID>SyntaxGroups()|:let @+ = @"|:echo @"

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
command! SyntaxColorsEcho :echo <SID>SyntaxColors()
